USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_flag_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_flag_json
	PRINT '########## GRLS.c_model_flag_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_flag_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_model_id			int,
			@v_update_type		varchar(7)

	DECLARE @v_flag_list TABLE (
		flag_abbrev	char(8) NOT NULL,
		model_id	int		NULL,
		flag_id		int 	NULL
	)

	BEGIN TRY

		SET @v_model_sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."sobriquet"'))
		SET @v_update_type = (SELECT JSON_VALUE(@p_input_json, '$."update_type"'))

		IF @v_model_sobriquet IS NULL
   			RAISERROR ('The sobriquet value is not found - operation failed.', 16, 1)

		IF @v_update_type NOT IN ('add', 'replace')
   			RAISERROR ('Update type is not specified or invalid - operation failed.', 16, 1)

		IF NOT EXISTS (SELECT 1 FROM GRLS.model m WHERE m.sobriquet = @v_model_sobriquet)
			RAISERROR ('Model with sobriquet %s not found - operation failed.', 16, 1, @v_model_sobriquet)

		INSERT INTO @v_flag_list(flag_abbrev)
		SELECT
			f.flag_abbrev
		FROM 
			OPENJSON (@p_input_json, '$.model_flags')
			WITH
			(
				flag_abbrev	char(8)
			) f

		IF 	EXISTS (SELECT t.flag_abbrev /*COLLATE DATABASE_DEFAULT*/ FROM @v_flag_list t EXCEPT SELECT f.flag_abbrev FROM GRLS.flag f)
				RAISERROR ('There are invalid flags in the input json - operation failed.', 16, 1)

		SET @v_model_id = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @v_model_sobriquet)

		UPDATE 
			fl 
		SET 
			fl.model_id = @v_model_id,
			fl.flag_id = f.flag_id
		FROM 
			@v_flag_list fl 
			INNER JOIN GRLS.flag f 
			ON fl.flag_abbrev = f.flag_abbrev

		BEGIN TRANSACTION

		IF @v_update_type = 'replace'
			DELETE 
				mf 
			FROM 
				GRLS.model_flag mf 
			WHERE 
				mf.model_id = @v_model_id

		INSERT INTO GRLS.model_flag(model_id, flag_id)
		SELECT
			fl.model_id,
			fl.flag_id 
		FROM
			@v_flag_list fl 
			LEFT OUTER JOIN GRLS.model_flag mf 
			ON fl.model_id = mf.model_id AND fl.flag_id = mf.flag_id
		WHERE 
			mf.id IS NULL

		IF @p_debug = 1
			PRINT 'INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Transaction rolled back - no changes made'
		END

	END TRY

	BEGIN CATCH  
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int
	
		 IF @@TRANCOUNT != 0
		 	ROLLBACK TRANSACTION

		SELECT   
			@error_message = ERROR_MESSAGE(),  
			@error_severity = ERROR_SEVERITY(),  
			@error_state = ERROR_STATE();  

		RAISERROR (@error_message,
				@error_severity,
				@error_state
				)
	END CATCH

END
GO
PRINT '########## GRLS.c_model_flag_json created successfully ##########'

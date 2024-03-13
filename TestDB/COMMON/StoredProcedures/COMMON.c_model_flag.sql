USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_model_flag') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_model_flag
	PRINT '########## COMMON.c_model_flag dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_model_flag
	@p_flags			COMMON.flag_add_list READONLY,
	@p_model_sobriquet	GRLS.sobriquet,
	@p_update_type		char(1),
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @v_model_id int 
	SET @v_model_id = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @p_model_sobriquet)

	IF @v_model_id IS NULL
		RAISERROR ('Model with sobriquet %s not found - operation failed.', 16, 1, @p_model_sobriquet)

	IF @p_update_type NOT IN ('C', 'R')
   		RAISERROR ('Update type must be C or R - operation failed.', 16, 1)

	IF 	EXISTS (SELECT t.flag_abbrev FROM @p_flags t EXCEPT SELECT f.flag_abbrev FROM GRLS.flag f)
		RAISERROR ('There are invalid flags in the input data - operation failed.', 16, 1)

	BEGIN TRY

		BEGIN TRANSACTION

		IF @p_update_type = 'R'
			DELETE 
				mf 
			FROM 
				GRLS.model_flag mf 
			WHERE 
				mf.model_id = @v_model_id

		INSERT INTO GRLS.model_flag(model_id, flag_id)
		SELECT
			@v_model_id,
			f.flag_id 
		FROM
			@p_flags fl 
			LEFT OUTER JOIN GRLS.flag f 
			ON fl.flag_abbrev = f.flag_abbrev
			LEFT OUTER JOIN GRLS.model_flag mf 
			ON @v_model_id = mf.model_id AND f.flag_id = mf.flag_id
		WHERE 
			mf.id IS NULL

		IF @p_debug = 1
			PRINT 'FLAG INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'FLAG COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Flag insert transaction rolled back - no changes made'
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
PRINT '########## COMMON.c_model_flag created successfully ##########'

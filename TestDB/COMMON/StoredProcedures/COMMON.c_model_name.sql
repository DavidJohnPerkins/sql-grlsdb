USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_model_name') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_model_name
	PRINT '########## COMMON.c_model_name dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_model_name
	@p_names			COMMON.name_add_list READONLY,
	@p_model_sobriquet	GRLS.sobriquet,
	@p_update_type		char(1),
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @v_model_id     int,
			@v_p_name_count int

	SET @v_model_id = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @p_model_sobriquet)

	BEGIN TRY

		IF @v_model_id IS NULL
			RAISERROR ('Model with sobriquet %s not found - operation failed.', 16, 1, @p_model_sobriquet)

		IF @p_update_type NOT IN ('C', 'R')
			RAISERROR ('Update type must be C or R - operation failed.', 16, 1)

		SET @v_p_name_count = (SELECT COUNT(1) FROM @p_names mn WHERE mn.is_principal_name = 1)

		IF  @p_update_type = 'C' AND @v_p_name_count != 0
			RAISERROR ('Principal name can only be specified for update type R - operation failed.', 16, 1)

		IF @p_update_type = 'R' and @v_p_name_count != 1
			RAISERROR ('There must be one, and only one, principal name - operation failed.', 16, 1)

		BEGIN TRANSACTION

		IF @p_update_type = 'R'
			DELETE 
				mn
			FROM 
				GRLS.model_name mn 
			WHERE 
				mn.model_id = @v_model_id

		INSERT INTO GRLS.model_name(model_id, model_name, is_principal_name)
		SELECT
			@v_model_id,
			nl.model_name,
			nl.is_principal_name 
		FROM
			@p_names nl 
			LEFT OUTER JOIN GRLS.model_name mn
			ON @v_model_id = mn.model_id AND nl.model_name = mn.model_name COLLATE DATABASE_DEFAULT
		WHERE 
			mn.id IS NULL

		IF @p_debug = 1
			PRINT 'NAME UPDATES COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'NAME COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Name update transaction rolled back - no changes made'
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
PRINT '########## COMMON.c_model_name created successfully ##########'

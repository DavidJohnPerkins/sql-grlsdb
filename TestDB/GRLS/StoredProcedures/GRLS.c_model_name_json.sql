USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_name_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_name_json
	PRINT '########## GRLS.c_model_name_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_name_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_update_type		char(1),
			@v_names			COMMON.name_add_list

	BEGIN TRY

		SET @v_model_sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."sobriquet"'))
		SET @v_update_type = (SELECT JSON_VALUE(@p_input_json, '$."update_type"'))
		INSERT INTO @v_names(model_name, is_principal_name)
		SELECT
			n.model_name,
			n.is_principal_name
		FROM 
			OPENJSON (@p_input_json, '$.model_names')
			WITH
			(
				model_name          varchar(50),
				is_principal_name   bit
			) n

	EXEC COMMON.c_model_name @v_names, @v_model_sobriquet, @v_update_type

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
PRINT '########## GRLS.c_model_name_json created successfully ##########'

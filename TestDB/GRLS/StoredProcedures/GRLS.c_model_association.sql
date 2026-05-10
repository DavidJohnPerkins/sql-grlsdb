USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_association') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_association
	PRINT '########## GRLS.c_model_association dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_association
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_update_type		char(1),
			@v_associates		COMMON.string_add_list

	BEGIN TRY

		SET @v_model_sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."sobriquet"'))
		SET @v_update_type = (SELECT JSON_VALUE(@p_input_json, '$."update_type"'))

		INSERT INTO @v_associates (string_value)
		SELECT
			m.associate_sobriquet
		FROM 
			OPENJSON (@p_input_json, '$.model_associates')
			WITH
			(
				associate_sobriquet	GRLS.sobriquet
			) m

	EXEC COMMON.c_model_association @v_model_sobriquet, @v_associates, @v_update_type, @p_debug, @p_execute

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
PRINT '########## GRLS.c_model_association created successfully ##########'

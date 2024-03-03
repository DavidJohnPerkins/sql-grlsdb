USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_image_web_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_image_web_json
	PRINT '########## GRLS.c_model_image_web_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_image_web_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_update_type		char(1),
			@v_images			COMMON.web_image_add_list

	BEGIN TRY

		SET @v_model_sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."sobriquet"'))
		SET @v_update_type = (SELECT JSON_VALUE(@p_input_json, '$."update_type"'))
		INSERT INTO @v_images(image_url, image_type_abbrev, is_mono)
		SELECT
			i.image_url,
			i.image_type_abbrev,
			i.is_mono
		FROM 
			OPENJSON (@p_input_json, '$.images')
			WITH
			(
				image_url			GRLS.image_url, 
				image_type_abbrev	char(2),
				is_mono				bit
			) i

	EXEC COMMON.c_model_image_web @v_images, @v_model_sobriquet, @v_update_type

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
PRINT '########## GRLS.c_model_image_web_json created successfully ##########'

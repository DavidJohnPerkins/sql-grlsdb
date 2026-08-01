USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_contact_sheet') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_contact_sheet
	PRINT '########## GRLS.r_contact_sheet dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_contact_sheet
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @images TABLE (
		image_name varchar(200)
	)

	BEGIN TRY 

		IF @p_execute = 1
		BEGIN
			INSERT INTO @images (image_name)
			SELECT value
			FROM OPENJSON(@p_input_json);

			WITH w_sql_image AS (
				SELECT 
					i.image_url,
					im.model_id
				FROM 
					GRLS.image_model im 
					INNER JOIN GRLS.[image] i
					ON im.image_id = i.image_id
				WHERE
					im.image_type_id = 1
			)
			SELECT 
				i.image_name,
				ISNULL(s.model_id, 0) AS model_id
			FROM 
				@images i 
				LEFT OUTER JOIN w_sql_image s
				ON i.image_name = s.image_url
			ORDER BY 
				i.image_name
		END
	END TRY

	BEGIN CATCH  
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int

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
PRINT '########## GRLS.r_contact_sheet created successfully ##########'

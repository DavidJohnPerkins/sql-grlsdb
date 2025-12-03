USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_web') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_web
	PRINT '########## GRLS.c_model_web dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_web
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON
	DECLARE @base_attribs		COMMON.base_attrib_add_list,
			@attribs			COMMON.attrib_add_list,
			@model_names		COMMON.name_add_list,
			@model_images		COMMON.web_image_add_list,
			@model_flags		COMMON.flag_add_list,
			@a					GRLS.kv_pair,
			@model_id			int

	BEGIN TRY

		INSERT INTO @a 
		SELECT
			[key],
			[value] 
		FROM OPENJSON (@p_input_json)

		INSERT INTO @base_attribs
		SELECT
			GRLS.get_key_value(@a, 'sobriquet'),
			CONVERT(int, GRLS.get_key_value(@a, 'hq')),
			GRLS.get_key_value(@a, 'yob'),
			CONVERT(nvarchar(MAX), GRLS.get_key_value(@a, 'description'))

		INSERT INTO @model_names
		SELECT
			[value],
			CASE WHEN [ordinal] = 1 THEN 1 ELSE 0 END
		FROM
			STRING_SPLIT(GRLS.get_key_value(@a, 'names'), '|', 1)

		INSERT INTO @model_images
		SELECT
			SUBSTRING(a.key_value, 6, 2),
			0,
			a.data_value
		FROM
			@a a
		WHERE 
			a.key_value LIKE 'image%'

		INSERT INTO @model_flags
		SELECT
			SUBSTRING(a.key_value, 6, 8)
		FROM
			@a a
		WHERE 
			a.key_value LIKE 'flag%'

		INSERT INTO @attribs
		SELECT
			SUBSTRING(a.key_value, 3, 4),
			CONVERT(float, SUBSTRING(a.data_value, CHARINDEX('(', a.data_value) + 1, 3)),
			LEFT(a.data_value, CHARINDEX('(', a.data_value) - 1),
			1
		FROM
			@a a
		WHERE 
			a.key_value LIKE 'a[_]%'

		EXEC COMMON.c_model @base_attribs, @attribs, @model_names, @model_images, @model_flags, @p_debug, @p_execute, @r_model_id = @model_id OUTPUT

		SELECT @model_id

	END TRY

	BEGIN CATCH  
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int
	
		-- IF @@TRANCOUNT != 0			-- Not required here but retain for completeness
		-- 	ROLLBACK TRANSACTION

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
PRINT '########## GRLS.c_model_web created successfully ##########'

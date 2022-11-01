USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_image_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_image_json
	PRINT '########## GRLS.c_image_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_image_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @base_attribs		COMMON.base_attrib_add_list_image,
			@models				COMMON.image_model_add_list,
			@attribs			COMMON.attrib_add_list,
			@image_url			GRLS.image_url,
			@is_monochrome		bit,
			@base_attribs_json	COMMON.json,
			@models_json		COMMON.json,
			@attribs_json		COMMON.json

	BEGIN TRY

		;WITH w_top_level AS (
			SELECT
				c.base_attribs	AS base_attribs,
				c.models		AS models,
				c.attribs 		AS attribs
			FROM OPENJSON (@p_input_json)
			WITH
			(
				base_attribs	COMMON.json AS JSON,
				models			COMMON.json AS JSON,
				attribs 		COMMON.json AS JSON
			) c
		)
		SELECT
			@base_attribs_json	= w.base_attribs,
			@models_json		= w.models,
			@attribs_json		= w.attribs
		FROM 
			w_top_level w

		INSERT INTO @base_attribs
		SELECT
			a.image_url,
			a.is_monochrome
		FROM OPENJSON(@base_attribs_json)
		WITH (
			image_url		GRLS.image_url, 
			is_monochrome	bit
		) a

		INSERT INTO @models
		SELECT
			a.sobriquet
		FROM OPENJSON (@models_json)
		WITH
		(
			sobriquet	GRLS.sobriquet
		) a
		
		INSERT INTO @attribs
		SELECT
			a.ia_abbrev,
			b.ia_l2_desc,
			b.selected
		FROM OPENJSON (@attribs_json)
		WITH
		(
			ia_abbrev	GRLS.l1_abbrev,
			options		COMMON.json AS JSON
		) a
		CROSS APPLY OPENJSON (a.options)
		WITH
		(
			ia_l2_desc	GRLS.l2_desc,
			selected	bit
		) b

		EXEC COMMON.c_image @base_attribs, @models, @attribs, @p_debug, @p_execute

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
PRINT '########## GRLS.c_image_json created successfully ##########'

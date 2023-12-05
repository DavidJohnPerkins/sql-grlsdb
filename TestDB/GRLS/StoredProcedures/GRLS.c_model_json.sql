USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_json
	PRINT '########## GRLS.c_model_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @base_attribs		COMMON.base_attrib_add_list,
			@attribs			COMMON.attrib_add_list,
			@model_names		COMMON.name_add_list,
			@sobr				GRLS.sobriquet,
			@hquo				int,
			@yob				int,
			@names_json			COMMON.json,
			@attribs_json		COMMON.json,
			@base_attribs_json	COMMON.json

	BEGIN TRY

		;WITH w_top_level AS (
			SELECT
				c.base_attribs	AS base_attribs,
				c.model_names	AS model_names,
				c.attribs 		AS attribs
			FROM OPENJSON (@p_input_json)
			WITH
			(
				base_attribs	COMMON.json AS JSON,
				model_names 	COMMON.json AS JSON,
				attribs 		COMMON.json AS JSON
			) c
		)
		SELECT
			@base_attribs_json	= w.base_attribs,
			@names_json			= w.model_names,
			@attribs_json		= w.attribs
		FROM 
			w_top_level w

		INSERT INTO @base_attribs
		SELECT
			a.sobriquet,
			a.hot_quotient,
			a.yob
		FROM OPENJSON(@base_attribs_json)
		WITH (
			sobriquet		GRLS.sobriquet, 
			hot_quotient 	int,
			yob				int
		) a

		INSERT INTO @model_names
		SELECT
			a.model_name,
			a.principal_name
		FROM OPENJSON (@names_json)
		WITH
		(
			model_name		varchar(50),
			principal_name	bit
		) a

		INSERT INTO @attribs
		SELECT
			a.abbrev,
			a.standout_factor,
			b.l2_desc,
			b.selected
		FROM OPENJSON (@attribs_json)
		WITH
		(
			abbrev				GRLS.l1_abbrev,
			standout_factor 	float,
			options				COMMON.json AS JSON
		) a
		CROSS APPLY OPENJSON (a.options)
		WITH
		(
			l2_desc		GRLS.l2_desc,
			selected	bit
		) b

		EXEC COMMON.c_model @base_attribs, @attribs, @model_names, @p_debug, @p_execute

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
PRINT '########## GRLS.c_model_json created successfully ##########'

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_attribute_scheme') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_attribute_scheme
	PRINT '########## GRLS.c_attribute_scheme dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_attribute_scheme
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @scheme_attribs			COMMON.scheme_attrib_add_list,
			@prefs					COMMON.scheme_preference_add_list,
			@prefs_json				COMMON.json,
			@scheme_attribs_json	COMMON.json

	BEGIN TRY

		;WITH w_top_level AS (
			SELECT
				c.scheme_attribs	AS scheme_attribs,
				c.preferences 		AS preferences
			FROM OPENJSON (@p_input_json)
			WITH
			(
				scheme_attribs	COMMON.json AS JSON,
				preferences		COMMON.json AS JSON
			) c
		)
		SELECT
			@scheme_attribs_json	= w.scheme_attribs,
			@prefs_json				= w.preferences
		FROM 
			w_top_level w

		INSERT INTO @scheme_attribs
		SELECT
			a.scheme_abbrev,
			a.scheme_desc,
			a.active
		FROM OPENJSON(@scheme_attribs_json)
		WITH (
			scheme_abbrev 	varchar(20), 
			scheme_desc		varchar(50),
			active			bit
		) a

		INSERT INTO @prefs
		SELECT
			a.abbrev,
			a.attr_weight,
			b.l2_desc,
			b.preference
		FROM OPENJSON (@prefs_json)
		WITH
		(
			abbrev			GRLS.l1_abbrev,
			attr_weight		int,
			options			COMMON.json AS JSON
		) a
		CROSS APPLY OPENJSON (a.options)
		WITH
		(
			l2_desc		GRLS.l2_desc,
			preference	int
		) b

		IF @p_debug = 1 
		BEGIN
			SELECT * FROM @scheme_attribs
			SELECT * FROM @prefs
		END 

		EXEC COMMON.c_attribute_scheme @scheme_attribs, @prefs, @p_debug, @p_execute

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
PRINT '########## GRLS.c_attribute_scheme created successfully ##########'

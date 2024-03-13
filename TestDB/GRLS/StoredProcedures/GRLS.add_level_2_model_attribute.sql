SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.add_level_2_model_attribute') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.add_level_2_model_attribute
	PRINT '########## GRLS.add_level_2_model_attribute dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.add_level_2_model_attribute (
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1
)
AS
BEGIN 

	DECLARE	@v_l1_abbrev			GRLS.l1_abbrev,
			@v_l2_desc				GRLS.l2_desc,
			@v_preferences_json		COMMON.json,
			@new_l2_id 				int

	DECLARE @v_preferences TABLE (
		scheme_id	int,
		preference 	int
	)

	BEGIN TRY
		
		SELECT
			@v_l1_abbrev		= c.l1_abbrev,
			@v_l2_desc			= c.l2_desc
		FROM OPENJSON (@p_input_json)
		WITH
		(
			l1_abbrev			GRLS.l1_abbrev,
			l2_desc				GRLS.l2_desc
		) c

		INSERT INTO @v_preferences
		SELECT
			b.scheme_id,
			b.l2_preference
		FROM OPENJSON (@p_input_json)
		WITH
		(
			preferences		COMMON.json AS JSON
		) a
		CROSS APPLY OPENJSON (a.preferences)
		WITH
		(
			scheme_id		int,
			l2_preference	int
		) b

		IF NOT EXISTS (SELECT 1 FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @v_l1_abbrev)
			RAISERROR ('Level 1 attribute %s not found.', 16, 1, @v_l1_abbrev)

		IF EXISTS (
			SELECT 
				1 
			FROM 
				GRLS.attribute_level_1 l1 
				INNER JOIN GRLS.attribute_level_2 l2
				ON l1.l1_id = l2.l1_id
			WHERE 
				l1.abbrev = @v_l1_abbrev AND 
				l2.l2_desc = @v_l2_desc
			)
			RAISERROR ('Attribute %s / %s already exists.', 16, 1, @v_l1_abbrev, @v_l2_desc)

		IF (SELECT COUNT(scheme_id) FROM @v_preferences) != (SELECT COUNT(scheme_id) FROM GRLS.attribute_scheme)
			RAISERROR ('There are missing or invalid schemes - operation failed.', 16, 1)

		IF 	EXISTS (SELECT a.scheme_id FROM @v_preferences a EXCEPT SELECT b.scheme_id FROM GRLS.attribute_scheme b) OR
			EXISTS (SELECT a.scheme_id FROM GRLS.attribute_scheme a EXCEPT SELECT b.scheme_id FROM @v_preferences b)
				RAISERROR ('There are missing or invalid schemes - operation failed.', 16, 1)

		BEGIN TRANSACTION

		INSERT INTO GRLS.attribute_level_2 (l1_id, l2_desc)
		SELECT
			l1.l1_id,
			@v_l2_desc
		FROM
			GRLS.attribute_level_1 l1
		WHERE 
			l1.abbrev = @v_l1_abbrev

		SET @new_l2_id = @@IDENTITY

		IF @p_debug = 1
		BEGIN
			PRINT @new_l2_id 
			PRINT @v_l1_abbrev 
		END

		INSERT INTO GRLS.attribute_level_2_detail (l2_id, scheme_id, l2_preference)
		SELECT
			@new_l2_id,
			p.scheme_id,
			p.preference
		FROM 
			@v_preferences p
		ORDER BY 
			p.scheme_id

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Transaction rolled back - no changes made'
		END

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION

	    DECLARE @ErrorMessage 	nvarchar(4000);  
	    DECLARE @ErrorSeverity	int;  
    	DECLARE @ErrorState		int;  
  
		SELECT   
			@ErrorMessage = ERROR_MESSAGE(),  
			@ErrorSeverity = ERROR_SEVERITY(),  
			@ErrorState = ERROR_STATE();  
  
	    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO
PRINT '########## GRLS.add_level_2_model_attribute created successfully ##########'

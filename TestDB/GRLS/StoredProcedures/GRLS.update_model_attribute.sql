USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS GRLS.update_model_attribute
GO

CREATE PROCEDURE GRLS.update_model_attribute (
	@p_input_json		COMMON.json
)
AS
BEGIN 

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_l1_abbrev		GRLS.l1_abbrev,
			@v_l2_desc			GRLS.l2_desc

	BEGIN TRY
		
		SELECT
			@v_model_sobriquet	= c.model_sobriquet,
			@v_l1_abbrev		= c.l1_abbrev,
			@v_l2_desc			= c.l2_desc
		FROM OPENJSON (@p_input_json)
		WITH
		(
			model_sobriquet		GRLS.sobriquet,
			l1_abbrev			GRLS.l1_abbrev,
			l2_desc				GRLS.l2_desc
		) c

		IF NOT EXISTS (SELECT 1 FROM GRLS.model m WHERE m.sobriquet = @v_model_sobriquet)
			RAISERROR ('Model with sobriquet %s not found.', 16, 1, @v_model_sobriquet)

		IF NOT EXISTS (SELECT 1 FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @v_l1_abbrev)
			RAISERROR ('Level 1 attribute %s not found.', 16, 1, @v_l1_abbrev)

		IF NOT EXISTS (
			SELECT
				1 
			FROM
				GRLS.attribute_level_2 l2
				INNER JOIN GRLS.attribute_level_1 l1
				ON l2.l1_id = l1.l1_id
			WHERE
				l2.l2_desc = @v_l2_desc AND
				l1.abbrev = @v_l1_abbrev
			)
			RAISERROR ('Level 2 attribute %s not found for level 1 attribute %s.', 16, 1, @v_l2_desc, @v_l1_abbrev)

			BEGIN TRANSACTION

			;WITH w_ma_id AS (
				SELECT
					att.id
				FROM
					GRLS.v_attribute_list att 
				WHERE 
					att.sobriquet = @v_model_sobriquet AND
					att.abbrev = @v_l1_abbrev
			)	
			DELETE
				ma
			FROM
				GRLS.model_attribute ma
				INNER JOIN w_ma_id w 
				ON ma.id = w.id

			INSERT INTO GRLS.model_attribute
				SELECT
					m.id,
					l2.l2_id
				FROM
					GRLS.v_attribute_level_2 l2,
					GRLS.model m
				WHERE 
					m.sobriquet = @v_model_sobriquet AND
					l2.abbrev = @v_l1_abbrev AND
					l2.l2_desc = @v_l2_desc

			COMMIT TRANSACTION

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
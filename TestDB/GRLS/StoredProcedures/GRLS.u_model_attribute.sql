USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.u_model_attribute') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.u_model_attribute
	PRINT '########## GRLS.u_model_attribute dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.u_model_attribute (
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1
)
AS
BEGIN 

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_l1_abbrev		GRLS.l1_abbrev,
			@v_l2_desc			GRLS.l2_desc,
			@v_standout_factor	float

	BEGIN TRY
		
		SELECT
			@v_model_sobriquet	= c.model_sobriquet,
			@v_l1_abbrev		= c.l1_abbrev,
			@v_l2_desc			= c.l2_desc,
			@v_standout_factor	= c.standout_factor
		FROM OPENJSON (@p_input_json)
		WITH
		(
			model_sobriquet		GRLS.sobriquet,
			l1_abbrev			GRLS.l1_abbrev,
			l2_desc				GRLS.l2_desc,
			standout_factor		float
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
		UPDATE
			ma
		SET 
			ma.valid_to = GETDATE()
		FROM
			GRLS.model_attribute ma
			INNER JOIN w_ma_id w 
			ON ma.id = w.id

		IF @p_debug = 1
			PRINT 'ROW UPDATE COMPLETE'

		INSERT INTO GRLS.model_attribute
			SELECT
				m.id,
				l2.l2_id,
				@v_standout_factor,
				GETDATE(),
				NULL
			FROM
				GRLS.v_attribute_level_2 l2,
				GRLS.model m
			WHERE 
				m.sobriquet = @v_model_sobriquet AND
				l2.abbrev = @v_l1_abbrev AND
				l2.l2_desc = @v_l2_desc

		IF @p_debug = 1
			PRINT 'INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'COMMIT COMPLETE'
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
PRINT '########## GRLS.u_model_attribute created successfully ##########'
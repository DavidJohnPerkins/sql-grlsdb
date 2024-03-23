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

	DECLARE @v_sobr			GRLS.sobriquet 	= (SELECT JSON_VALUE(@p_input_json, '$."model_sobriquet"')),
			@v_l1_abbrev	GRLS.l1_abbrev	= (SELECT JSON_VALUE(@p_input_json, '$."l1_abbrev"')),
			@v_l2_desc		varchar(50)		= (SELECT JSON_VALUE(@p_input_json, '$."l2_desc"')),
			@v_sof			float			= (SELECT JSON_VALUE(@p_input_json, '$."standout_factor"'))

	DECLARE @v_model_id	int 	= (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @v_sobr),
			@v_l1_id	int 	= (SELECT l1.l1_id FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @v_l1_abbrev),
			@v_l2_id	int 	= (SELECT l2.l2_id FROM GRLS.attribute_level_2 l2 WHERE l2.l2_desc = @v_l2_desc)

	BEGIN TRY
		
		IF @v_model_id IS NULL
			RAISERROR ('Model with sobriquet %s not found.', 16, 1, @v_sobr)

		IF @v_l1_id IS NULL
			RAISERROR ('Level 1 attribute with abbrev %s not found.', 16, 1, @v_l1_abbrev)

		IF NOT EXISTS (
			SELECT
				1 
			FROM
				GRLS.attribute_level_2 l2
				INNER JOIN GRLS.attribute_level_1 l1
				ON l2.l1_id = l1.l1_id
			WHERE
				l2.l2_id = @v_l2_id AND
				l1.l1_id = @v_l1_id
			)
			RAISERROR ('Level 2 attribute with desc %s not found for level 1 attribute with abbrev %s.', 16, 1, @v_l2_desc, @v_l1_abbrev)

		BEGIN TRANSACTION

		;WITH w_ma_id AS (
			SELECT
				ma.*
			FROM
				GRLS.model_attribute ma 
				INNER JOIN GRLS.attribute_level_2 l2 
					INNER JOIN GRLS.attribute_level_1 l1 
					ON l2.l1_id = l1.l1_id
				ON ma.attribute_id = l2.l2_id
			WHERE 
				ma.model_id = @v_model_id AND
				l1.l1_id = @v_l1_id AND 
				ma.valid_to IS NULL
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

		INSERT INTO GRLS.model_attribute (model_id, attribute_id, standout_factor, valid_from, valid_to)
		 VALUES (@v_model_id, @v_l2_id, @v_sof, GETDATE(), NULL)

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

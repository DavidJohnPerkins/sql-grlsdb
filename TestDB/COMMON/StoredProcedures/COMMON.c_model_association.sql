USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_model_association') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_model_association
	PRINT '########## COMMON.c_model_association dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_model_association
	@p_model_sobriquet	GRLS.sobriquet,
	@p_associate_list	COMMON.string_add_list READONLY,
	@p_update_type		char(1),
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @v_model_id int 
	SET @v_model_id = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @p_model_sobriquet)

	IF @v_model_id IS NULL
		RAISERROR ('Model with sobriquet %s not found - operation failed.', 16, 1, @p_model_sobriquet)

	IF @p_update_type NOT IN ('C', 'R')
   		RAISERROR ('Update type must be C or R - operation failed.', 16, 1)

	IF EXISTS (SELECT 1 FROM @p_associate_list l LEFT OUTER JOIN GRLS.model m ON l.string_value = m.sobriquet COLLATE DATABASE_DEFAULT WHERE m.sobriquet IS NULL)
   		RAISERROR ('One or more associated model sobriquets not found for supplied list - operation failed.', 16, 1)

	BEGIN TRY

		BEGIN TRANSACTION

		IF @p_update_type = 'R'
			DELETE 
				mm
			FROM 
				GRLS.movie_model mm
			WHERE 
				mm.model_id = @v_model_id

		IF @p_debug = 1
			SELECT l.string_value, m.* FROM @p_associate_list l LEFT OUTER JOIN GRLS.model m ON l.string_value = m.sobriquet COLLATE DATABASE_DEFAULT WHERE m.sobriquet IS NULL			

		INSERT INTO GRLS.model_associate(model_id, associated_model_id)
		SELECT
			@v_model_id,
			am.id
		FROM
			@p_associate_list l 
			INNER JOIN GRLS.model am 
			ON l.string_value = am.sobriquet COLLATE DATABASE_DEFAULT 

		INSERT INTO GRLS.model_associate(model_id, associated_model_id)
		SELECT
			am.id,
			@v_model_id
		FROM
			@p_associate_list l 
			INNER JOIN GRLS.model am 
			ON l.string_value = am.sobriquet COLLATE DATABASE_DEFAULT

		IF @p_debug = 1
			PRINT 'MODEL ASSOCIATE INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'MODEL ASSOCIATE COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Model associate insert transaction rolled back - no changes made'
		END

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
PRINT '########## COMMON.c_model_association created successfully ##########'

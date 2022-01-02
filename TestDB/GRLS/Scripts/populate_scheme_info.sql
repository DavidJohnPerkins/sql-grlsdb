USE TestDB
GO

DECLARE @scheme_id int

BEGIN TRY

	IF NOT EXISTS (SELECT 1 FROM GRLS.attribute_scheme s WHERE s.scheme_desc = 'Favouring Late Adolescence')
	BEGIN
	
		BEGIN TRANSACTION

		INSERT INTO GRLS.attribute_scheme (scheme_desc, active)
		VALUES ('Favouring Late Adolescence', 1)
		SET @scheme_id = @@IDENTITY

		UPDATE
			l1
		SET 
			l1.scheme_id = @scheme_id
		FROM
			GRLS.attribute_level_1 l1 

		UPDATE
			l2
		SET 
			l2.scheme_id = @scheme_id
		FROM
			GRLS.attribute_level_2 l2

		COMMIT TRANSACTION

	END
	
END TRY
BEGIN CATCH
   SELECT  
		ERROR_NUMBER() AS ErrorNumber , 
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure,  
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage

	ROLLBACK
END CATCH

GO

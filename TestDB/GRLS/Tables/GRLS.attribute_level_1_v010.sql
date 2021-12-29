USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

BEGIN TRY

	BEGIN TRANSACTION

	ALTER TABLE GRLS.attribute_level_1
		ADD scheme_id	int		NULL

	CREATE UNIQUE CLUSTERED INDEX U_IDX_schemeid_l1id ON GRLS.attribute_level_1 (scheme_id, l1_id) ON [PRIMARY];

	ALTER TABLE GRLS.attribute_level_1
		ADD CONSTRAINT FK_attr_level_1_attr_scheme FOREIGN KEY (scheme_id) REFERENCES GRLS.attribute_scheme(scheme_id)
			ON DELETE CASCADE

	COMMIT TRANSACTION

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

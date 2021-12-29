USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

BEGIN TRY

	BEGIN TRANSACTION

	ALTER TABLE GRLS.attribute_level_2
		ADD scheme_id	int		NULL

	DROP INDEX U_IDX_l1_l2 ON GRLS.attribute_level_2

	CREATE UNIQUE CLUSTERED INDEX U_IDX_schemeid_l1id_l2id ON GRLS.attribute_level_2 (scheme_id, l1_id, l2_id) ON [PRIMARY];

	ALTER TABLE GRLS.attribute_level_2
		ADD CONSTRAINT FK_attr_level_2_attr_scheme FOREIGN KEY (scheme_id) REFERENCES GRLS.attribute_scheme(scheme_id)
			ON DELETE NO ACTION

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
ROLLBACK

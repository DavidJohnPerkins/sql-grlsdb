USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @pk_name	varchar(255),
		@i			int

BEGIN TRY

	BEGIN TRANSACTION

	ALTER TABLE GRLS.attribute_level_2
		DROP CONSTRAINT FK_attr_level_2_attr_level_1

	ALTER TABLE GRLS.model_attribute
		DROP CONSTRAINT FK_model_attr_attr_l2

	SET @pk_name = (SELECT [name] FROM sys.key_constraints WHERE [type] = 'PK' AND OBJECT_NAME(parent_object_id) = N'attribute_level_1')
	SET @pk_name = 'ALTER TABLE GRLS.attribute_level_1 DROP CONSTRAINT ' + @pk_name
	EXEC (@pk_name)

	SET @pk_name = (SELECT [name] FROM sys.key_constraints WHERE [type] = 'PK' AND OBJECT_NAME(parent_object_id) = N'attribute_level_2')
	SET @pk_name = 'ALTER TABLE GRLS.attribute_level_2 DROP CONSTRAINT ' + @pk_name
	EXEC (@pk_name)


	ALTER TABLE GRLS.attribute_level_1
		ADD CONSTRAINT PK_attribute_level_1_l1_id PRIMARY KEY NONCLUSTERED (l1_id);

	ALTER TABLE GRLS.attribute_level_2
		ADD CONSTRAINT PK_attribute_level_2_l2_id PRIMARY KEY NONCLUSTERED (l2_id);
		
	ALTER TABLE GRLS.attribute_level_2 
		ADD CONSTRAINT FK_attr_level_2_attr_level_1 FOREIGN KEY (l1_id) REFERENCES GRLS.attribute_level_1(l1_id)
			ON DELETE CASCADE

	ALTER TABLE GRLS.model_attribute 
		ADD CONSTRAINT FK_model_attr_attr_l2 FOREIGN KEY (attribute_id) REFERENCES GRLS.attribute_level_2(l2_id)
			ON DELETE CASCADE

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

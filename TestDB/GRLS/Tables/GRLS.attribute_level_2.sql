USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
IF OBJECT_ID('GRLS.attribute_level_2', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_l1_l2 ON Grls.attribute_level2

	ALTER TABLE GRLS.attribute_level_2 
	DROP CONSTRAINT FK_attr_level_2_attr_level_1

	DROP TABLE GRLS.attribute_level_2

END
GO

CREATE TABLE GRLS.attribute_level_2
(
	l2_id			int IDENTITY(1, 1) NOT NULL ,
	l1_id			int NOT NULL ,
	l2_desc			varchar(50) ,
	l2_preference	int NULL
)
GO
ALTER TABLE GRLS.attribute_level_2 ADD PRIMARY KEY NONCLUSTERED
(
	l2_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_l1_l2 ON GRLS.attribute_level_2 (l1_id, l2_id) ON [PRIMARY];
GO

ALTER TABLE GRLS.attribute_level_2 
	ADD CONSTRAINT FK_attr_level_2_attr_level_1 FOREIGN KEY (l1_id) REFERENCES GRLS.attribute_level_1(l1_id)
		ON DELETE CASCADE;
GO
*/

/*
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
*/
/*
BEGIN TRY

	BEGIN TRANSACTION

	ALTER TABLE GRLS.attribute_level_2
		DROP CONSTRAINT FK_attr_level_2_attr_scheme

	DROP INDEX U_IDX_schemeid_l1id_l2id ON GRLS.attribute_level_2

	ALTER TABLE GRLS.attribute_level_2
		DROP COLUMN scheme_id 

	ALTER TABLE GRLS.attribute_level_2
		DROP COLUMN l2_preference

	COMMIT TRANSACTION

END TRY
*/

BEGIN TRY
		ALTER TABLE GRLS.attribute_level_2
		ADD l2_sort_order int
		PRINT '########## Column l2_sort_order added to GRLS.attribute_level_2 successfully ##########'
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

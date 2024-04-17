USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.model_name', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_modelid_nameid ON GRLS.model_name

	ALTER TABLE GRLS.model_name
	DROP CONSTRAINT FK_model_name_model

	DROP TABLE GRLS.model_name

END
GO
CREATE TABLE GRLS.model_name
(
	id				int IDENTITY(1, 1)	NOT NULL ,
	model_id		int					NOT NULL ,
	model_name		varchar(50)			NOT NULL ,
	principal_name	bit 				NOT NULL
)
GO
ALTER TABLE GRLS.model_name ADD PRIMARY KEY NONCLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_modelid_nameid ON GRLS.model_name (model_id, id) ON [PRIMARY];
GO
ALTER TABLE GRLS.model_name ADD CONSTRAINT FK_model_name_model FOREIGN KEY (model_id) REFERENCES GRLS.model(id) ON DELETE CASCADE;
GO
EXEC sp_rename 'GRLS.model_name.principal_name' , 'is_principal_name', 'COLUMN'


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.model', 'U') IS NOT NULL
DROP TABLE GRLS.model

IF OBJECT_ID('GRLS.model', 'U') IS NOT NULL
BEGIN
	DROP TABLE GRLS.model

END
GO

CREATE TABLE GRLS.model(
	id			int IDENTITY(1, 1) NOT NULL,
	sobriquet	varchar(50) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE GRLS.model ADD PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


IF EXISTS (SELECT 1 FROM sys.indexes WHERE [name] = N'U_IDX_model_sobriquet' AND object_id = OBJECT_ID('GRLS.model'))
BEGIN
	DROP INDEX U_IDX_model_sobriquet ON GRLS.model
	PRINT '########## Index U_IDX_model_sobriquet ON GRLS.model dropped successfully ##########'
END

CREATE UNIQUE INDEX U_IDX_model_sobriquet ON GRLS.model (sobriquet) ON [PRIMARY];
GO
PRINT '########## Index U_IDX_model_sobriquet ON GRLS.model created successfully ##########'

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [name] = N'year_of_birth' AND [object_id] = object_id(N'GRLS.model'))
BEGIN
	ALTER TABLE GRLS.model  
	ADD year_of_birth int null
	PRINT '########## Column year_of_birth added to GRLS.model successfully ##########'
END


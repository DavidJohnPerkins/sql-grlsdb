USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.flag_type', 'U') IS NOT NULL
	DROP INDEX IF EXISTS U_IDX_flagtype_abbrev ON GRLS.flag_type
	DROP TABLE GRLS.flag_type
GO

CREATE TABLE GRLS.flag_type
(
	id					int IDENTITY(1, 1)	NOT NULL PRIMARY KEY,
	flag_type_abbrev	char(3)				NOT NULL,
	flag_type_desc		varchar(50)			NOT NULL
)
GO
CREATE UNIQUE INDEX U_IDX_flagtype_abbrev ON GRLS.flag_type(flag_type_abbrev) ON [PRIMARY];
GO

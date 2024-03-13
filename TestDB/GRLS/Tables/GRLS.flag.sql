USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.flag', 'U') IS NOT NULL
	DROP TABLE GRLS.flag
GO

CREATE TABLE GRLS.flag
(
	flag_id				int IDENTITY(1, 1)	NOT NULL PRIMARY KEY,
	flag_abbrev			char(8)				NOT NULL,
	flag_desc			varchar(50)			NOT NULL
)
GO
CREATE UNIQUE INDEX U_IDX_flag_abbrev ON GRLS.flag(flag_abbrev) ON [PRIMARY];
GO

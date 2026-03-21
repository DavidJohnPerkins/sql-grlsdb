USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.flag', 'U') IS NOT NULL
	DROP INDEX IF EXISTS U_IDX_flag_type_flag_abbrev ON GRLS.flag
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

ALTER TABLE GRLS.flag ADD flag_type int 
UPDATE 
	f 
SET 
	f.flag_type = 1
FROM 
	GRLS.flag f

ALTER TABLE GRLS.flag
	ADD CONSTRAINT FK_flag_flag_type FOREIGN KEY (flag_type) REFERENCES GRLS.flag_type(id)
GO

DROP INDEX IF EXISTS U_IDX_flag_abbrev ON GRLS.flag
GO
CREATE UNIQUE INDEX U_IDX_flag_type_flag_abbrev ON GRLS.flag(flag_type, flag_abbrev) ON [PRIMARY];
GO


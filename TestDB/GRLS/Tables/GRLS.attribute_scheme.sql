USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
DROP TABLE IF EXISTS GRLS.attribute_scheme

CREATE TABLE GRLS.attribute_scheme(
	scheme_id		int IDENTITY(1, 1) NOT NULL,
	scheme_desc		varchar(50) NOT NULL,
	active			bit
) ON [PRIMARY]
GO

ALTER TABLE GRLS.attribute_scheme ADD PRIMARY KEY CLUSTERED 
(
	scheme_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
*/

ALTER TABLE GRLS.attribute_scheme
	ADD scheme_abbrev	varchar(20)

UPDATE 
	s 
SET 
	s.scheme_abbrev = CONVERT(char, s.scheme_id)
FROM
	GRLS.attribute_scheme s 

CREATE UNIQUE INDEX U_IDX_attr_scheme_abbrev ON GRLS.attribute_scheme (scheme_abbrev) ON [PRIMARY];

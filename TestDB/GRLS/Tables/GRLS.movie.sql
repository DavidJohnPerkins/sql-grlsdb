USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.movie', 'U') IS NOT NULL
BEGIN
	DROP TABLE GRLS.movie
	PRINT '########## Table GRLS.movie dropped successfully ##########'
END
GO
CREATE TABLE GRLS.movie
(
	id				int IDENTITY(1, 1)	NOT NULL,
	title			varchar(255)		NOT NULL,
	participants	int					NOT NULL,
	rating			int					NOT NULL
)
GO
ALTER TABLE GRLS.movie ADD PRIMARY KEY
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
PRINT '########## Table GRLS.movie created successfully ##########'

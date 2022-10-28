USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.attribute_level_1_group', 'U') IS NOT NULL
BEGIN
	DROP TABLE GRLS.attribute_level_1_group
	PRINT '########## Table GRLS.attribute_level_1_group dropped successfully ##########'
END
GO
CREATE TABLE GRLS.attribute_level_1_group
(
	l1_group_id			int IDENTITY(1, 1)	NOT NULL ,
	l1_group_abbrev		varchar(10),
	l1_group_desc		varchar(50)
)
GO
ALTER TABLE GRLS.attribute_level_1_group ADD PRIMARY KEY CLUSTERED 
(
	l1_group_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
PRINT '########## Table GRLS.attribute_level_1_group created successfully ##########'

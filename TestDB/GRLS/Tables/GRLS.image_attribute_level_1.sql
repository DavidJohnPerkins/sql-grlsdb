USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image_attribute_level_1', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_modelid_imageid ON GRLS.image

	DROP TABLE GRLS.image_attribute_level_1
	PRINT '########## Table GRLS.image_attribute_level_1 dropped successfully ##########'
END
GO
CREATE TABLE GRLS.image_attribute_level_1
(
	ia_l1_id		int IDENTITY(1, 1)	NOT NULL,
	ia_l1_desc		varchar(50)			NOT NULL ,
	ia_abbrev		char(4)				NOT NULL
)
GO
ALTER TABLE GRLS.image_attribute_level_1 ADD PRIMARY KEY CLUSTERED 
(
	ia_l1_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
PRINT '########## Table GRLS.image_attribute_level_1 created successfully ##########'

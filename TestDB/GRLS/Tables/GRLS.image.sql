USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_modelid_imageid ON GRLS.image

	DROP TABLE GRLS.image
	PRINT '########## Table GRLS.image dropped successfully ##########'
END
GO
CREATE TABLE GRLS.image
(
	image_id		int IDENTITY(1, 1)	NOT NULL ,
	image_url		GRLS.image_url,
	is_monochrome	bit
)
GO
ALTER TABLE GRLS.image ADD PRIMARY KEY CLUSTERED 
(
	image_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
PRINT '########## Table GRLS.image created successfully ##########'

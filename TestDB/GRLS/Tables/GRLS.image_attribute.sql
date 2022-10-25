USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image_attribute', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_imageid_attrl2id ON GRLS.image_attribute

	ALTER TABLE GRLS.image_attribute
	DROP CONSTRAINT FK_image_attribute_image

	DROP TABLE GRLS.image_attribute
	PRINT '########## Table GRLS.image_attribute dropped successfully ##########'
END
GO

CREATE TABLE GRLS.image_attribute(
	image_attribute_id	int IDENTITY(1, 1) NOT NULL,
	image_id			int NOT NULL,
	image_attr_l2_id	int NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE GRLS.image_attribute ADD PRIMARY KEY NONCLUSTERED 
(
	image_attribute_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_imageid_attrl2id ON GRLS.image_attribute (image_id, image_attr_l2_id) ON [PRIMARY];
GO
ALTER TABLE GRLS.image_attribute ADD CONSTRAINT FK_image_attribute_image FOREIGN KEY (image_id) REFERENCES GRLS.image(image_id) ON DELETE CASCADE;
GO

PRINT '########## Table GRLS.image_attribute created successfully ##########'

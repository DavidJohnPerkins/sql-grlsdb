USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image_model', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_imageid_modelid ON GRLS.image_model

	ALTER TABLE GRLS.image_model
	DROP CONSTRAINT FK_image_model_image

	ALTER TABLE GRLS.image_model
	DROP CONSTRAINT FK_image_model_model

	DROP TABLE GRLS.image_model
	PRINT '########## Table GRLS.image_model dropped successfully ##########'
END
GO

CREATE TABLE GRLS.image_model(
	image_model_id	int IDENTITY(1, 1) NOT NULL,
	image_id 		int NOT NULL,
	model_id		int NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE GRLS.image_model ADD PRIMARY KEY NONCLUSTERED 
(
	image_model_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_imageid_modelid ON GRLS.image_model (image_id, model_id) ON [PRIMARY];
GO
ALTER TABLE GRLS.image_model ADD CONSTRAINT FK_image_model_image FOREIGN KEY (image_id) REFERENCES GRLS.image(image_id) ON DELETE CASCADE;
GO
ALTER TABLE GRLS.image_model ADD CONSTRAINT FK_image_model_model FOREIGN KEY (model_id) REFERENCES GRLS.model(id) ON DELETE CASCADE;
GO

ALTER TABLE GRLS.image_model ADD reference_image bit DEFAULT 0;
ALTER TABLE GRLS.image_model ADD thumbnail_image bit DEFAULT 0;


PRINT '########## Table GRLS.image_model created successfully ##########'

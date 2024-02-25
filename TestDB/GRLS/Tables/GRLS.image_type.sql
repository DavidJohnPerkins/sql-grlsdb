USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.image_type', 'U') IS NOT NULL
	DROP TABLE GRLS.image_type
	PRINT '########## Table GRLS.image_type dropped successfully ##########'
GO

CREATE TABLE GRLS.image_type
(
	image_type_id		int IDENTITY(1, 1)	NOT NULL PRIMARY KEY,
	image_type_abbrev	char(2)				NOT NULL,
	image_type_desc		varchar(50)			NOT NULL
)
GO
CREATE UNIQUE INDEX U_IDX_image_type_abbrev ON GRLS.image_type(image_type_abbrev) ON [PRIMARY];
GO

INSERT INTO GRLS.image_type(image_type_abbrev, image_type_desc) VALUES 
('OT', 'Other'),
('TH', 'Thumbnail'),
('RF', 'Reference'),
('FA', 'Face'),
('BR', 'Breasts'),
('PF', 'Pubes Front'),
('PR', 'Pubes Rear'),
('AR', 'Arse')

PRINT '########## Table GRLS.image_type created successfully ##########'

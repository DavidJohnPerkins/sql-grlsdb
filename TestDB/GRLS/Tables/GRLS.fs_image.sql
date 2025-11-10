USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.fs_image', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_fsimage_shortname ON GRLS.fs_image
	DROP INDEX IF EXISTS IX_fsimage_filename ON GRLS.fs_image

	DROP TABLE GRLS.fs_image
	PRINT '########## Table GRLS.fs_image dropped successfully ##########'
END
GO
CREATE TABLE GRLS.fs_image
(
	fs_image_id		int IDENTITY(1, 1)	NOT NULL ,
    filename        nvarchar(255),
	shortname       nvarchar(255)
)
GO

CREATE UNIQUE INDEX U_IDX_fsimage_shortname ON GRLS.fs_image(shortname)
GO

CREATE CLUSTERED INDEX IX_fsimage_filename ON GRLS.fs_image(filename);
GO

PRINT '########## Table GRLS.fs_image created successfully ##########'

/*
INSERT INTO GRLS.fs_image (filename, shortname)
SELECT p.filename, RIGHT(p.filename, CHARINDEX('/', REVERSE(p.filename)) - 1)  FROM GRLS.piclist p
WHERE p.filename LIKE '%jpg'
*/

ALTER TABLE GRLS.image_model DROP CONSTRAINT FK_image_model_image
GO

ALTER TABLE GRLS.image_attribute DROP CONSTRAINT FK_image_attribute_image
GO

DECLARE @img_pk_name sysname = (
	SELECT 
		c.[name]  
	FROM 
		sys.key_constraints c
	WHERE 
		c.type = 'PK' AND OBJECT_NAME(c.parent_object_id) = N'image')

EXEC ('ALTER TABLE GRLS.image DROP CONSTRAINT ' + @img_pk_name);
GO 

ALTER TABLE GRLS.image ADD PRIMARY KEY
(
	image_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE GRLS.image_model ADD CONSTRAINT FK_image_model_image FOREIGN KEY (image_id) REFERENCES GRLS.image(image_id) ON DELETE CASCADE;
GO

ALTER TABLE GRLS.image_attribute ADD CONSTRAINT FK_image_attribute_image FOREIGN KEY (image_id) REFERENCES GRLS.image(image_id) ON DELETE CASCADE;
GO

ALTER TABLE GRLS.image ALTER COLUMN image_url nvarchar(400)
GO 

CREATE UNIQUE CLUSTERED INDEX U_IDX_imageurl ON GRLS.image(image_url)
GO


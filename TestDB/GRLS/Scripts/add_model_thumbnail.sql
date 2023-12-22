USE TestDB
GO

DECLARE @image_url	GRLS.image_url = 'images/bailey_bae_thumbnail.png',
		@model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = 'BAILEY_BAE'),
		@image_id	int

INSERT INTO GRLS.[image] (image_url)
VALUES (@image_url)

SET @image_id = @@IDENTITY

INSERT INTO GRLS.image_model (image_id, model_id, reference_image, thumbnail_image)
VALUES (@image_id, @model_id, 0, 1)

UPDATE GRLS.model SET comment = 'Seriously hot and cool with great hair, perfect small cones with pert puffies and great PUAT.' WHERE id = @model_id

DECLARE @sof TABLE (
	abbrev char(4),
	standout_factor	float
)
INSERT INTO @sof VALUES
('ASHP', 1.2),
('ASIZ', 1.2),
('ATTR', 1.3),
('BILD', 1.0),
('BRDR', 1.2),
('BRSH', 1.3),
('BSIZ', 1.3),
('CMPX', 1.0),
('ETHN', 1.0),
('EYES', 1.0),
('HAIR', 1.2),
('MONS', 1.2),
('NATN', 1.0),
('NPCL', 1.0),
('NPPF', 1.2),
('NPSH', 1.3),
('NPSZ', 1.2),
('PUAT', 1.2),
('YTHF', 1.2)

UPDATE
	ma 
	SET standout_factor = s.standout_factor
FROM 
	GRLS.model_attribute ma 
	INNER JOIN GRLS.attribute_level_2 l2 
		INNER JOIN GRLS.attribute_level_1 l1 
			INNER JOIN @sof s 
			ON l1.abbrev = s.abbrev COLLATE database_default
		ON l2.l1_id = l1.l1_id
	ON ma.attribute_id = l2.l2_id 
WHERE 
	ma.model_id = @model_id
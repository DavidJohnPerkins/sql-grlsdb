USE TestDB
GO

DECLARE @image_url	GRLS.image_url = 'https://www.kindgirls.com/girlsp/altea.jpg',
		@model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = 'ALTEA'),
		@image_id	int

INSERT INTO GRLS.[image] (image_url)
VALUES (@image_url)

SET @image_id = @@IDENTITY

INSERT INTO GRLS.image_model (image_id, model_id, reference_image, thumbnail_image)
VALUES (@image_id, @model_id, 0, 1)

UPDATE GRLS.model SET comment = 'Kooky cutie with gentle squint - juvenile breasts with pert puffies.' WHERE id = @model_id

DECLARE @sof TABLE (
	abbrev char(4),
	standout_factor	float
)
INSERT INTO @sof VALUES
('ASHP', 1.0),
('ASIZ', 1.0),
('ATTR', 1.2),
('BILD', 1.0),
('BRDR', 1.1),
('BRSH', 1.2),
('BSIZ', 1.2),
('CMPX', 1.0),
('ETHN', 1.0),
('EYES', 1.1),
('HAIR', 1.0),
('MONS', 1.0),
('NATN', 1.0),
('NPCL', 1.0),
('NPPF', 1.1),
('NPSH', 1.2),
('NPSZ', 1.2),
('PUAT', 1.0),
('YTHF', 1.0)

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
USE TestDB
GO

DECLARE @sobr GRLS.sobriquet = 'HELLA_G'

DECLARE @image_url	GRLS.image_url = 'https://www.kindgirls.com/girlsp/hella-g.jpg',
		@model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @sobr),
		@image_id	int

INSERT INTO GRLS.[image] (image_url)
VALUES (@image_url)

SET @image_id = @@IDENTITY

INSERT INTO GRLS.image_model (image_id, model_id, reference_image, thumbnail_image, f_image, b_image, p_image_f, p_image_r, a_image)
VALUES (@image_id, @model_id, 0, 1, 0, 0, 0, 0, 0)

UPDATE GRLS.model SET comment = 'Stunning, skinny blonde with amazing eyes - perfect nubs with tiny highly perts - very nice arse.' WHERE id = @model_id

DECLARE @json	COMMON.json = '
	{
		"sobriquet":	"~sobr",
		"update_type":	"add",
		"model_flags": [
			{ "flag_abbrev": "EXCEPTNL"}
		]
	}
'
SET @json = REPLACE(@json, '~sobr', @sobr)
EXEC GRLS.c_model_flag_json @json, 0, 1


DECLARE @sof TABLE (
	abbrev char(4),
	standout_factor	float
)
INSERT INTO @sof VALUES
('ASHP', 1.2),
('ASIZ', 1.2),
('ATTR', 1.3),
('BILD', 1.1),
('BRDR', 1.3),
('BRSH', 1.3),
('BSIZ', 1.3),
('CMPX', 1.0),
('ETHN', 1.0),
('EYES', 1.2),
('HAIR', 1.1),
('MONS', 1.0),
('NATN', 1.0),
('NPCL', 1.1),
('NPPF', 1.3),
('NPSH', 1.3),
('NPSZ', 1.3),
('PUAT', 1.0),
('YTHF', 1.1)

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
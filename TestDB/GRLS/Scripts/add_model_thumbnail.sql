USE TestDB
GO

DECLARE @image_url	GRLS.image_url = 'https://www.kindgirls.com/girlsp/alex-grey.jpg',
		@model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = 'ALEX_GREY'),
		@image_id	int

INSERT INTO GRLS.[image] (image_url)
VALUES (@image_url)

SET @image_id = @@IDENTITY

INSERT INTO GRLS.image_model (image_id, model_id, reference_image, thumbnail_image)
VALUES (@image_id, @model_id, 0, 1)

UPDATE GRLS.model SET comment = 'Slightly trashy American blonde with good PUAT.' WHERE id = @model_id


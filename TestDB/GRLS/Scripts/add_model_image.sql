USE TestDB
GO

DECLARE @sobr GRLS.sobriquet = 'HELLA_G'
DECLARE @model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @sobr)

DECLARE @images TABLE (
	image_url	GRLS.image_url,
	ref_image	bit,
	f_image		bit,
	b_image		bit,
	pf_image	bit,
	pr_image	bit,
	a_image		bit,
	is_mono		bit
)

DECLARE @img_id TABLE (
	image_url	GRLS.image_url,
	image_id	int
)

INSERT INTO @images VALUES 
	('https://gals.kindgirls.com/d009/mya_24_07890/mya_24_07890_10.jpg', 1, 0, 0, 0, 0, 0, 0),
	('https://gals.kindgirls.com/d009/katrina_22_46847/katrina_22_46847_1.jpg', 0, 1, 0, 0, 0, 0, 0),
	('https://gals.kindgirls.com/d009/mya_22_50996/mya_22_50996_6.jpg', 0, 0, 1, 0, 0, 0, 0),
	('https://gals.kindgirls.com/d009/katrina_22_46847/katrina_22_46847_9.jpg', 0, 0, 0, 1, 0, 0, 0),
	('https://gals.kindgirls.com/d009/jati_02998/jati_02998_8.jpg', 0, 0, 0, 0, 1, 0, 0),
	('https://gals.kindgirls.com/d009/mia_22_40658/mia_22_40658_2.jpg', 0, 0, 0, 0, 0, 1, 0)

BEGIN TRANSACTION 

INSERT INTO GRLS.[image] (image_url, is_monochrome)
OUTPUT INSERTED.image_url, INSERTED.image_id INTO @img_id
SELECT 
	i.image_url,
	i.is_mono
FROM
	@images i

INSERT INTO GRLS.image_model (image_id, model_id, reference_image, f_image, b_image, p_image_f, p_image_r, a_image)
SELECT 
	i2.image_id,
	@model_id,
	i1.ref_image,
	i1.f_image,
	i1.b_image,
	i1.pf_image,
	i1.pr_image,
	i1.a_image
FROM 
	@images i1
	INNER JOIN @img_id i2
	ON i1.image_url = i2.image_url

COMMIT TRANSACTION

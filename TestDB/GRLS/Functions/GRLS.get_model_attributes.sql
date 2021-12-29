USE TestDB;  
GO  

IF OBJECT_ID ('GRLS.get_model_attributes', 'TF') IS NOT NULL  
	print 'no'
	DROP FUNCTION GRLS.get_model_attributes
GO  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION GRLS.get_model_attributes(@model_id int)
RETURNS TABLE AS 
RETURN (
	SELECT
		@model_id AS model_id , 
		[NAME] ,
		EYES ,
		HAIR ,
		NATN ,
		BRDR ,
		BRSH ,
		BSIZ ,
		BILD ,
		ATTR ,
		YTHF ,
		CMPX ,
		MONS ,
		ASHP ,
		ASIZ ,
		ETHN ,
		NPCL ,
		NPSH ,
		NPSZ
	FROM (
		SELECT
			x.model_id ,
			x.abbrev ,
			x.l2_desc
	    FROM (
			SELECT
				@model_id AS model_id ,
				al1.abbrev ,
				al2.l2_desc
			FROM
				GRLS.model_attribute ma
				INNER JOIN GRLS.attribute_level_2 al2
					INNER JOIN GRLS.attribute_level_1 al1
					ON al2.l1_id = al1.l1_id
				ON ma.attribute_id = al2.l2_id
			WHERE
				ma.model_id = @model_id
			
			UNION
		
			SELECT
				@model_id ,
				'NAME' ,
				m.sobriquet
			FROM
				GRLS.model m
			WHERE
				m.id = @model_id) x
	) up 
	PIVOT (MAX(l2_desc) FOR abbrev IN (
			[NAME] ,
			EYES ,
			HAIR ,
			NATN ,
			BRDR ,
			BRSH ,
			BSIZ ,
			BILD ,
			ATTR ,
			YTHF ,
			CMPX ,
			MONS ,
			ASHP ,
			ASIZ ,
			ETHN ,
			NPCL ,
			NPSH ,
			NPSZ)
	) AS pvt 
)



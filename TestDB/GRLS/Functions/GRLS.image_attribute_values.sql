USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.image_attribute_values
GO

CREATE FUNCTION GRLS.image_attribute_values(@attrib_abbrev varchar(50), @attrib_value varchar(50))
RETURNS TABLE AS  
RETURN (
	SELECT
		l1.ia_l1_desc ,
		l2.ia_l2_id
	FROM 
		GRLS.image_attribute_level_2 l2
		INNER JOIN GRLS.image_attribute_level_1 l1
		ON l2.ia_l1_id = l1.ia_l1_id
	WHERE
		l1.ia_abbrev = @attrib_abbrev AND
		l2.ia_l2_desc = @attrib_value
	)

GO

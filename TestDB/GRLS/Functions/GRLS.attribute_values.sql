USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.attribute_values
GO

CREATE FUNCTION GRLS.attribute_values(@attrib_abbrev varchar(50), @attrib_value varchar(50))
RETURNS TABLE AS  
RETURN (
	SELECT
		l1.l1_desc ,
		l2.l2_id
	FROM 
		GRLS.attribute_level_2 l2
		INNER JOIN GRLS.attribute_level_1 l1
		ON l2.l1_id = l1.l1_id
	WHERE
		l1.abbrev = @attrib_abbrev AND
		l2.l2_desc = @attrib_value
	)

GO

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.attribute_value_list
GO

CREATE FUNCTION GRLS.attribute_value_list (@attrib_desc varchar(50))
RETURNS TABLE AS  
RETURN (
	SELECT
		l2.l2_id ,
		l2.l2_desc
	FROM 
		GRLS.attribute_level_2 l2
		INNER JOIN GRLS.attribute_level_1 l1
		ON l2.l1_id = l1.l1_id
	WHERE
		l1.l1_desc = @attrib_desc 
	)
GO

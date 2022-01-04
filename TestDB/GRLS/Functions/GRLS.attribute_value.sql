USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.attribute_value
GO

CREATE FUNCTION GRLS.attribute_value(@attrib_desc varchar(50), @attrib_value varchar(50))
RETURNS int AS  
BEGIN
	DECLARE @return_val int 

	SET @return_val = (
		SELECT
			l2.l2_id
		FROM 
			GRLS.attribute_level_2 l2
			INNER JOIN GRLS.attribute_level_1 l1
			ON l2.l1_id = l1.l1_id
		WHERE
			l1.l1_desc = @attrib_desc AND
			l2.l2_desc = @attrib_value
	)

	RETURN @return_val
	
END
GO

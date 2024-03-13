USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.l1_abbrevs_as_string
GO

CREATE FUNCTION GRLS.l1_abbrevs_as_string(@group_abbrev varchar(10))
RETURNS varchar(MAX) AS  
BEGIN
	DECLARE @return_val varchar(MAX) 

	SET @return_val = (SELECT STRING_AGG(w.abbrev, ',') FROM
	(
		SELECT TOP 100
			l1.abbrev
		FROM 
			GRLS.attribute_level_1 l1
			INNER JOIN GRLS.attribute_level_1_group_detail gd 
				INNER JOIN GRLS.attribute_level_1_group g 
				ON gd.l1_group_id = g.l1_group_id
			ON l1.l1_id = gd.l1_id
		WHERE
			l1.for_aggregation = 1 AND 
			g.l1_group_abbrev = @group_abbrev
		ORDER BY
			l1.abbrev) w
	) 

	RETURN @return_val
	
END
GO

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP FUNCTION IF EXISTS GRLS.l1_abbrevs_as_string
GO

CREATE FUNCTION GRLS.l1_abbrevs_as_string()
RETURNS varchar(MAX) AS  
BEGIN
	DECLARE @return_val varchar(MAX) 

	SET @return_val = (SELECT STRING_AGG(w.abbrev, ',') FROM
	(
		SELECT TOP 100
			l1.abbrev
		FROM 
			GRLS.attribute_level_1 l1
		ORDER BY
			l1.abbrev) w
	) 

	RETURN @return_val
	
END
GO

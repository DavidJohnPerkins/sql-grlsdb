SELECT
	'--(''' + al1.abbrev + ''', ''' + al2.l2_desc + ''') ,'  
FROM
	Grls.attribute_level_1 al1
	INNER JOIN Grls.attribute_level_2 al2
	ON al1.l1_id = al2.l1_id
ORDER BY
	al1.abbrev ,
	al2.l2_desc
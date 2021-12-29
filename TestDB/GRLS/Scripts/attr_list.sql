USE [TestDB]
GO

SELECT TOP (1000)
	l1.l1_desc ,
	l1.abbrev ,
	l2.*
FROM
	Grls.attribute_level_2 l2
	INNER JOIN Grls.attribute_level_1 l1
	ON l2.l1_id = l1.l1_id

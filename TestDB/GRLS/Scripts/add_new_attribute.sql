USE TestDB
GO

-- Script to create list of models with blank attribute value - copy results to VALUES...
/*
SELECT 
	'(' + CONVERT(varchar, m.id) + ', ' + COMMON.sq(m.sobriquet) + ', 0),'
FROM 
	GRLS.model m
*/

DECLARE @new_abbrev char(4) = 'PUAT',
		@attr_l1	int 

DECLARE @temp_desc TABLE (
	td_id		int IDENTITY(1,1),
	attr_id		int
)

DECLARE @temp_update TABLE (
	model_id 	int,
	sobriquet	varchar(50),
	at_id 		int
)

IF EXISTS (SELECT 1 FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @new_abbrev)
BEGIN

	SET @attr_l1 = (SELECT l1.l1_id FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @new_abbrev)

	DELETE 
		ma 
	FROM 
		GRLS.model_attribute ma 
		INNER JOIN GRLS.attribute_level_2 l2
			INNER JOIN GRLS.attribute_level_1 l1 
			ON l2.l1_id = l1.l1_id
		ON ma.attribute_id = l2.l2_id
	WHERE 
		l1.l1_id = @attr_l1

	DELETE
		l2 
	FROM 
		GRLS.attribute_level_2 l2
		INNER JOIN GRLS.attribute_level_1 l1 
		ON l2.l1_id = l1.l1_id
	WHERE
		l1.l1_id = @attr_l1

	DELETE
		l1
	FROM 
		GRLS.attribute_level_1 l1 
	WHERE
		l1.l1_id = @attr_l1
END

INSERT INTO GRLS.attribute_level_1 (
	l1_desc,
	abbrev,
	for_aggregation,
	attr_weight)
VALUES (
	'Pudenda Attractiveness',
	'PUAT',
	1,
	8
)
SET @attr_l1 = @@IDENTITY

INSERT INTO GRLS.attribute_level_2(
	l1_id,
	l2_desc,
	l2_preference)
VALUES
	(@attr_l1,	'Unsightly',				4),
	(@attr_l1,	'Noticeable Protrusion',	8),
	(@attr_l1,	'Slight Protrusion',		10),
	(@attr_l1,	'No Protrusion',			14),
	(@attr_l1,	'Plump No Protrusion',		18)

INSERT INTO @temp_desc (attr_id)
SELECT 
	l2.l2_id
FROM
	GRLS.attribute_level_2 l2
WHERE
	l2.l1_id = @attr_l1	

INSERT INTO @temp_update (
	model_id,
	sobriquet ,
	at_id
)
VALUES
(5, 'Cute Linda', 4),
(7, 'Clover', 4),
(8, 'Alice May', 3),
(9, 'Ava', 5),
(10, 'Emma', 2),
(11, 'Muse', 3),
(12, 'Iveta', 4),
(13, 'Xenia', 3),
(14, 'Margo', 4),
(15, 'Aubrey', 4),
(16, 'Francesca', 3),
(17, 'Cira', 5),
(18, 'Tracy A', 3),
(19, 'Sybil A', 3),
(20, 'Zelda', 2),
(21, 'Kara', 5),
(22, 'Sarah', 3),
(23, 'Sapphira', 3),
(24, 'Elle', 3),
(25, 'Michelle H', 3),
(26, 'Bailey Bae', 5),
(27, 'Monika Dee', 2),
(28, 'Aria A', 5),
(29, 'Katherinne', 2),
(30, 'Hella G', 2),
(31, 'Apolonia', 3),
(32, 'Nicca', 2)

INSERT INTO GRLS.model_attribute (model_id, attribute_id)
SELECT
	tu.model_id,
	td.attr_id
FROM
	@temp_update tu 
	INNER JOIN @temp_desc td 
	ON tu.at_id = td.td_id

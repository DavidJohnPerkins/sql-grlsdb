USE TestDB
GO

DECLARE @id int
DECLARE @work TABLE (
	grp_id	int,
	abbrev	char(4)
)

DELETE FROM GRLS.attribute_level_1_group
INSERT INTO GRLS.attribute_level_1_group (l1_group_abbrev, l1_group_desc) VALUES
('BREASTS', 'Breasts, excluding other factors'),
('PUBES', 'Pubes, excluding other factors'),
('ARSE', 'Pubes, excluding other factors'),
('FACE', 'Facial / beauty attributes'),
('FACEPLUS', 'Beauty and physique attributes'),
('WAISTUP', 'Exclude grim-down-south issues'),
('NOTPUBES', 'Everything but pubes')

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'BREASTS')
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'BRSH'),
(@id, 'BSIZ'),
(@id, 'BRDR'),
(@id, 'NPSZ'),
(@id, 'NPSH'),
(@id, 'NPCL'),
(@id, 'NPPF')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'PUBES')
DELETE FROM @work
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'MONS'),
(@id, 'PUAT')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'ARSE')
DELETE FROM @work
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'ASHP'),
(@id, 'ASIZ')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'FACE')
DELETE FROM @work
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'CMPX'),
(@id, 'YTHF'),
(@id, 'HAIR'),
(@id, 'ATTR'),
(@id, 'EYES')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'FACEPLUS')
DELETE FROM @work
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'CMPX'),
(@id, 'YTHF'),
(@id, 'ATTR'),
(@id, 'HAIR'),
(@id, 'EYES'),
(@id, 'ETHN'),
(@id, 'BILD')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'WAISTUP')
DELETE FROM @work
DELETE FROM GRLS.attribute_level_1_group_detail WHERE l1_group_id = @id
INSERT INTO @work (grp_id, abbrev) VALUES
(@id, 'CMPX'),
(@id, 'YTHF'),
(@id, 'ATTR'),
(@id, 'HAIR'),
(@id, 'EYES'),
(@id, 'ETHN'),
(@id, 'BILD'),
(@id, 'BRSH'),
(@id, 'BSIZ'),
(@id, 'BRDR'),
(@id, 'NPSZ'),
(@id, 'NPSH'),
(@id, 'NPCL'),
(@id, 'NPPF')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

SET @id = (SELECT l1.l1_group_id FROM GRLS.attribute_level_1_group l1 WHERE l1.l1_group_abbrev = 'NOTPUBES')
INSERT INTO @work (grp_id, abbrev)
SELECT DISTINCT 
	@id, 
	abbrev FROM GRLS.attribute_level_1 l1 
WHERE 
	l1.abbrev NOT IN ('MONS', 'PUAT', 'NATN')

INSERT INTO GRLS.attribute_level_1_group_detail (l1_group_id, l1_id)
SELECT
	@id,
	l1_id
FROM 
	@work w 
	INNER JOIN GRLS.attribute_level_1 l1 
	ON w.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT


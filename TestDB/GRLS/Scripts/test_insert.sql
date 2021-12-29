USE [TestDB]

DECLARE @model_attribs	Grls.kv_pair ,
		@names 			Grls.generic_list_vc_int

INSERT INTO @model_attribs
VALUES
	('SOBR', 'Hot Afrodita') ,
	('EYES', 'Hazel') ,
	('HAIR', 'Regular Blonde') ,
	('NATN', 'Ukraine') ,
	('BSIZ', 'Small') ,
	('BSHP', 'None') ,
	('BILD', 'Petite') ,
	('ATTR', 'Pretty') ,
	('YTHF', 'Late Teens') ,
	('CMPX', 'Fair') ,
	('MONS', 'Natural / Retreating') ,
	('ASHP', 'Medium Balanced') ,
	('ASIZ', 'Medium') ,
	('ETHN', 'White')

INSERT INTO @names
VALUES
	('Afrodita', 1) ,
	('Made-up', 0)

EXEC Grls.add_model @model_attribs, @names

DELETE FROM @model_attribs
DELETE FROM @names

INSERT INTO @model_attribs
VALUES
	('SOBR', 'Cute Linda') ,
	('EYES', 'Brown') ,
	('HAIR', 'Ash Blonde') ,
	('NATN', 'Ukraine') ,
	('BSIZ', 'Medium') ,
	('BSHP', 'Bump') ,
	('BILD', 'Regular-Petite') ,
	('ATTR', 'Knockout') ,
	('YTHF', 'Late Teens') ,
	('CMPX', 'Fair') ,
	('MONS', 'Natural / Retreating') ,
	('ASHP', 'Medium Balanced') ,
	('ASIZ', 'Medium') ,
	('ETHN', 'White')

INSERT INTO @names
VALUES
	('Linda', 1) ,
	('Aida', 0)

EXEC Grls.add_model @model_attribs, @names


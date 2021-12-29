USE [TestDB]
GO

DECLARE @insert_id int

/*INSERT INTO Grls.attribute_level_1 (l1_desc)
VALUES 
	('Eye Colour') ,
	('Hair Colour') ,
	('Nationality') ,
	('Breast Size') ,
	('Breast Shape') ,
	('Build') ,
	('Attractiveness'),
	('Youthfulness'),
	('Complexion'),
	('Pubic Mound Shape'),
	('Bum Shape'),
	('Bum Size'),
	('Ethnicity')*/

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Youthfulness')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Mid Teens',		9),
	(@insert_id, 'Late Teens',		9),
	(@insert_id, 'Early Twenties',	8),
	(@insert_id, 'Mid Twenties',	7),
	(@insert_id, 'Late Twenties',	6)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Build')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Extra-Petite',	8),
	(@insert_id, 'Petite',			8),
	(@insert_id, 'Regular-Petite',	8),
	(@insert_id, 'Regular',			7),
	(@insert_id, 'Heavy-Regular',	6),
	(@insert_id, 'Heavy',			5)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Attractiveness')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Plain',			3),
	(@insert_id, 'Gamine',			8),
	(@insert_id, 'Girl-Next-Door',	7),
	(@insert_id, 'Cosmetic-led',	5),
	(@insert_id, 'Pretty',			7),
	(@insert_id, 'Beautiful',		8),
	(@insert_id, 'Knockout', 		9),
	(@insert_id, 'Ten',				10)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Complexion')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Pale',			5),
	(@insert_id, 'Fair',			6),
	(@insert_id, 'Freckled',		8),
	(@insert_id, 'Mediterranean',	8),
	(@insert_id, 'Asian',			7),
	(@insert_id, 'Dark',			8),
	(@insert_id, 'Knockout', 		9)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Pubic Mound Shape')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Plump / Retreating',		9),
	(@insert_id, 'Plump / Proud',			8),
	(@insert_id, 'Narrow / Retreating',		7),
	(@insert_id, 'Narrow / Proud',			5),
	(@insert_id, 'Natural / Proud',			7),
	(@insert_id, 'Natural / Retreating',	9),
	(@insert_id, 'Unattractive',			3)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Bum Shape')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Peach',				7),
	(@insert_id, 'Slight Lower Sag',	6),
	(@insert_id, 'Heavy Lower Sag',		7),
	(@insert_id, 'Balanced',			9),
	(@insert_id, 'Medium Balanced',		7),
	(@insert_id, 'Flat',		 		6),
	(@insert_id, 'Near Flat',			7) ,
	(@insert_id, 'Boyish',				8)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Bum Size')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Small / Flat',	7),
	(@insert_id, 'Petite',			6),
	(@insert_id, 'Medium',			7),
	(@insert_id, 'Large',			9),
	(@insert_id, 'Heavy',			7),
	(@insert_id, 'Oversize',	 	6)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Ethnicity')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'White',			7),
	(@insert_id, 'Latino',			8),
	(@insert_id, 'Indian Asian',	7),
	(@insert_id, 'Japanese',		6),
	(@insert_id, 'Chinese',			6),
	(@insert_id, 'Afro-Caribbean',	6),
	(@insert_id, 'Indonesian',		6)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Eye Colour')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Blue',		6),
	(@insert_id, 'Grey',		7),
	(@insert_id, 'Green',		5),
	(@insert_id, 'Hazel',		8),
	(@insert_id, 'Brown',		9),
	(@insert_id, 'Dark Brown', 	10),
	(@insert_id, 'Pale Blue', 	4),
	(@insert_id, 'Deep Grey', 	8)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Hair Colour')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Dyed/Coloured',	2),
	(@insert_id, 'Bleached Blonde',	2),
	(@insert_id, 'White Blonde',	4),
	(@insert_id, 'Ash Blonde',		6),
	(@insert_id, 'Regular Blonde',	5),
	(@insert_id, 'Light Red',		7),
	(@insert_id, 'Bright Red', 		7),
	(@insert_id, 'Copper Red', 		9),
	(@insert_id, 'Fair', 			9),
	(@insert_id, 'Brunette', 		8),
	(@insert_id, 'Dark Brunette',	9),
	(@insert_id, 'Black', 			9)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Nationality')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'USA',				5),
	(@insert_id, 'Russia',			5),
	(@insert_id, 'Slovenia',		5),
	(@insert_id, 'Czech Republic',	5),
	(@insert_id, 'Croatia',			5),
	(@insert_id, 'Spain',			5),
	(@insert_id, 'Ukraine', 		5),
	(@insert_id, 'Hungary', 		5),
	(@insert_id, 'Latvia', 			5),
	(@insert_id, 'United Kingdom',	5)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Breast Size')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'Flat',		7),
	(@insert_id, 'Small',		8),
	(@insert_id, 'Medium',		7),
	(@insert_id, 'Large',		6),
	(@insert_id, 'Oversized',	4)

SET @insert_id = (SELECT l1.l1_id FROM Grls.attribute_level_1 l1 WHERE l1.l1_desc = 'Breast Shape')
INSERT INTO Grls.attribute_level_2 (l1_id, l2_desc, l2_preference)
VALUES
	(@insert_id, 'None',			7),
	(@insert_id, 'Conical',			8),
	(@insert_id, 'Bump',			7),
	(@insert_id, 'Hemispherical',	6),
	(@insert_id, 'Slight Droop',	6),
	(@insert_id, 'Medium Droop',	6),
	(@insert_id, 'Heavy Droop',		4),
	(@insert_id, 'Globular',		6)

/*


-- Set Attributes	
	('Nipple Piercing'),
	('Navel Piercing'),
	('Genital Piercing'),
	('Pubic Hair'),
	('Toys Used'),
	('Schoolgirl Theme')
*/
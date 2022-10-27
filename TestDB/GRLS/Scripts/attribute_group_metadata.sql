USE TestDB
GO

DECLARE @id int

DELETE FROM GRLS.attribute_level_1_group
INSERT INTO GRLS.attribute_level_1_group (l1_group_abbrev, l1_group_desc) VALUES
('BREASTS', 'Breasts, excluding other factors'),
('PUBES', 'Pubes, excluding other factors'),
('ARSE', 'Pubes, excluding other factors'),
('Dress Type', 'DTYP'),
('Pose', 'POSE'),
('Bush Level', 'BUSH'),
('Crop Factor', 'CROP'),
('Aspect', 'ASPC'),
('Legs', 'LEGS'),
('Touching', 'TOUC')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'LOCN')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Pool'),
(@id, 'Beach'),
(@id, 'Bed'),
(@id, 'Bedroom'),
(@id, 'Bathroom'),
(@id, 'Bath'),
(@id, 'Shower'),
(@id, 'Lounge'),
(@id, 'Sofa'),
(@id, 'Dining Room'),
(@id, 'Countryside'),
(@id, 'Urban'),
(@id, 'Kitchen'),
(@id, 'Garden'),
(@id, 'Studio'),
(@id, 'Massage Room'),
(@id, 'Window'),
(@id, 'Cropped - Not Relevant')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'DEXT')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Nude'),
(@id, 'No Nudity / Cropped'),
(@id, 'Breasts Only Visible'),
(@id, 'Pubes Only Visible'),
(@id, 'Arse Only Visible'),
(@id, 'Breasts / Pubes / Arse Visible'),
(@id, 'Breasts / Pubes Visible'),
(@id, 'Breasts / Arse Visible'),
(@id, 'Pubes / Arse Visible')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'DTYP')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'None'),
(@id, 'Swimwear'),
(@id, 'Lingerie'),
(@id, 'Underwear'),
(@id, 'Dress'),
(@id, 'Skirt'),
(@id, 'Shirt'),
(@id, 'Shoes Only'),
(@id, 'Sportswear')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'POSE')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Standing'),
(@id, 'Kneeling'),
(@id, 'All Fours'),
(@id, 'All Fours with Arse Raised'),
(@id, 'Lying - On Back'),
(@id, 'Lying - On Side'),
(@id, 'Lying - On Front'),
(@id, 'Sitting - Legs Apart'),
(@id, 'Bending Over'),
(@id, 'Crouching'),
(@id, 'Cropped - Not Relevant'),
(@id, 'In Vehicle / On Bicycle')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'BUSH')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'None'),
(@id, 'Minimal'),
(@id, 'Mons Covered'),
(@id, 'Full'),
(@id, 'Cropped - Not Relevant')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'ASPC')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Full Frontal'),
(@id, 'Full from Rear'),
(@id, 'Arse Centre'),
(@id, 'Pubes Centre'),
(@id, 'Breasts Centre'),
(@id, 'Arse Centre'),
(@id, 'Cropped - Not Relevant')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'CROP')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Full Figure'),
(@id, 'Cropped Head'),
(@id, 'Breasts'),
(@id, 'Breasts Close-up'),
(@id, 'Breasts Up'),
(@id, 'Pubes'),
(@id, 'Pubes Close-up'),
(@id, 'Pubes / Arse Up'),
(@id, 'Pubes / Breasts'),
(@id, 'Arse'),
(@id, 'Arse Close-up'),
(@id, 'Arse Up')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'LEGS')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'Not Shown'),
(@id, 'Together'),
(@id, 'Slightly Apart'),
(@id, 'Wide Apart')

SET @id = (SELECT l1.ia_l1_id FROM GRLS.image_attribute_level_1 l1 WHERE l1.ia_abbrev = 'TOUC')
DELETE FROM GRLS.image_attribute_level_2 WHERE ia_l1_id = @id
INSERT INTO GRLS.image_attribute_level_2 (ia_l1_id, ia_l2_desc) VALUES
(@id, 'None'),
(@id, 'Non-intimate'),
(@id, 'Breasts - Light'),
(@id, 'Breasts - Heavy'),
(@id, 'Pubes'),
(@id, 'Pubes with Penetration'),
(@id, 'Pubes with Object'),
(@id, 'Arse'),
(@id, 'Arse with Penetration'),
(@id, 'Arse with Object')

DECLARE @model_attribs Grls.kv_pair

DECLARE @model_id int = 19

INSERT INTO @model_attribs VALUES
--('BRDR', 'Heavy') ,
--('BRDR', 'Moderate') ,
--('BRDR', 'None') ,
('BRDR', 'Slight') ,

--('BRSH', 'Conical') ,
--('BRSH', 'Dome') ,
('BRSH', 'Full') ,
--('BRSH', 'Nubs') ,
--('BRSH', 'Pendulous') ,

--('NPCL', 'Dark') ,
('NPCL', 'Normal') ,
--('NPCL', 'Pale') ,

--('NPSH', 'Flat') ,
--('NPSH', 'Pert') ,
--('NPSH', 'Puffy') ,
--('NPSH', 'Slightly Pert') ,
('NPSH', 'Slightly Puffy') ,
--('NPSH', 'Very Pert') ,
--('NPSH', 'Very Puffy') ,

--('NPSZ', 'Large') 
('NPSZ', 'Normal')
--('NPSZ', 'Small')
--('NPSZ', 'Tiny') 

INSERT INTO Grls.model_attribute (model_id, attribute_id)
SELECT
	@model_id ,
	av.l2_id
FROM
	@model_attribs a
	CROSS APPLY Grls.attribute_values(a.key_value, a.data_value) av
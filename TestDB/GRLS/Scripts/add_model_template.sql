USE TestDB
GO

DECLARE @attribs GRLS.kv_pair
DECLARE @names GRLS.generic_list_vc_int

INSERT INTO @names VALUES
('Izzy Delphine', 1)/*1,
('Anneli', 0), 
('Pinky', 0), 
('June', 0), 
('Annelie', 0),
('Mia', 0)*/

INSERT INTO @attribs VALUES

('SOBR', 'Izzy Delphine') ,
('HQUO', '10'),

('ASHP', 'Balanced') ,
--('ASHP', 'Boyish') ,
--('ASHP', 'Peach') ,
--('ASHP', 'Flat') ,
--('ASHP', 'Slight Lower Sag') ,
--('ASHP', 'Heavy Lower Sag') ,

--('ASIZ', 'Petite') ,
('ASIZ', 'Small / Flat') ,
--('ASIZ', 'Medium') ,
--('ASIZ', 'Large') ,
--('ASIZ', 'Heavy') ,
--('ASIZ', 'Oversize') ,

('ATTR', 'Ten') ,
--('ATTR', 'Knockout') ,
--('ATTR', 'Beautiful') ,
--('ATTR', 'Pretty') ,
--('ATTR', 'Gamine') ,
--('ATTR', 'Girl-Next-Door') ,
--('ATTR', 'Cosmetic-led') ,
--('ATTR', 'Plain') ,

('BILD', 'Petite') ,
--('BILD', 'Regular-Petite') ,
--('BILD', 'Regular') ,
--('BILD', 'Extra-Petite') ,
--('BILD', 'Heavy-Regular') ,
--('BILD', 'Heavy') ,

('BRDR', 'None') ,
--('BRDR', 'Slight') ,
--('BRDR', 'Moderate') ,
--('BRDR', 'Heavy') ,

('BRSH', 'Nubs') ,
--('BRSH', 'Conical') ,
--('BRSH', 'Semi-Pendulous') ,
--('BRSH', 'Dome') ,
--('BRSH', 'Full') ,
--('BRSH', 'Pendulous') ,

('BSIZ', 'Small') ,
--('BSIZ', 'Flat') ,
--('BSIZ', 'Medium') ,
--('BSIZ', 'Large') ,
--('BSIZ', 'Oversized') ,

('CMPX', 'Freckled') ,
--('CMPX', 'Mediterranean') ,
--('CMPX', 'Dark') ,
--('CMPX', 'Fair') ,
--('CMPX', 'Asian') ,
--('CMPX', 'Pale') ,

('ETHN', 'White') ,
--('ETHN', 'Latino') ,
--('ETHN', 'Indian Asian') ,
--('ETHN', 'Indonesian') ,
--('ETHN', 'Japanese') ,
--('ETHN', 'Chinese') ,
--('ETHN', 'Afro-Caribbean') ,

--('EYES', 'Dark Brown') ,
--('EYES', 'Brown') ,
--('EYES', 'Deep Grey') ,
--('EYES', 'Grey') ,
--('EYES', 'Blue') ,
('EYES', 'Hazel') ,
--('EYES', 'Green') ,
--('EYES', 'Pale Blue') ,

--('HAIR', 'Dark Brunette') ,
--('HAIR', 'Black') ,
--('HAIR', 'Brunette') ,
--('HAIR', 'Copper Red') ,
--('HAIR', 'Fair') ,
('HAIR', 'Ash Blonde') ,
--('HAIR', 'Mid Brown') ,
--('HAIR', 'Deep Grey') ,
--('HAIR', 'Regular Blonde') ,
--('HAIR', 'Bright Red') ,
--('HAIR', 'Light Red') ,
--('HAIR', 'White Blonde') ,
--('HAIR', 'Dyed/Coloured') ,
--('HAIR', 'Bleached Blonde') ,

--('MONS', 'Plump / Retreating') ,
--('MONS', 'Plump / Proud') ,
--('MONS', 'Natural / Proud') ,
--('MONS', 'Natural / Retreating') ,
('MONS', 'Flat / Retreating') ,
--('MONS', 'Narrow / Retreating') ,
--('MONS', 'Narrow / Proud') ,
--('MONS', 'Unattractive') ,

--('NATN', 'Not Known') ,
--('NATN', 'Belarus') ,
--('NATN', 'Croatia') ,
('NATN', 'Czech Republic') ,
--('NATN', 'Germany') ,
--('NATN', 'Hungary') ,
--('NATN', 'Latvia') ,
--('NATN', 'Moldova') ,
--('NATN', 'Russia') ,
--('NATN', 'Slovenia') ,
--('NATN', 'Spain') ,
--('NATN', 'Ukraine') ,
--('NATN', 'United Kingdom') ,
--('NATN', 'USA') ,

--('NPCL', 'Dark') ,
('NPCL', 'Normal') ,
--('NPCL', 'Pale') ,

--('NPSH', 'Pert') ,
('NPSH', 'Slightly Pert') ,
--('NPSH', 'Very Pert') ,
--('NPSH', 'Slightly Puffy') ,
--('NPSH', 'Puffy') ,
--('NPSH', 'Very Puffy') ,
--('NPSH', 'Flat') ,

--('NPSZ', 'Tiny') ,
--('NPSZ', 'Small') ,
('NPSZ', 'Normal') ,
--('NPSZ', 'Large') ,
--('NPSZ', 'Very Large') ,

--('PUAT', 'Plump No Protrusion') ,
('PUAT', 'No Protrusion') ,
--('PUAT', 'Slight Protrusion') ,
--('PUAT', 'Noticeable Protrusion') ,
--('PUAT', 'Unsightly') ,

('YTHF', 'Mid Teens') 
--('YTHF', 'Late Teens') 
--('YTHF', 'Early Twenties') 
--('YTHF', 'Mid Twenties') 
--('YTHF', 'Late Twenties')

EXEC GRLS.add_model @attribs, @names

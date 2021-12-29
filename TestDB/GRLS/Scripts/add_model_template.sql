DECLARE @attribs Grls.kv_pair
DECLARE @names Grls.generic_list_vc_int

INSERT INTO @names VALUES
('Hella G', 1),
('Mya', 0),
('Jati', 0) ,
('Katrina', 0),
('Mia', 0)

INSERT INTO @attribs VALUES

('SOBR', 'Hella G') ,
('HQUO', '10'),

('ASHP', 'Balanced') ,
--('ASHP', 'Boyish') ,
--('ASHP', 'Flat') ,
--('ASHP', 'Heavy Lower Sag') ,
--('ASHP', 'Peach') ,
--('ASHP', 'Slight Lower Sag') ,

--('ASIZ', 'Heavy') ,
--('ASIZ', 'Large') ,
--('ASIZ', 'Medium') ,
--('ASIZ', 'Oversize') ,
--('ASIZ', 'Petite') ,
('ASIZ', 'Small / Flat') ,

--('ATTR', 'Beautiful') ,
--('ATTR', 'Cosmetic-led') ,
--('ATTR', 'Gamine') ,
--('ATTR', 'Girl-Next-Door') ,
--('ATTR', 'Knockout') ,
--('ATTR', 'Plain') ,
--('ATTR', 'Pretty') ,
('ATTR', 'Ten') ,

--('BILD', 'Extra-Petite') ,
--('BILD', 'Heavy') ,
--('BILD', 'Heavy-Regular') ,
('BILD', 'Petite') ,
--('BILD', 'Regular') ,
--('BILD', 'Regular-Petite') ,

--('BRDR', 'Heavy') ,
--('BRDR', 'Moderate') ,
('BRDR', 'None') ,
--('BRDR', 'Slight') ,

--('BRSH', 'Conical') ,
('BRSH', 'Dome') ,
--('BRSH', 'Full') ,
--('BRSH', 'Nubs') ,
--('BRSH', 'Pendulous') ,
--('BRSH', 'Semi-Pendulous') ,

('BSIZ', 'Flat') ,
--('BSIZ', 'Large') ,
--('BSIZ', 'Medium') ,
--('BSIZ', 'Oversized') ,
--('BSIZ', 'Small') ,

--('CMPX', 'Asian') ,
--('CMPX', 'Dark') ,
('CMPX', 'Fair') ,
--('CMPX', 'Freckled') ,
--('CMPX', 'Mediterranean') ,
--('CMPX', 'Pale') ,

--('ETHN', 'Afro-Caribbean') ,
--('ETHN', 'Chinese') ,
--('ETHN', 'Indian Asian') ,
--('ETHN', 'Indonesian') ,
--('ETHN', 'Japanese') ,
--('ETHN', 'Latino') ,
('ETHN', 'White') ,

--('EYES', 'Blue') ,
--('EYES', 'Brown') ,
--('EYES', 'Dark Brown') ,
('EYES', 'Deep Grey') ,
--('EYES', 'Green') ,
--('EYES', 'Grey') ,
--('EYES', 'Hazel') ,
--('EYES', 'Pale Blue') ,

('HAIR', 'Ash Blonde') ,
--('HAIR', 'Black') ,
--('HAIR', 'Bleached Blonde') ,
--('HAIR', 'Bright Red') ,
--('HAIR', 'Brunette') ,
--('HAIR', 'Copper Red') ,
--('HAIR', 'Dark Brunette') ,
--('HAIR', 'Deep Grey') ,
--('HAIR', 'Dyed/Coloured') ,
--('HAIR', 'Fair') ,
--('HAIR', 'Light Red') ,
--('HAIR', 'Mid Brown') ,
--('HAIR', 'Regular Blonde') ,
--('HAIR', 'White Blonde') ,

--('MONS', 'Narrow / Proud') ,
('MONS', 'Narrow / Retreating') ,
--('MONS', 'Natural / Proud') ,
--('MONS', 'Natural / Retreating') ,
--('MONS', 'Plump / Proud') ,
--('MONS', 'Plump / Retreating') ,
--('MONS', 'Flat / Retreating') ,
--('MONS', 'Unattractive') ,

--('NATN', 'Not Known') ,
--('NATN', 'Belarus') ,
--('NATN', 'Croatia') ,
--('NATN', 'Czech Republic') ,
--('NATN', 'Germany') ,
--('NATN', 'Hungary') ,
--('NATN', 'Latvia') ,
--('NATN', 'Moldova') ,
--('NATN', 'Russia') ,
--('NATN', 'Slovenia') ,
--('NATN', 'Spain') ,
('NATN', 'Ukraine') ,
--('NATN', 'United Kingdom') ,
--('NATN', 'USA') ,

--('NPCL', 'Dark') ,
('NPCL', 'Normal') ,
--('NPCL', 'Pale') ,

--('NPSH', 'Flat') ,
('NPSH', 'Pert') ,
--('NPSH', 'Puffy') ,
--('NPSH', 'Slightly Pert') ,
('NPSH', 'Slightly Puffy') ,
--('NPSH', 'Very Pert') ,
--('NPSH', 'Very Puffy') ,

--('NPSZ', 'Large') ,
--('NPSZ', 'Normal') ,
('NPSZ', 'Small') ,
--('NPSZ', 'Tiny') ,
--('NPSZ', 'Very Large') ,

('YTHF', 'Early Twenties') 
--('YTHF', 'Late Teens')
--('YTHF', 'Late Twenties')
--('YTHF', 'Mid Teens') 
--('YTHF', 'Mid Twenties') 

EXEC Grls.add_model @attribs, @names

USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"attribs": [
			{
				"abbrev": "ASHP", "options": [
					{ "l2_desc": "Balanced", 			"sort_order": 1 },
					{ "l2_desc": "Boyish",				"sort_order": 2 },
					{ "l2_desc": "Peach",				"sort_order": 3 },
					{ "l2_desc": "Flat",				"sort_order": 4 },
					{ "l2_desc": "Slight Lower Sag",	"sort_order": 5 },
					{ "l2_desc": "Heavy Lower Sag",		"sort_order": 6 }
				]
			},
			{
				"abbrev": "ASIZ", "options": [
					{ "l2_desc": "Petite",				"sort_order": 1 },
					{ "l2_desc": "Small / Flat",		"sort_order": 2 },
					{ "l2_desc": "Medium",				"sort_order": 3 },
					{ "l2_desc": "Large",				"sort_order": 4 },
					{ "l2_desc": "Heavy",				"sort_order": 5 },
					{ "l2_desc": "Oversize",			"sort_order": 6 }
				]
			},
			{
				"abbrev": "ATTR", "options": [
					{ "l2_desc": "Ten",					"sort_order": 1 },
					{ "l2_desc": "Knockout",			"sort_order": 2 },
					{ "l2_desc": "Beautiful",			"sort_order": 3 },
					{ "l2_desc": "Pretty",				"sort_order": 4 },
					{ "l2_desc": "Gamine",				"sort_order": 5 },
					{ "l2_desc": "Girl-Next-Door",		"sort_order": 6 },
					{ "l2_desc": "Cosmetic-led",		"sort_order": 7 },
					{ "l2_desc": "Plain",				"sort_order": 8 }
				]
			},
			{
				"abbrev": "BILD", "options": [
					{ "l2_desc": "Extra-Petite",		"sort_order": 1 },
					{ "l2_desc": "Petite",				"sort_order": 2 },
					{ "l2_desc": "Regular-Petite",		"sort_order": 3 },
					{ "l2_desc": "Tall-Petite",			"sort_order": 4 },
					{ "l2_desc": "Regular",				"sort_order": 5 },
					{ "l2_desc": "Heavy-Regular",		"sort_order": 6 },
					{ "l2_desc": "Heavy",				"sort_order": 7 }
				]
			},
			{
				"abbrev": "BRDR", "options": [
					{ "l2_desc": "None",				"sort_order": 1 },
					{ "l2_desc": "Slight",				"sort_order": 2 },
					{ "l2_desc": "Moderate",			"sort_order": 3 },
					{ "l2_desc": "Heavy",				"sort_order": 4 }
				]
			},
			{
				"abbrev": "BRSH", "options": [
					{ "l2_desc": "Nubs",					"sort_order": 1 },
					{ "l2_desc": "Conical",					"sort_order": 2 },
					{ "l2_desc": "Semi-Pendulous Globe",	"sort_order": 3 },
					{ "l2_desc": "Semi-Pendulous",			"sort_order": 4 },
					{ "l2_desc": "Dome",					"sort_order": 5 },
					{ "l2_desc": "Full",					"sort_order": 6 },
					{ "l2_desc": "Pendulous",				"sort_order": 7 }
				]
			},
			{
				"abbrev": "BSIZ", "options": [
					{ "l2_desc": "Flat",				"sort_order": 1 },
					{ "l2_desc": "Small",				"sort_order": 2 },
					{ "l2_desc": "Medium",				"sort_order": 3 },
					{ "l2_desc": "Large",				"sort_order": 4 },
					{ "l2_desc": "Oversized",			"sort_order": 5 }
				]
			},
			{
				"abbrev": "CMPX", "options": [
					{ "l2_desc": "Freckled",			"sort_order": 1 },
					{ "l2_desc": "Mediterranean",		"sort_order": 2 },
					{ "l2_desc": "Dark",				"sort_order": 3 },
					{ "l2_desc": "Fair",				"sort_order": 4 },
					{ "l2_desc": "Asian",				"sort_order": 5 },
					{ "l2_desc": "Pale",				"sort_order": 6 }
				]
			},
			{
				"abbrev": "ETHN", "options": [
					{ "l2_desc": "Afro-Caribbean",		"sort_order": 1 },
					{ "l2_desc": "Chinese",				"sort_order": 2 },
					{ "l2_desc": "Japanese",			"sort_order": 3 },
					{ "l2_desc": "Indian Asian",		"sort_order": 4 },
					{ "l2_desc": "Indonesian",			"sort_order": 5 },
					{ "l2_desc": "Latino",				"sort_order": 6 },
					{ "l2_desc": "White",				"sort_order": 7 }
				]
			},
			{
				"abbrev": "EYES", "options": [
					{ "l2_desc": "Blue",				"sort_order": 1 },
					{ "l2_desc": "Brown",				"sort_order": 2 },
					{ "l2_desc": "Dark Brown",			"sort_order": 3 },
					{ "l2_desc": "Deep Grey",			"sort_order": 4 },
					{ "l2_desc": "Green",				"sort_order": 5 },
					{ "l2_desc": "Grey",				"sort_order": 6 },
					{ "l2_desc": "Hazel",				"sort_order": 7 },
					{ "l2_desc": "Pale Blue",			"sort_order": 8 }
				]
			},
			{
				"abbrev": "HAIR", "options": [
					{ "l2_desc": "Afro",				"sort_order": 1 },
					{ "l2_desc": "Ash Blonde",			"sort_order": 2 },
					{ "l2_desc": "Black",				"sort_order": 3 },
					{ "l2_desc": "Bleached Blonde",		"sort_order": 4 },
					{ "l2_desc": "Bright Red",			"sort_order": 5 },
					{ "l2_desc": "Brunette",			"sort_order": 6 }, 
					{ "l2_desc": "Copper Red",			"sort_order": 7 }, 
					{ "l2_desc": "Dark Brunette",		"sort_order": 8 },
					{ "l2_desc": "Deep Grey",			"sort_order": 9 },
					{ "l2_desc": "Dyed/Coloured",		"sort_order": 10 },
					{ "l2_desc": "Fair",				"sort_order": 11 }, 
					{ "l2_desc": "Light Red",			"sort_order": 12 },
					{ "l2_desc": "Mid Brown",			"sort_order": 13 },
					{ "l2_desc": "Regular Blonde",		"sort_order": 14 },
					{ "l2_desc": "White Blonde",		"sort_order": 15 }
				]
			},
			{
				"abbrev": "MONS", "options": [
					{ "l2_desc": "Flat / Retreating",		"sort_order": 1 },
					{ "l2_desc": "Narrow / Proud",			"sort_order": 2 },
					{ "l2_desc": "Narrow / Retreating",		"sort_order": 3 },
					{ "l2_desc": "Natural / Proud",			"sort_order": 4 },
					{ "l2_desc": "Natural / Retreating",	"sort_order": 5 },
					{ "l2_desc": "Plump / Proud",			"sort_order": 6 },
					{ "l2_desc": "Plump / Retreating",		"sort_order": 7 },
					{ "l2_desc": "Unattractive",			"sort_order": 8 }
				]
			},
			{
				"abbrev": "NATN", "options": [
					{ "l2_desc": "Not Known",			"sort_order": 1 },
					{ "l2_desc": "Armenia",				"sort_order": 2 },
					{ "l2_desc": "Belgium",				"sort_order": 3 },
					{ "l2_desc": "Brazil",				"sort_order": 4 },
					{ "l2_desc": "Belarus",				"sort_order": 5 },	
					{ "l2_desc": "Canada",				"sort_order": 6 },
					{ "l2_desc": "Croatia",				"sort_order": 7 },
					{ "l2_desc": "Czech Republic",		"sort_order": 8 },
					{ "l2_desc": "France",				"sort_order": 9 },
					{ "l2_desc": "Germany",				"sort_order": 10},
					{ "l2_desc": "Greece",				"sort_order": 11 },
					{ "l2_desc": "Hungary",				"sort_order": 12 },
					{ "l2_desc": "Japan",				"sort_order": 13 },
					{ "l2_desc": "Latvia",				"sort_order": 14 },
					{ "l2_desc": "Moldova",				"sort_order": 15 },
					{ "l2_desc": "Poland",				"sort_order": 16 },
					{ "l2_desc": "Russia",				"sort_order": 17 },
					{ "l2_desc": "Slovenia",			"sort_order": 18 },
					{ "l2_desc": "Spain",				"sort_order": 19 },
					{ "l2_desc": "Thailand",			"sort_order": 20 },
					{ "l2_desc": "Ukraine",				"sort_order": 21 },
					{ "l2_desc": "United Kingdom",		"sort_order": 22 },
					{ "l2_desc": "USA",					"sort_order": 23 },
					{ "l2_desc": "Venezuela",			"sort_order": 24 }
				]
			},
			{
				"abbrev": "NPCL", "options": [
					{ "l2_desc": "Dark",				"sort_order": 1 },
					{ "l2_desc": "Normal",				"sort_order": 2 },
					{ "l2_desc": "Pale",				"sort_order": 3 }
				]
			},
			{
				"abbrev": "NPPF", "options": [
					{ "l2_desc": "Not Puffy",			"sort_order": 1 },
					{ "l2_desc": "Slightly Puffy",		"sort_order": 2 },
					{ "l2_desc": "Puffy",				"sort_order": 3 },
					{ "l2_desc": "Very Puffy",			"sort_order": 4 }
				]
			},
			{
				"abbrev": "NPSH", "options": [
					{ "l2_desc": "Flat",				"sort_order": 1 },
					{ "l2_desc": "Slightly Pert",		"sort_order": 2 },
					{ "l2_desc": "Pert",				"sort_order": 3 },
					{ "l2_desc": "Very Pert",			"sort_order": 4 }
				]
			},
			{
				"abbrev": "NPSZ", "options": [
					{ "l2_desc": "Tiny",				"sort_order": 1 },
					{ "l2_desc": "Small",				"sort_order": 2 },
					{ "l2_desc": "Normal",				"sort_order": 3 },
					{ "l2_desc": "Large",				"sort_order": 4 },
					{ "l2_desc": "Very Large",			"sort_order": 5 }
				]
			},
			{
				"abbrev": "PUAT", "options": [
					{ "l2_desc": "Plump No Protrusion",		"sort_order": 1 },
					{ "l2_desc": "Plump Slight Protrusion",	"sort_order": 2 },
					{ "l2_desc": "No Protrusion",			"sort_order": 3 },
					{ "l2_desc": "Slight Protrusion",		"sort_order": 4 },
					{ "l2_desc": "Noticeable Protrusion",	"sort_order": 5 },
					{ "l2_desc": "Unsightly",				"sort_order": 6 }
				] 	
			},
			{
				"abbrev": "YTHF", "options": [
					{ "l2_desc": "Mid Teens",			"sort_order": 1 },
					{ "l2_desc": "Late Teens",			"sort_order": 2 },
					{ "l2_desc": "Early Twenties",		"sort_order": 3 }, 
					{ "l2_desc": "Mid Twenties",		"sort_order": 4 }, 
					{ "l2_desc": "Late Twenties",		"sort_order": 5 }
				]
			}
		]
	}
'

DECLARE	@attribs_json	COMMON.json

DECLARE @work_table TABLE
(
	abbrev		char(4),
	l2_desc		varchar(50),
	sort_order	int
)

INSERT INTO @work_table
SELECT
	a.abbrev,
	b.l2_desc,
	b.sort_order
FROM OPENJSON (@json, '$."attribs"')
WITH
(
	abbrev				GRLS.l1_abbrev,
	options				COMMON.json AS JSON
) a
CROSS APPLY OPENJSON (a.options)
WITH
(
	l2_desc		GRLS.l2_desc,
	sort_order	int
) b

UPDATE 
	l2 
SET 
	l2.l2_sort_order = w.sort_order
FROM 
	@work_table w 
	INNER JOIN GRLS.attribute_level_2 l2
		INNER JOIN GRLS.attribute_level_1 l1 
		ON l2.l1_id = l1.l1_id
	ON l2.l2_desc = w.l2_desc COLLATE DATABASE_DEFAULT

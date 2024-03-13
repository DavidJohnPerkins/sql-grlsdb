USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"scheme_attribs": 
		{
			"scheme_abbrev":	"SIMPLE",
			"scheme_desc":		"Simple preferences",
		 	"active":			1
		},
		"preferences": [
			{
				"abbrev": "ASHP", "attr_weight": 5, "options": [
					{ "l2_desc": "Balanced", 			"preference": 6 },
					{ "l2_desc": "Boyish",				"preference": 5 },
					{ "l2_desc": "Peach",				"preference": 4 },
					{ "l2_desc": "Flat",				"preference": 3 },
					{ "l2_desc": "Slight Lower Sag",	"preference": 2 },
					{ "l2_desc": "Heavy Lower Sag",		"preference": 1 }
				]
			},
			{
				"abbrev": "ASIZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Petite",				"preference": 6 },
					{ "l2_desc": "Small / Flat",		"preference": 5 },
					{ "l2_desc": "Medium",				"preference": 4 },
					{ "l2_desc": "Large",				"preference": 3 },
					{ "l2_desc": "Heavy",				"preference": 2 },
					{ "l2_desc": "Oversize",			"preference": 1 }
				]
			},
			{
				"abbrev": "ATTR", "attr_weight": 5, "options": [
					{ "l2_desc": "Ten",					"preference": 7 },
					{ "l2_desc": "Knockout",			"preference": 6 },
					{ "l2_desc": "Beautiful",			"preference": 6 },
					{ "l2_desc": "Pretty",				"preference": 5 },
					{ "l2_desc": "Gamine",				"preference": 5 },
					{ "l2_desc": "Girl-Next-Door",		"preference": 4 },
					{ "l2_desc": "Cosmetic-led",		"preference": 2 },
					{ "l2_desc": "Plain",				"preference": 2 }
				]
			},
			{
				"abbrev": "BILD", "attr_weight": 5, "options": [
					{ "l2_desc": "Extra-Petite",		"preference": 7 },
					{ "l2_desc": "Petite",				"preference": 6 },
					{ "l2_desc": "Regular-Petite",		"preference": 5 },
					{ "l2_desc": "Tall-Petite",			"preference": 4 },
					{ "l2_desc": "Regular",				"preference": 3 },
					{ "l2_desc": "Heavy-Regular",		"preference": 2 },
					{ "l2_desc": "Heavy",				"preference": 1 }
				]
			},
			{
				"abbrev": "BRDR", "attr_weight": 5, "options": [
					{ "l2_desc": "None",				"preference": 4 },
					{ "l2_desc": "Slight",				"preference": 3 },
					{ "l2_desc": "Moderate",			"preference": 2 },
					{ "l2_desc": "Heavy",				"preference": 1 }
				]
			},
			{
				"abbrev": "BRSH", "attr_weight": 5, "options": [
					{ "l2_desc": "Nubs",					"preference": 5 },
					{ "l2_desc": "Conical",					"preference": 5 },
					{ "l2_desc": "Semi-Pendulous Globe",	"preference": 4 },
					{ "l2_desc": "Semi-Pendulous",			"preference": 3 },
					{ "l2_desc": "Dome",					"preference": 4 },
					{ "l2_desc": "Full",					"preference": 2 },
					{ "l2_desc": "Pendulous",				"preference": 1 }
				]
			},
			{
				"abbrev": "BSIZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Small",				"preference": 5 },
					{ "l2_desc": "Flat",				"preference": 4 },
					{ "l2_desc": "Medium",				"preference": 3 },
					{ "l2_desc": "Large",				"preference": 2 },
					{ "l2_desc": "Oversized",			"preference": 1 }
				]
			},
			{
				"abbrev": "CMPX", "attr_weight": 5, "options": [
					{ "l2_desc": "Freckled",			"preference": 4 },
					{ "l2_desc": "Mediterranean",		"preference": 5 },
					{ "l2_desc": "Dark",				"preference": 6 },
					{ "l2_desc": "Fair",				"preference": 3 },
					{ "l2_desc": "Asian",				"preference": 2 },
					{ "l2_desc": "Pale",				"preference": 1 }
				]
			},
			{
				"abbrev": "ETHN", "attr_weight": 5, "options": [
					{ "l2_desc": "White",				"preference": 3 },
					{ "l2_desc": "Latino",				"preference": 3 },
					{ "l2_desc": "Indian Asian",		"preference": 3 },
					{ "l2_desc": "Indonesian",			"preference": 3 },
					{ "l2_desc": "Japanese",			"preference": 3 },
					{ "l2_desc": "Chinese",				"preference": 3 },
					{ "l2_desc": "Afro-Caribbean",		"preference": 3 }
				]
			},
			{
				"abbrev": "EYES", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark Brown",			"preference": 3 },
					{ "l2_desc": "Brown",				"preference": 3 },
					{ "l2_desc": "Deep Grey",			"preference": 3 },
					{ "l2_desc": "Grey",				"preference": 3 },
					{ "l2_desc": "Blue",				"preference": 2 },
					{ "l2_desc": "Hazel",				"preference": 3 },
					{ "l2_desc": "Green",				"preference": 3 },
					{ "l2_desc": "Pale Blue",			"preference": 1 }
				]
			},
			{
				"abbrev": "HAIR", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark Brunette",		"preference": 6},
					{ "l2_desc": "Black",				"preference": 4 },
					{ "l2_desc": "Brunette",			"preference": 5 }, 
					{ "l2_desc": "Copper Red",			"preference": 5 }, 
					{ "l2_desc": "Fair",				"preference": 4 }, 
					{ "l2_desc": "Ash Blonde",			"preference": 4 },
					{ "l2_desc": "Mid Brown",			"preference": 3 },
					{ "l2_desc": "Deep Grey",			"preference": 3 },
					{ "l2_desc": "Regular Blonde",		"preference": 3 },
					{ "l2_desc": "Bright Red",			"preference": 2 },
					{ "l2_desc": "Light Red",			"preference": 2 },
					{ "l2_desc": "White Blonde",		"preference": 2 },
					{ "l2_desc": "Dyed/Coloured",		"preference": 1 },
					{ "l2_desc": "Bleached Blonde",		"preference": 1 },
					{ "l2_desc": "Afro",				"preference": 2 }
				]
			},
			{
				"abbrev": "MONS", "attr_weight": 5, "options": [
					{ "l2_desc": "Plump / Proud",			"preference": 8 },
					{ "l2_desc": "Plump / Retreating",		"preference": 7 },
					{ "l2_desc": "Natural / Proud",			"preference": 6 },
					{ "l2_desc": "Natural / Retreating",	"preference": 5 },
					{ "l2_desc": "Narrow / Proud",			"preference": 4 },
					{ "l2_desc": "Narrow / Retreating",		"preference": 3 },
					{ "l2_desc": "Flat / Retreating",		"preference": 2 },
					{ "l2_desc": "Unattractive",			"preference": 1 }
				]
			},
			{
				"abbrev": "NATN", "attr_weight": 5, "options": [
					{ "l2_desc": "Not Known",			"preference": 5 },
					{ "l2_desc": "Armenia",				"preference": 5 },
					{ "l2_desc": "Belgium",				"preference": 5 },
					{ "l2_desc": "Brazil",				"preference": 5 },
					{ "l2_desc": "Belarus",				"preference": 5 },	
					{ "l2_desc": "Croatia",				"preference": 5 },
					{ "l2_desc": "Czech Republic",		"preference": 5 },
					{ "l2_desc": "Germany",				"preference": 5 },
					{ "l2_desc": "Greece",				"preference": 5 },
					{ "l2_desc": "Hungary",				"preference": 5 },
					{ "l2_desc": "Japan",				"preference": 5 },
					{ "l2_desc": "Latvia",				"preference": 5 },
					{ "l2_desc": "Moldova",				"preference": 5 },
					{ "l2_desc": "Poland",				"preference": 5 },
					{ "l2_desc": "Russia",				"preference": 5 },
					{ "l2_desc": "Slovenia",			"preference": 5 },
					{ "l2_desc": "Spain",				"preference": 5 },
					{ "l2_desc": "Thailand",			"preference": 5 },
					{ "l2_desc": "Ukraine",				"preference": 5 },
					{ "l2_desc": "United Kingdom",		"preference": 5 },
					{ "l2_desc": "USA",					"preference": 5 },
					{ "l2_desc": "Venezuela",			"preference": 5 }
				]
			},
			{
				"abbrev": "NPCL", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark",				"preference": 3 },
					{ "l2_desc": "Normal",				"preference": 2 },
					{ "l2_desc": "Pale",				"preference": 1 }
				]
			},
			{
				"abbrev": "NPPF", "attr_weight": 5, "options": [
					{ "l2_desc": "Not Puffy",			"preference": 4 },
					{ "l2_desc": "Slightly Puffy",		"preference": 3 },
					{ "l2_desc": "Puffy",				"preference": 2 },
					{ "l2_desc": "Very Puffy",			"preference": 1 }
				]
			},
			{
				"abbrev": "NPSH", "attr_weight": 5, "options": [
					{ "l2_desc": "Slightly Pert",		"preference": 2 },
					{ "l2_desc": "Pert",				"preference": 3 },
					{ "l2_desc": "Very Pert",			"preference": 4 },
					{ "l2_desc": "Flat",				"preference": 1 }
				]
			},
			{
				"abbrev": "NPSZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Tiny",				"preference": 5 },
					{ "l2_desc": "Small",				"preference": 4 },
					{ "l2_desc": "Normal",				"preference": 3 },
					{ "l2_desc": "Large",				"preference": 2 },
					{ "l2_desc": "Very Large",			"preference": 1 }
				]
			},
			{
				"abbrev": "PUAT", "attr_weight": 5, "options": [
					{ "l2_desc": "Plump No Protrusion",		"preference": 6 },
					{ "l2_desc": "Plump Slight Protrusion",	"preference": 5 },
					{ "l2_desc": "No Protrusion",			"preference": 4 },
					{ "l2_desc": "Slight Protrusion",		"preference": 3 },
					{ "l2_desc": "Noticeable Protrusion",	"preference": 2 },
					{ "l2_desc": "Unsightly",				"preference": 1 }
				] 	
			},
			{
				"abbrev": "YTHF", "attr_weight": 5, "options": [
					{ "l2_desc": "Mid Teens",			"preference": 5 },
					{ "l2_desc": "Late Teens",			"preference": 4 },
					{ "l2_desc": "Early Twenties",		"preference": 4 }, 
					{ "l2_desc": "Mid Twenties",		"preference": 3 }, 
					{ "l2_desc": "Late Twenties",		"preference": 2 }
				]
			}
		]
	}
';
EXEC GRLS.c_attribute_scheme @json, 0, 1

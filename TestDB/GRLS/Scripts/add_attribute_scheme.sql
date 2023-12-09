USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"scheme_attribs": 
		{
			"scheme_abbrev":	"NOPREF",
			"scheme_desc":		"No preferences",
		 	"active":			1
		},
		"preferences": [
			{
				"abbrev": "ASHP", "attr_weight": 5, "options": [
					{ "l2_desc": "Balanced", 			"preference": 10 },
					{ "l2_desc": "Boyish",				"preference": 10 },
					{ "l2_desc": "Peach",				"preference": 10 },
					{ "l2_desc": "Flat",				"preference": 10 },
					{ "l2_desc": "Slight Lower Sag",	"preference": 10 },
					{ "l2_desc": "Heavy Lower Sag",		"preference": 10 }
				]
			},
			{
				"abbrev": "ASIZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Petite",				"preference": 10 },
					{ "l2_desc": "Small / Flat",		"preference": 10 },
					{ "l2_desc": "Medium",				"preference": 10 },
					{ "l2_desc": "Large",				"preference": 10 },
					{ "l2_desc": "Heavy",				"preference": 10 },
					{ "l2_desc": "Oversize",			"preference": 10 }
				]
			},
			{
				"abbrev": "ATTR", "attr_weight": 5, "options": [
					{ "l2_desc": "Ten",					"preference": 10 },
					{ "l2_desc": "Knockout",			"preference": 10 },
					{ "l2_desc": "Beautiful",			"preference": 10 },
					{ "l2_desc": "Pretty",				"preference": 10 },
					{ "l2_desc": "Gamine",				"preference": 10 },
					{ "l2_desc": "Girl-Next-Door",		"preference": 10 },
					{ "l2_desc": "Cosmetic-led",		"preference": 10 },
					{ "l2_desc": "Plain",				"preference": 10 }
				]
			},
			{
				"abbrev": "BILD", "attr_weight": 5, "options": [
					{ "l2_desc": "Extra-Petite",		"preference": 10 },
					{ "l2_desc": "Petite",				"preference": 10 },
					{ "l2_desc": "Regular-Petite",		"preference": 10 },
					{ "l2_desc": "Tall-Petite",			"preference": 10 },
					{ "l2_desc": "Regular",				"preference": 10 },
					{ "l2_desc": "Heavy-Regular",		"preference": 10 },
					{ "l2_desc": "Heavy",				"preference": 10 }
				]
			},
			{
				"abbrev": "BRDR", "attr_weight": 5, "options": [
					{ "l2_desc": "None",				"preference": 10 },
					{ "l2_desc": "Slight",				"preference": 10 },
					{ "l2_desc": "Moderate",			"preference": 10 },
					{ "l2_desc": "Heavy",				"preference": 10 }
				]
			},
			{
				"abbrev": "BRSH", "attr_weight": 5, "options": [
					{ "l2_desc": "Nubs",					"preference": 10 },
					{ "l2_desc": "Conical",					"preference": 10 },
					{ "l2_desc": "Semi-Pendulous Globe",	"preference": 10 },
					{ "l2_desc": "Semi-Pendulous",			"preference": 10 },
					{ "l2_desc": "Dome",					"preference": 10 },
					{ "l2_desc": "Full",					"preference": 10 },
					{ "l2_desc": "Pendulous",				"preference": 10 }
				]
			},
			{
				"abbrev": "BSIZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Small",				"preference": 10 },
					{ "l2_desc": "Flat",				"preference": 10 },
					{ "l2_desc": "Medium",				"preference": 10 },
					{ "l2_desc": "Large",				"preference": 10 },
					{ "l2_desc": "Oversized",			"preference": 10 }
				]
			},
			{
				"abbrev": "CMPX", "attr_weight": 5, "options": [
					{ "l2_desc": "Freckled",			"preference": 10 },
					{ "l2_desc": "Mediterranean",		"preference": 10 },
					{ "l2_desc": "Dark",				"preference": 10 },
					{ "l2_desc": "Fair",				"preference": 10 },
					{ "l2_desc": "Asian",				"preference": 10 },
					{ "l2_desc": "Pale",				"preference": 10 }
				]
			},
			{
				"abbrev": "ETHN", "attr_weight": 5, "options": [
					{ "l2_desc": "White",				"preference": 10 },
					{ "l2_desc": "Latino",				"preference": 10 },
					{ "l2_desc": "Indian Asian",		"preference": 10 },
					{ "l2_desc": "Indonesian",			"preference": 10 },
					{ "l2_desc": "Japanese",			"preference": 10 },
					{ "l2_desc": "Chinese",				"preference": 10 },
					{ "l2_desc": "Afro-Caribbean",		"preference": 10 }
				]
			},
			{
				"abbrev": "EYES", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark Brown",			"preference": 10 },
					{ "l2_desc": "Brown",				"preference": 10 },
					{ "l2_desc": "Deep Grey",			"preference": 10 },
					{ "l2_desc": "Grey",				"preference": 10 },
					{ "l2_desc": "Blue",				"preference": 10 },
					{ "l2_desc": "Hazel",				"preference": 10 },
					{ "l2_desc": "Green",				"preference": 10 },
					{ "l2_desc": "Pale Blue",			"preference": 10 }
				]
			},
			{
				"abbrev": "HAIR", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark Brunette",		"preference": 10 },
					{ "l2_desc": "Black",				"preference": 10 },
					{ "l2_desc": "Brunette",			"preference": 10 }, 
					{ "l2_desc": "Copper Red",			"preference": 10 }, 
					{ "l2_desc": "Fair",				"preference": 10 }, 
					{ "l2_desc": "Ash Blonde",			"preference": 10 },
					{ "l2_desc": "Mid Brown",			"preference": 10 },
					{ "l2_desc": "Deep Grey",			"preference": 10 },
					{ "l2_desc": "Regular Blonde",		"preference": 10 },
					{ "l2_desc": "Bright Red",			"preference": 10 },
					{ "l2_desc": "Light Red",			"preference": 10 },
					{ "l2_desc": "White Blonde",		"preference": 10 },
					{ "l2_desc": "Dyed/Coloured",		"preference": 10 },
					{ "l2_desc": "Bleached Blonde",		"preference": 10 },
					{ "l2_desc": "Afro",				"preference": 10 }
				]
			},
			{
				"abbrev": "MONS", "attr_weight": 5, "options": [
					{ "l2_desc": "Plump / Proud",			"preference": 10 },
					{ "l2_desc": "Plump / Retreating",		"preference": 10 },
					{ "l2_desc": "Natural / Proud",			"preference": 10 },
					{ "l2_desc": "Natural / Retreating",	"preference": 10 },
					{ "l2_desc": "Narrow / Proud",			"preference": 10 },
					{ "l2_desc": "Narrow / Retreating",		"preference": 10 },
					{ "l2_desc": "Flat / Retreating",		"preference": 10 },
					{ "l2_desc": "Unattractive",			"preference": 10 }
				]
			},
			{
				"abbrev": "NATN", "attr_weight": 5, "options": [
					{ "l2_desc": "Not Known",			"preference": 10 },
					{ "l2_desc": "Armenia",				"preference": 10 },
					{ "l2_desc": "Belgium",				"preference": 10 },
					{ "l2_desc": "Brazil",				"preference": 10 },
					{ "l2_desc": "Belarus",				"preference": 10 },	
					{ "l2_desc": "Croatia",				"preference": 10 },
					{ "l2_desc": "Czech Republic",		"preference": 10 },
					{ "l2_desc": "Germany",				"preference": 10 },
					{ "l2_desc": "Greece",				"preference": 10 },
					{ "l2_desc": "Hungary",				"preference": 10 },
					{ "l2_desc": "Japan",				"preference": 10 },
					{ "l2_desc": "Latvia",				"preference": 10 },
					{ "l2_desc": "Moldova",				"preference": 10 },
					{ "l2_desc": "Poland",				"preference": 10 },
					{ "l2_desc": "Russia",				"preference": 10 },
					{ "l2_desc": "Slovenia",			"preference": 10 },
					{ "l2_desc": "Spain",				"preference": 10 },
					{ "l2_desc": "Thailand",			"preference": 10 },
					{ "l2_desc": "Ukraine",				"preference": 10 },
					{ "l2_desc": "United Kingdom",		"preference": 10 },
					{ "l2_desc": "USA",					"preference": 10 },
					{ "l2_desc": "Venezuela",			"preference": 10 }
				]
			},
			{
				"abbrev": "NPCL", "attr_weight": 5, "options": [
					{ "l2_desc": "Dark",				"preference": 10 },
					{ "l2_desc": "Normal",				"preference": 10 },
					{ "l2_desc": "Pale",				"preference": 10 }
				]
			},
			{
				"abbrev": "NPPF", "attr_weight": 5, "options": [
					{ "l2_desc": "Not Puffy",			"preference": 10 },
					{ "l2_desc": "Slightly Puffy",		"preference": 10 },
					{ "l2_desc": "Puffy",				"preference": 10 },
					{ "l2_desc": "Very Puffy",			"preference": 10 }
				]
			},
			{
				"abbrev": "NPSH", "attr_weight": 5, "options": [
					{ "l2_desc": "Slightly Pert",		"preference": 10 },
					{ "l2_desc": "Pert",				"preference": 10 },
					{ "l2_desc": "Very Pert",			"preference": 10 },
					{ "l2_desc": "Flat",				"preference": 10 }
				]
			},
			{
				"abbrev": "NPSZ", "attr_weight": 5, "options": [
					{ "l2_desc": "Tiny",				"preference": 10 },
					{ "l2_desc": "Small",				"preference": 10 },
					{ "l2_desc": "Normal",				"preference": 10 },
					{ "l2_desc": "Large",				"preference": 10 },
					{ "l2_desc": "Very Large",			"preference": 10 }
				]
			},
			{
				"abbrev": "PUAT", "attr_weight": 5, "options": [
					{ "l2_desc": "Plump No Protrusion",		"preference": 10 },
					{ "l2_desc": "Plump Slight Protrusion",	"preference": 10 },
					{ "l2_desc": "No Protrusion",			"preference": 10 },
					{ "l2_desc": "Slight Protrusion",		"preference": 10 },
					{ "l2_desc": "Noticeable Protrusion",	"preference": 10 },
					{ "l2_desc": "Unsightly",				"preference": 10 }
				] 	
			},
			{
				"abbrev": "YTHF", "attr_weight": 5, "options": [
					{ "l2_desc": "Mid Teens",			"preference": 10 },
					{ "l2_desc": "Late Teens",			"preference": 10 },
					{ "l2_desc": "Early Twenties",		"preference": 10 }, 
					{ "l2_desc": "Mid Twenties",		"preference": 10 }, 
					{ "l2_desc": "Late Twenties",		"preference": 10 }
				]
			}
		]
	}
';
EXEC GRLS.c_attribute_scheme @json, 1, 1

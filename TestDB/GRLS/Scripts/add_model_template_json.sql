USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"base_attribs": 
		{
			"sobriquet": "CAESARIA",
		 	"hot_quotient": 8
		},
		"model_names": [
			{ "model_name": "Caesaria",	"principal_name": 1 },	
			{ "model_name": "Tatjana",	"principal_name": 0 }	
		],
		"attribs": [
			{
				"abbrev": "ASHP", "options": [
					{ "l2_desc": "Balanced", 			"selected": 1 },
					{ "l2_desc": "Boyish",				"selected": 0 },
					{ "l2_desc": "Peach",				"selected": 0 },
					{ "l2_desc": "Flat",				"selected": 0 },
					{ "l2_desc": "Slight Lower Sag",	"selected": 0 },
					{ "l2_desc": "Heavy Lower Sag",		"selected": 0 }
				]
			},
			{
				"abbrev": "ASIZ", "options": [
					{ "l2_desc": "Petite",				"selected": 0 },
					{ "l2_desc": "Small / Flat",		"selected": 1 },
					{ "l2_desc": "Medium",				"selected": 0 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 },
					{ "l2_desc": "Oversize",			"selected": 0 }
				]
			},
			{
				"abbrev": "ATTR", "options": [
					{ "l2_desc": "Ten",					"selected": 0 },
					{ "l2_desc": "Knockout",			"selected": 0 },
					{ "l2_desc": "Beautiful",			"selected": 0 },
					{ "l2_desc": "Pretty",				"selected": 1 },
					{ "l2_desc": "Gamine",				"selected": 0 },
					{ "l2_desc": "Girl-Next-Door",		"selected": 0 },
					{ "l2_desc": "Cosmetic-led",		"selected": 0 },
					{ "l2_desc": "Plain",				"selected": 0 }
				]
			},
			{
				"abbrev": "BILD", "options": [
					{ "l2_desc": "Petite",				"selected": 0 },
					{ "l2_desc": "Regular-Petite",		"selected": 1 },
					{ "l2_desc": "Regular",				"selected": 0 },
					{ "l2_desc": "Extra-Petite",		"selected": 0 },
					{ "l2_desc": "Heavy-Regular",		"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 }
				]
			},
			{
				"abbrev": "BRDR", "options": [
					{ "l2_desc": "None",				"selected": 1 },
					{ "l2_desc": "Slight",				"selected": 0 },
					{ "l2_desc": "Moderate",			"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 }
				]
			},
			{
				"abbrev": "BRSH", "options": [
					{ "l2_desc": "Nubs",				"selected": 0 },
					{ "l2_desc": "Conical",				"selected": 0 },
					{ "l2_desc": "Semi-Pendulous",		"selected": 0 },
					{ "l2_desc": "Dome",				"selected": 1 },
					{ "l2_desc": "Full",				"selected": 0 },
					{ "l2_desc": "Pendulous",			"selected": 0 }
				]
			},
			{
				"abbrev": "BSIZ", "options": [
					{ "l2_desc": "Small",				"selected": 1 },
					{ "l2_desc": "Flat",				"selected": 0 },
					{ "l2_desc": "Medium",				"selected": 0 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Oversized",			"selected": 0 }
				]
			},
			{
				"abbrev": "CMPX", "options": [
					{ "l2_desc": "Freckled",			"selected": 0 },
					{ "l2_desc": "Mediterranean",		"selected": 0 },
					{ "l2_desc": "Dark",				"selected": 0 },
					{ "l2_desc": "Fair",				"selected": 1 },
					{ "l2_desc": "Asia",				"selected": 0 },
					{ "l2_desc": "Pale",				"selected": 0 }
				]
			},
			{
				"abbrev": "ETHN", "options": [
					{ "l2_desc": "White",				"selected": 1 },
					{ "l2_desc": "Latino",				"selected": 0 },
					{ "l2_desc": "Indian Asian",		"selected": 0 },
					{ "l2_desc": "Indonesian",			"selected": 0 },
					{ "l2_desc": "Japanese",			"selected": 0 },
					{ "l2_desc": "Chinese",				"selected": 0 },
					{ "l2_desc": "Afro-Caribbean",		"selected": 0 }
				]
			},
			{
				"abbrev": "EYES", "options": [
					{ "l2_desc": "Dark Brown",			"selected": 0 },
					{ "l2_desc": "Brown",				"selected": 1 },
					{ "l2_desc": "Deep Grey",			"selected": 0 },
					{ "l2_desc": "Grey",				"selected": 0 },
					{ "l2_desc": "Blue",				"selected": 0 },
					{ "l2_desc": "Hazel",				"selected": 0 },
					{ "l2_desc": "Green",				"selected": 0 },
					{ "l2_desc": "Pale Blue",			"selected": 0 }
				]
			},
			{
				"abbrev": "HAIR", "options": [
					{ "l2_desc": "Dark Brunette",		"selected": 0 },
					{ "l2_desc": "Black",				"selected": 0 },
					{ "l2_desc": "Brunette",			"selected": 0 }, 
					{ "l2_desc": "Copper Red",			"selected": 0 }, 
					{ "l2_desc": "Fair",				"selected": 1 }, 
					{ "l2_desc": "Ash Blonde",			"selected": 0 },
					{ "l2_desc": "Mid Brown",			"selected": 0 },
					{ "l2_desc": "Deep Grey",			"selected": 0 },
					{ "l2_desc": "Regular Blonde",		"selected": 0 },
					{ "l2_desc": "Bright Red",			"selected": 0 },
					{ "l2_desc": "Light Red",			"selected": 0 },
					{ "l2_desc": "White Blonde",		"selected": 0 },
					{ "l2_desc": "Dyed/Coloured",		"selected": 0 },
					{ "l2_desc": "Bleached Blonde",		"selected": 0 },
					{ "l2_desc": "Afro",				"selected": 0 }
				]
			},
			{
				"abbrev": "MONS", "options": [
					{ "l2_desc": "Plump / Retreating",		"selected": 0 },
					{ "l2_desc": "Plump / Proud",			"selected": 0 },
					{ "l2_desc": "Natural / Proud",			"selected": 0 },
					{ "l2_desc": "Natural / Retreating",	"selected": 1 },
					{ "l2_desc": "Flat / Retreating",		"selected": 0 },
					{ "l2_desc": "Narrow / Retreating",		"selected": 0 },
					{ "l2_desc": "Narrow / Proud",			"selected": 0 },
					{ "l2_desc": "Unattractive",			"selected": 0 }
				]
			},
			{
				"abbrev": "NATN", "options": [
					{ "l2_desc": "Not Known",			"selected": 0 },
					{ "l2_desc": "Brazil",				"selected": 0 },
					{ "l2_desc": "Belarus",				"selected": 0 },
					{ "l2_desc": "Croatia",				"selected": 0 },
					{ "l2_desc": "Czech Republic",		"selected": 0 },
					{ "l2_desc": "Germany",				"selected": 0 },
					{ "l2_desc": "Hungary",				"selected": 0 },
					{ "l2_desc": "Latvia",				"selected": 0 },
					{ "l2_desc": "Moldova",				"selected": 0 },
					{ "l2_desc": "Russia",				"selected": 1 },
					{ "l2_desc": "Slovenia",			"selected": 0 },
					{ "l2_desc": "Spain",				"selected": 0 },
					{ "l2_desc": "Ukraine",				"selected": 0 },
					{ "l2_desc": "United Kingdom",		"selected": 0 },
					{ "l2_desc": "USA",					"selected": 0 }
				]
			},
			{
				"abbrev": "NPCL", "options": [
					{ "l2_desc": "Dark",				"selected": 0 },
					{ "l2_desc": "Normal",				"selected": 1 },
					{ "l2_desc": "Pale",				"selected": 0 }
				]
			},
			{
				"abbrev": "NPSH", "options": [
					{ "l2_desc": "Pert",				"selected": 0 },
					{ "l2_desc": "Slightly Pert",		"selected": 1 },
					{ "l2_desc": "Very Pert",			"selected": 0 },
					{ "l2_desc": "Slightly Puffy",		"selected": 0 },
					{ "l2_desc": "Puffy",				"selected": 0 },
					{ "l2_desc": "Very Puffy",			"selected": 0 },
					{ "l2_desc": "Flat",				"selected": 0 }
				]
			},
			{
				"abbrev": "NPSZ", "options": [
					{ "l2_desc": "Tiny",				"selected": 0 },
					{ "l2_desc": "Small",				"selected": 0 },
					{ "l2_desc": "Normal",				"selected": 1 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Very Large",			"selected": 0 }
				]
			},
			{
				"abbrev": "PUAT", "options": [
					{ "l2_desc": "Plump No Protrusion",		"selected": 0 },
					{ "l2_desc": "No Protrusion",			"selected": 1 },
					{ "l2_desc": "Slight Protrusion",		"selected": 0 },
					{ "l2_desc": "Noticeable Protrusion",	"selected": 0 },
					{ "l2_desc": "Unsightly",				"selected": 0 }
				]
			},
			{
				"abbrev": "YTHF", "options": [
					{ "l2_desc": "Mid Teens",			"selected": 0 },
					{ "l2_desc": "Late Teens",			"selected": 1 },
					{ "l2_desc": "Early Twenties",		"selected": 0 }, 
					{ "l2_desc": "Mid Twenties",		"selected": 0 }, 
					{ "l2_desc": "Late Twenties",		"selected": 0 }
				]
			}
		]
	}
'
EXEC GRLS.c_model_json @json, 0, 0

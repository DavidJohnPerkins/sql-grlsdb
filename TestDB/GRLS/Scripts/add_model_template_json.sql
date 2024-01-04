USE TestDB
GO

DECLARE @json	COMMON.json = '
	{
		"base_attribs": 
		{
			"sobriquet":		"CAROLINA_ABRIL",
		 	"hot_quotient":		9,	
			"yob":				1992,
			"comment":			"Latino girl next door with great smile and beautiful brown eyes - small cones with highly puffy extremely perts and good PUAT.",
			"thumbnail":		"https://www.kindgirls.com/girlsp/carolina-abril.jpg"
		},
		"model_names": [
			{ "model_name": "Carolina Abril",	"principal_name": 1 },
			{ "model_name": "Caro Abril",	"principal_name": 0 }
		],
		"model_flags": [
			{ "flag_abbrev": "LSBNPORN" }
		],
		"attribs": [
			{
				"abbrev": "ASHP", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Balanced", 			"selected": 0 },
					{ "l2_desc": "Boyish",				"selected": 0 },
					{ "l2_desc": "Peach",				"selected": 1 },
					{ "l2_desc": "Flat",				"selected": 0 },
					{ "l2_desc": "Slight Lower Sag",	"selected": 0 },
					{ "l2_desc": "Heavy Lower Sag",		"selected": 0 }
				]
			},
			{
				"abbrev": "ASIZ", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Petite",				"selected": 1 },
					{ "l2_desc": "Small / Flat",		"selected": 0 },
					{ "l2_desc": "Medium",				"selected": 0 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 },
					{ "l2_desc": "Oversize",			"selected": 0 }
				]
			},
			{
				"abbrev": "ATTR", "standout_factor": 1.2, "options": [
					{ "l2_desc": "Ten",					"selected": 0 },
					{ "l2_desc": "Knockout",			"selected": 0 },
					{ "l2_desc": "Beautiful",			"selected": 1 },
					{ "l2_desc": "Pretty",				"selected": 0 },
					{ "l2_desc": "Gamine",				"selected": 0 },
					{ "l2_desc": "Girl-Next-Door",		"selected": 0 },
					{ "l2_desc": "Cosmetic-led",		"selected": 0 },
					{ "l2_desc": "Plain",				"selected": 0 }
				]
			},
			{
				"abbrev": "BILD", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Extra-Petite",		"selected": 0 },
					{ "l2_desc": "Petite",				"selected": 0 },
					{ "l2_desc": "Regular-Petite",		"selected": 0 },
					{ "l2_desc": "Tall-Petite",			"selected": 1 },
					{ "l2_desc": "Regular",				"selected": 0 },
					{ "l2_desc": "Heavy-Regular",		"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 }
				]
			},
			{
				"abbrev": "BRDR", "standout_factor": 1.1, "options": [
					{ "l2_desc": "None",				"selected": 1 },
					{ "l2_desc": "Slight",				"selected": 0 },
					{ "l2_desc": "Moderate",			"selected": 0 },
					{ "l2_desc": "Heavy",				"selected": 0 }
				]
			},
			{
				"abbrev": "BRSH", "standout_factor": 1.2, "options": [
					{ "l2_desc": "Nubs",					"selected": 0 },
					{ "l2_desc": "Conical",					"selected": 1 },
					{ "l2_desc": "Semi-Pendulous Globe",	"selected": 0 },
					{ "l2_desc": "Semi-Pendulous",			"selected": 0 },
					{ "l2_desc": "Dome",					"selected": 0 },
					{ "l2_desc": "Full",					"selected": 0 },
					{ "l2_desc": "Pendulous",				"selected": 0 }
				]
			},
			{
				"abbrev": "BSIZ", "standout_factor": 1.1, "options": [
					{ "l2_desc": "Flat",				"selected": 0 },
					{ "l2_desc": "Small",				"selected": 1 },
					{ "l2_desc": "Medium",				"selected": 0 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Oversized",			"selected": 0 }
				]
			},
			{
				"abbrev": "CMPX", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Freckled",			"selected": 0 },
					{ "l2_desc": "Mediterranean",		"selected": 1 },
					{ "l2_desc": "Dark",				"selected": 0 },
					{ "l2_desc": "Fair",				"selected": 0 },
					{ "l2_desc": "Asian",				"selected": 0 },
					{ "l2_desc": "Pale",				"selected": 0 }
				]
			},
			{
				"abbrev": "ETHN", "standout_factor": 1.0, "options": [
					{ "l2_desc": "White",				"selected": 0 },
					{ "l2_desc": "Latino",				"selected": 1 },
					{ "l2_desc": "Indian Asian",		"selected": 0 },
					{ "l2_desc": "Indonesian",			"selected": 0 },
					{ "l2_desc": "Japanese",			"selected": 0 },
					{ "l2_desc": "Chinese",				"selected": 0 },
					{ "l2_desc": "Afro-Caribbean",		"selected": 0 }
				]
			},
			{
				"abbrev": "EYES", "standout_factor": 1.2, "options": [
					{ "l2_desc": "Dark Brown",			"selected": 1 },
					{ "l2_desc": "Brown",				"selected": 0 },
					{ "l2_desc": "Deep Grey",			"selected": 0 },
					{ "l2_desc": "Grey",				"selected": 0 },
					{ "l2_desc": "Blue",				"selected": 0 },
					{ "l2_desc": "Hazel",				"selected": 0 },
					{ "l2_desc": "Green",				"selected": 0 },
					{ "l2_desc": "Pale Blue",			"selected": 0 }
				]
			},
			{
				"abbrev": "HAIR", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Dark Brunette",		"selected": 1 },
					{ "l2_desc": "Black",				"selected": 0 },
					{ "l2_desc": "Brunette",			"selected": 0 }, 
					{ "l2_desc": "Copper Red",			"selected": 0 }, 
					{ "l2_desc": "Fair",				"selected": 0 }, 
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
				"abbrev": "MONS", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Plump / Proud",			"selected": 0 },
					{ "l2_desc": "Plump / Retreating",		"selected": 0 },
					{ "l2_desc": "Natural / Proud",			"selected": 0 },
					{ "l2_desc": "Natural / Retreating",	"selected": 0 },
					{ "l2_desc": "Narrow / Proud",			"selected": 0 },
					{ "l2_desc": "Narrow / Retreating",		"selected": 0 },
					{ "l2_desc": "Flat / Retreating",		"selected": 0 },
					{ "l2_desc": "Unattractive",			"selected": 1 }
				]
			},
			{
				"abbrev": "NATN", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Not Known",			"selected": 0 },
					{ "l2_desc": "Armenia",				"selected": 0 },
					{ "l2_desc": "Belgium",				"selected": 0 },
					{ "l2_desc": "Brazil",				"selected": 0 },
					{ "l2_desc": "Belarus",				"selected": 0 },	
					{ "l2_desc": "Canada",				"selected": 0 },
					{ "l2_desc": "China",				"selected": 0 },
					{ "l2_desc": "Colombia",			"selected": 0 },
					{ "l2_desc": "Croatia",				"selected": 0 },
					{ "l2_desc": "Czech Republic",		"selected": 0 },
					{ "l2_desc": "France",				"selected": 0 },
					{ "l2_desc": "Germany",				"selected": 0 },
					{ "l2_desc": "Greece",				"selected": 0 },
					{ "l2_desc": "Hungary",				"selected": 0 },
					{ "l2_desc": "Japan",				"selected": 0 },
					{ "l2_desc": "Latvia",				"selected": 0 },
					{ "l2_desc": "Moldova",				"selected": 0 },
					{ "l2_desc": "Poland",				"selected": 0 },
					{ "l2_desc": "Russia",				"selected": 0 },
					{ "l2_desc": "Slovenia",			"selected": 0 },
					{ "l2_desc": "Spain",				"selected": 1 },
					{ "l2_desc": "Thailand",			"selected": 0 },
					{ "l2_desc": "Ukraine",				"selected": 0 },
					{ "l2_desc": "United Kingdom",		"selected": 0 },
					{ "l2_desc": "USA",					"selected": 0 },
					{ "l2_desc": "Venezuela",			"selected": 0 }
				]
			},
			{
				"abbrev": "NPCL", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Dark",				"selected": 0 },
					{ "l2_desc": "Normal",				"selected": 1 },
					{ "l2_desc": "Pale",				"selected": 0 }
				]
			},
			{
				"abbrev": "NPPF", "standout_factor": 1.1, "options": [
					{ "l2_desc": "Not Puffy",			"selected": 0 },
					{ "l2_desc": "Slightly Puffy",		"selected": 0 },
					{ "l2_desc": "Puffy",				"selected": 1 },
					{ "l2_desc": "Very Puffy",			"selected": 0 }
				]
			},
			{
				"abbrev": "NPSH", "standout_factor": 1.2, "options": [
					{ "l2_desc": "Flat",				"selected": 0 },
					{ "l2_desc": "Slightly Pert",		"selected": 0 },
					{ "l2_desc": "Pert",				"selected": 0 },
					{ "l2_desc": "Very Pert",			"selected": 1 }
				]
			},
			{
				"abbrev": "NPSZ", "standout_factor": 1.1, "options": [
					{ "l2_desc": "Tiny",				"selected": 0 },
					{ "l2_desc": "Small",				"selected": 0 },
					{ "l2_desc": "Normal",				"selected": 1 },
					{ "l2_desc": "Large",				"selected": 0 },
					{ "l2_desc": "Very Large",			"selected": 0 }
				]
			},
			{
				"abbrev": "PUAT", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Plump No Protrusion",		"selected": 1 },
					{ "l2_desc": "Plump Slight Protrusion",	"selected": 0 },
					{ "l2_desc": "No Protrusion",			"selected": 0 },
					{ "l2_desc": "Slight Protrusion",		"selected": 0 },
					{ "l2_desc": "Noticeable Protrusion",	"selected": 0 },
					{ "l2_desc": "Unsightly",				"selected": 0 }
				] 	
			},
			{
				"abbrev": "YTHF", "standout_factor": 1.0, "options": [
					{ "l2_desc": "Mid Teens",			"selected": 0 },
					{ "l2_desc": "Late Teens",			"selected": 0 },
					{ "l2_desc": "Early Twenties",		"selected": 1 }, 
					{ "l2_desc": "Mid Twenties",		"selected": 0 }, 
					{ "l2_desc": "Late Twenties",		"selected": 0 }
				]
			}
		]
	}
'
--select @json
EXEC GRLS.c_model_json @json, 0, 1

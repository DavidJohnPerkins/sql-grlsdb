DECLARE @json	COMMON.json = '
[
	{
		"base_attribs": {
			"sobriquet": "TALIA",
			"hot_quotient": 10,
			"yob": 0
		},
		"model_names": [
			{
				"model_name": "Talia",
				"principal_name": true
			}
		],
		"attribs": [
			{
				"abbrev": "ASHP",
				"options": [
					{
						"l2_desc": "Boyish",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "ASIZ",
				"options": [
					{
						"l2_desc": "Petite",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "ATTR",
				"options": [
					{
						"l2_desc": "Ten",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "BILD",
				"options": [
					{
						"l2_desc": "Petite",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "BRDR",
				"options": [
					{
						"l2_desc": "None",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "BRSH",
				"options": [
					{
						"l2_desc": "Conical",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "BSIZ",
				"options": [
					{
						"l2_desc": "Small",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "CMPX",
				"options": [
					{
						"l2_desc": "Fair",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "ETHN",
				"options": [
					{
						"l2_desc": "White",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "EYES",
				"options": [
					{
						"l2_desc": "Blue",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "HAIR",
				"options": [
					{
						"l2_desc": "Regular Blonde",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "MONS",
				"options": [
					{
						"l2_desc": "Plump \/ Proud",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "NATN",
				"options": [
					{
						"l2_desc": "Russia",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "NPCL",
				"options": [
					{
						"l2_desc": "Normal",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "NPPF",
				"options": [
					{
						"l2_desc": "Slightly Puffy",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "NPSH",
				"options": [
					{
						"l2_desc": "Very Pert",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "NPSZ",
				"options": [
					{
						"l2_desc": "Small",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "PUAT",
				"options": [
					{
						"l2_desc": "Noticeable Protrusion",
						"selected": 1
					}
				]
			},
			{
				"abbrev": "YTHF",
				"options": [
					{
						"l2_desc": "Mid Teens",
						"selected": 1
					}
				]
			}
		]
	}
]'
EXEC GRLS.c_model_json @json, 0, 1

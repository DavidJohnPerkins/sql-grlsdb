DECLARE @mode char(3)='ALL'
DECLARE @p_input_json COMMON.json = '
	{
		"name_search_term":		"%%",
		"search_mode_flag":		"ALL",
		"search_mode_attrib":	"ALL",
		"flag_type":			"MOD",
		"search_flags": [
			{ "flag_abbrev": "WMNCHILD", "selected": 1 },
			{ "flag_abbrev": "NPPIERCE", "selected": 0 },
			{ "flag_abbrev": "GNPIERCE", "selected": 0 },
			{ "flag_abbrev": "HTROPORN", "selected": 0 },
			{ "flag_abbrev": "ANALPORN", "selected": 0 },
			{ "flag_abbrev": "LSBNPORN", "selected": 0 },
			{ "flag_abbrev": "EXCEPTNL", "selected": 0 },
			{ "flag_abbrev": "LRGBRSTS", "selected": 0 },
			{ "flag_abbrev": "SMLBRSTS", "selected": 1 },
			{ "flag_abbrev": "PUBEHAIR", "selected": 0 }
		],
		"search_attribs": [
			{ "abbrev": "ASHP", "attrib_value": "Balanced", 				"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Rounded", 					"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Boyish",					"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Peach",					"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Flat",						"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Slight Lower Sag",			"selected": 0 },
			{ "abbrev": "ASHP", "attrib_value": "Heavy Lower Sag",			"selected": 0 },

			{ "abbrev": "ASIZ", "attrib_value": "Petite",					"selected": 0 },
			{ "abbrev": "ASIZ", "attrib_value": "Small / Flat",				"selected": 0 },
			{ "abbrev": "ASIZ", "attrib_value": "Medium",					"selected": 0 },
			{ "abbrev": "ASIZ", "attrib_value": "Large",					"selected": 0 },
			{ "abbrev": "ASIZ", "attrib_value": "Heavy",					"selected": 0 },
			{ "abbrev": "ASIZ", "attrib_value": "Oversize",					"selected": 0 },

			{ "abbrev": "ATTR", "attrib_value": "Ten",						"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Knockout",					"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Beautiful",				"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Pretty",					"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Gamine",					"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Girl-Next-Door",			"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Cosmetic-led",				"selected": 0 },
			{ "abbrev": "ATTR", "attrib_value": "Plain",					"selected": 0 },

			{ "abbrev": "BILD", "attrib_value": "Extra-Petite",				"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Petite",					"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Regular-Petite",			"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Tall-Petite",				"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Regular",					"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Heavy-Regular",			"selected": 0 },
			{ "abbrev": "BILD", "attrib_value": "Heavy",					"selected": 0 },

			{ "abbrev": "BRDR", "attrib_value": "None",						"selected": 0 },
			{ "abbrev": "BRDR", "attrib_value": "Slight",					"selected": 0 },
			{ "abbrev": "BRDR", "attrib_value": "Moderate",					"selected": 0 },
			{ "abbrev": "BRDR", "attrib_value": "Heavy",					"selected": 0 },

			{ "abbrev": "BRSH", "attrib_value": "Nubs",						"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Conical",					"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Semi-Pendulous Globe",		"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Semi-Pendulous",			"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Dome",						"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Full",						"selected": 0 },
			{ "abbrev": "BRSH", "attrib_value": "Pendulous",				"selected": 0 },

			{ "abbrev": "BSIZ", "attrib_value": "Flat",						"selected": 0 },
			{ "abbrev": "BSIZ", "attrib_value": "Small",					"selected": 0 },
			{ "abbrev": "BSIZ", "attrib_value": "Medium",					"selected": 0 },
			{ "abbrev": "BSIZ", "attrib_value": "Large",					"selected": 0 },
			{ "abbrev": "BSIZ", "attrib_value": "Oversized",				"selected": 0 },

			{ "abbrev": "CMPX", "attrib_value": "Freckled",					"selected": 0 },
			{ "abbrev": "CMPX", "attrib_value": "Mediterranean",			"selected": 0 },
			{ "abbrev": "CMPX", "attrib_value": "Dark",						"selected": 0 },
			{ "abbrev": "CMPX", "attrib_value": "Fair",						"selected": 0 },
			{ "abbrev": "CMPX", "attrib_value": "Asian",					"selected": 0 },
			{ "abbrev": "CMPX", "attrib_value": "Pale",						"selected": 0 },

			{ "abbrev": "ETHN", "attrib_value": "White",					"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Latino",					"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Indian Asian",				"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Indonesian",				"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Japanese",					"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Chinese",					"selected": 0 },
			{ "abbrev": "ETHN", "attrib_value": "Afro-Caribbean",			"selected": 0 },

			{ "abbrev": "EYES", "attrib_value": "Dark Brown",				"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Brown",					"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Deep Grey",				"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Grey",						"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Blue",						"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Hazel",					"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Green",					"selected": 0 },
			{ "abbrev": "EYES", "attrib_value": "Pale Blue",				"selected": 0 },

			{ "abbrev": "HAIR", "attrib_value": "Dark Brunette",			"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Black",					"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Brunette",					"selected": 0 }, 
			{ "abbrev": "HAIR", "attrib_value": "Copper Red",				"selected": 0 }, 
			{ "abbrev": "HAIR", "attrib_value": "Fair",						"selected": 0 }, 
			{ "abbrev": "HAIR", "attrib_value": "Ash Blonde",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Mid Brown",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Deep Grey",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Regular Blonde",			"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Bright Red",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Light Red",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "White Blonde",				"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Dyed/Coloured",			"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Bleached Blonde",			"selected": 0 },
			{ "abbrev": "HAIR", "attrib_value": "Afro",						"selected": 0 },

			{ "abbrev": "MONS", "attrib_value": "Plump / Proud",			"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Plump / Retreating",		"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Natural / Proud",			"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Natural / Retreating",		"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Narrow / Proud",			"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Narrow / Retreating",		"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Flat / Retreating",		"selected": 0 },
			{ "abbrev": "MONS", "attrib_value": "Unattractive",				"selected": 0 },

			{ "abbrev": "NATN", "attrib_value": "Not Known",				"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Armenia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Belgium",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Brazil",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Belarus",					"selected": 0 },	
			{ "abbrev": "NATN", "attrib_value": "Canada",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "China",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Colombia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Croatia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Czech Republic",			"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "France",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Germany",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Greece",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Hungary",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Japan",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Latvia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Moldova",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Poland",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Russia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Slovenia",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Spain",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Thailand",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Ukraine",					"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "United Kingdom",			"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "USA",						"selected": 0 },
			{ "abbrev": "NATN", "attrib_value": "Venezuela",				"selected": 0 },

			{ "abbrev": "NPCL", "attrib_value": "Dark",						"selected": 0 },
			{ "abbrev": "NPCL", "attrib_value": "Normal",					"selected": 0 },
			{ "abbrev": "NPCL", "attrib_value": "Pale",						"selected": 0 },

			{ "abbrev": "NPPF", "attrib_value": "Not Puffy",				"selected": 0 },
			{ "abbrev": "NPPF", "attrib_value": "Slightly Puffy",			"selected": 0 },
			{ "abbrev": "NPPF", "attrib_value": "Puffy",					"selected": 0 },
			{ "abbrev": "NPPF", "attrib_value": "Very Puffy",				"selected": 0 },

			{ "abbrev": "NPSH", "attrib_value": "Flat",						"selected": 0 },
			{ "abbrev": "NPSH", "attrib_value": "Slightly Pert",			"selected": 0 },
			{ "abbrev": "NPSH", "attrib_value": "Pert",						"selected": 0 },
			{ "abbrev": "NPSH", "attrib_value": "Very Pert",				"selected": 0 },

			{ "abbrev": "NPSZ", "attrib_value": "Tiny",						"selected": 0 },
			{ "abbrev": "NPSZ", "attrib_value": "Small",					"selected": 0 },
			{ "abbrev": "NPSZ", "attrib_value": "Normal",					"selected": 0 },
			{ "abbrev": "NPSZ", "attrib_value": "Large",					"selected": 0 },
			{ "abbrev": "NPSZ", "attrib_value": "Very Large",				"selected": 0 },

			{ "abbrev": "PUAT", "attrib_value": "Plump No Protrusion",		"selected": 0 },
			{ "abbrev": "PUAT", "attrib_value": "Plump Slight Protrusion",	"selected": 0 },
			{ "abbrev": "PUAT", "attrib_value": "No Protrusion",			"selected": 0 },
			{ "abbrev": "PUAT", "attrib_value": "Slight Protrusion",		"selected": 0 },
			{ "abbrev": "PUAT", "attrib_value": "Noticeable Protrusion",	"selected": 0 },
			{ "abbrev": "PUAT", "attrib_value": "Unsightly",				"selected": 0 },

			{ "abbrev": "YTHF", "attrib_value": "Mid Teens",				"selected": 0 },
			{ "abbrev": "YTHF", "attrib_value": "Late Teens",				"selected": 0 },
			{ "abbrev": "YTHF", "attrib_value": "Early Twenties",			"selected": 0 }, 
			{ "abbrev": "YTHF", "attrib_value": "Mid Twenties",				"selected": 0 }, 
			{ "abbrev": "YTHF", "attrib_value": "Late Twenties",			"selected": 0 }
		]
	}'
/*
;WITH w_id AS (
	SELECT
		n.model_id
	FROM
		GRLS.model_name n
	WHERE
		n.is_principal_name = 1 AND
		n.model_name LIKE JSON_VALUE(@p_input_json, '$."name_search_term"')
)
*/
DECLARE @flagsum GRLS.kv_pair_int
INSERT INTO @flagsum
SELECT 
	n.model_id,
	SUM(fb.bin_val) AS flag_sum
FROM 
	GRLS.model_name n
	INNER JOIN GRLS.model_flag mf
		INNER JOIN GRLS.bv_flag_binary fb 
		ON mf.flag_id = fb.flag_id
	ON n.model_id = mf.model_id
WHERE
	n.is_principal_name = 1 AND
	n.model_name LIKE JSON_VALUE(@p_input_json, '$."name_search_term"')
GROUP BY 
	n.model_id
	--select * from @flagsum

select 
	p.* 
from
	GRLS.pv_analysis_pivot p
	inner join GRLS.attrib_search(@p_input_json) att
		inner join GRLS.flag_search(@p_input_json, @flagsum) fs 
		ON att.model_id = fs.object_id
	ON p.model_id = att.model_id
--	INNER JOIN w_id w 
--	on p.model_id = w.model_id
where 
	scheme_abbrev='SIMPLE'
order by 
	p.model_name

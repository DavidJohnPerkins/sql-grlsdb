/*
			{"abbrev":	"ASIZ", "attrib_value": "Petite"},
			{"abbrev":	"ASIZ", "attrib_value": "Medium"},
			{"abbrev":	"ASIZ", "attrib_value": "Small / Flat"},
			{"abbrev":	"ATTR", "attrib_value": "Knockout"},
			{"abbrev":	"ATTR", "attrib_value": "Pretty"},
			{"abbrev":	"ATTR", "attrib_value": "Ten"},
			{"abbrev":	"BRSH", "attrib_value": "Nubs"},
			{"abbrev":	"BRSH", "attrib_value": "Conical"},
			{"abbrev":	"BRSH", "attrib_value": "Dome"},
			{"abbrev":	"NPSZ", "attrib_value": "Small"},
			{"abbrev":	"NPSZ", "attrib_value": "Large"},
			{"abbrev":	"YTHF", "attrib_value": "Mid Teens"}
*/

DECLARE @p_input_json COMMON.json = '
	{
		"search_mode_flag":		"ANY",
		"search_mode_attrib":	"ALL",
		"search_flags": [
			{ "flag_abbrev": "WMNCHILD" },
			{ "flag_abbrev": "EXCEPTNL" }
		],
		"search_attribs": [
			{"abbrev":	"ASIZ", "attrib_value": "Petite"},
			{"abbrev":	"ASIZ", "attrib_value": "Medium"},
			{"abbrev":	"ASIZ", "attrib_value": "Small / Flat"},
			{"abbrev":	"BRSH", "attrib_value": "Nubs"},
			{"abbrev":	"BRSH", "attrib_value": "Conical"},
			{"abbrev":	"BRSH", "attrib_value": "Dome"},
			{"abbrev":	"NPSZ", "attrib_value": "Large"},
			{"abbrev":	"ATTR", "attrib_value": "Knockout"},
			{"abbrev":	"ATTR", "attrib_value": "Pretty"},
			{"abbrev":	"ATTR", "attrib_value": "Ten"},
			{"abbrev":	"NPPF", "attrib_value": "Very Puffy"},
			{"abbrev":	"YTHF", "attrib_value": "Mid Teens"}
		]
	}
'
select 
	p.* 
from
	GRLS.pv_analysis_pivot p
	inner join GRLS.attrib_search(@p_input_json) att
		inner join GRLS.flag_search(@p_input_json) fs 
		ON att.model_id = fs.model_id
	ON p.model_id = att.model_id
where 
	scheme_abbrev='SIMPLE'
order by 
	p.model_name

/*
	DECLARE @mode char(3) = JSON_VALUE(@p_input_json, '$."search_mode_flag"');

	WITH w_flags AS (
		SELECT
			f.flag_abbrev AS flag_abbrev
		FROM 
			OPENJSON (@p_input_json, '$.search_flags')
			WITH
			(
				flag_abbrev	char(8)
			) f
	),
	w_searchsum AS (
		SELECT 
			SUM(fb.bin_val) AS srchsum
		FROM 
			GRLS.bv_flag_binary fb
			INNER JOIN GRLS.flag f
				INNER JOIN w_flags i 
				ON f.flag_abbrev = i.flag_abbrev
			ON fb.flag_abbrev = f.flag_abbrev
	)
	SELECT 
		m.id 
	FROM 
		w_searchsum w,
		GRLS.model m
		LEFT OUTER JOIN GRLS.bv_model_flagsum fs
		ON m.id = fs.model_id
	WHERE 
		(fs.flag_sum & w.srchsum != 0 AND @mode = 'ANY') OR 
		(fs.flag_sum & w.srchsum = w.srchsum AND @mode = 'ALL') OR 
		((SELECT COUNT(1) FROM w_flags) = 0)--select * FROM GRLS.pv_analysis_pivot where scheme_abbrev='SIMPLE' and model_name='Carla B'
*/
--select distinct model_id from GRLS.model_flag WHERE flag_id=4
--SELECT * FROM GRLS.flag
--select * from GRLS.pv_analysis_pivot where model_name = 'Lukki Lima'
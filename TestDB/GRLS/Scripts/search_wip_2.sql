DECLARE @p_input_json COMMON.json = '
	{
		"search_mode_flag":		"ALL",
		"search_mode_attrib":	"ALL",
		"search_flags": [
			{"flag_abbrev":	"EXCEPTNL"},
			{"flag_abbrev":	"WMNCHILD"}
		],
		"search_attribs": [
			{"abbrev":	"ATTR", "attrib_value": "Ten"},
			{"abbrev":	"ASHP", "attrib_value": "Boyish"},
			{"abbrev":	"ASHP", "attrib_value": "Balanced"},
			{"abbrev":	"BRSH", "attrib_value": "Conical"},
			{"abbrev":	"BRSH", "attrib_value": "Dome"}
		]
	}
'

--select * from GRLS.attrib_search(@p_input_json) a
--select * from GRLS.flag_search(@p_input_json) a
select 
	p.* 
from
	GRLS.pv_analysis_pivot p
 	INNER JOIN GRLS.attrib_search(@p_input_json) a
--		INNER JOIN (
--			SELECT model_id FROM GRLS.flag_search(@p_input_json)) f
--		ON a.model_id = f.model_id
	ON p.model_id = a.model_id 
WHERE 
	p.scheme_abbrev = 'SIMPLE'

/*
DECLARE @mode char(3) = JSON_VALUE(@p_input_json, '$."search_mode"');

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
	m.id AS model_id,
	m.sobriquet,
	fs.flag_sum
FROM 
	w_searchsum w,
	GRLS.bv_model_flagsum fs
	INNER JOIN GRLS.model m
	ON fs.model_id = m.id
WHERE 
	(fs.flag_sum & w.srchsum != 0 AND @mode = 'ANY') OR 
	(fs.flag_sum & w.srchsum = w.srchsum AND @mode = 'ALL') 

UNION

WITH w_search_attribs AS (
	SELECT
		sa.abbrev AS abbrev,
		sa.attrib_value AS attrib_value
	FROM 
		OPENJSON (@p_input_json, '$.search_attribs')
		WITH
		(
			abbrev			GRLS.l1_abbrev,
			attrib_value	varchar(50)

		) sa
),
w_match AS (
	SELECT  
		ma.model_id,
		--ma.abbrev,
		--ma.l2_desc,
		SUM(CASE WHEN ma.l2_desc = w.attrib_value THEN 1 ELSE 0 END) AS score
	FROM 
		GRLS.bv_model_attribute_simple ma 
		LEFT OUTER JOIN	w_search_attribs w
		ON ma.abbrev = w.abbrev
	GROUP BY  
		ma.model_id
)
*/
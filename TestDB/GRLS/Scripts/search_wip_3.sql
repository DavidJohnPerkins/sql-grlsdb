DECLARE @mode char(3)='ALL'
DECLARE @p_input_json COMMON.json
SET @p_input_json = '
	{
		"name_search_term":		"%%",
		"search_mode_flag":		"ALL",
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
		]
	}'
SET @p_input_json = '
	{
		"name_search_term":		"%%",
		"search_mode_flag":		"ALL",
		"flag_type":			"MOD",
		"search_flags": [
			{ "flag_abbrev": "WMNCHILD", "selected": 1 },
			{ "flag_abbrev": "SMLBRSTS", "selected": 1 }
		]
	}'
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
	inner join GRLS.flag_search(@p_input_json, @flagsum) fs 
	ON p.model_id = fs.object_id
--	INNER JOIN w_id w 
--	on p.model_id = w.model_id
where 
	scheme_abbrev='SIMPLE'
order by 
	p.model_name

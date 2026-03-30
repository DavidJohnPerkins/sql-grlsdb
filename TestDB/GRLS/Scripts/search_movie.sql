--DECLARE @mode char(3)='ALL'
DECLARE @p_input_json COMMON.json = '
	{
		"search_term":			"%",
		"search_mode_flag":		"ALL",
		"minimum_rating":		1,
		"flag_type":			"MOV",
		"search_flags": [
			{ "flag_abbrev": "ANLINGUS", "selected": 0 },
			{ "flag_abbrev": "CNLINGUS", "selected": 0 },
			{ "flag_abbrev": "EXCEPTNL", "selected": 0 },
			{ "flag_abbrev": "MASTBATE", "selected": 0 },
			{ "flag_abbrev": "PENETRTE", "selected": 1 },
			{ "flag_abbrev": "SHWRBATH", "selected": 0 },
			{ "flag_abbrev": "SWIMPOOL", "selected": 0 },
			{ "flag_abbrev": "TOYSOBJS", "selected": 0 }
		]
	}'

	DECLARE @flagsum GRLS.kv_pair_int
	INSERT INTO @flagsum
	SELECT 
		m.id,
		SUM(fb.bin_val) AS flag_sum
	FROM 
		GRLS.movie m 
		INNER JOIN GRLS.movie_flag mf
			INNER JOIN GRLS.bv_flag_binary fb 
			ON mf.flag_id = fb.flag_id
		ON m.id = mf.movie_id
	WHERE
		m.comment LIKE JSON_VALUE(@p_input_json, '$."search_term"') AND
		m.rating >= JSON_VALUE(@p_input_json, '$."minimum_rating"')
	GROUP BY 
		m.id
--select * from @flagsum

/*
	DECLARE @mode		char(3) = JSON_VALUE(@p_input_json, '$."search_mode_flag"'),
			@flag_type	char(3) = JSON_VALUE(@p_input_json, '$."flag_type"');

	WITH w_flags AS (
		SELECT
			f.flag_abbrev	AS flag_abbrev,
			f.selected		AS bit
		FROM 
			OPENJSON (@p_input_json, '$.search_flags')
			WITH
			(
				flag_abbrev	char(8),
				selected	bit
			) f
		WHERE
			f.selected = 1
	), --select * from w_flags,
	w_searchsum AS (
		SELECT 
			SUM(fb.bin_val) AS srchsum
		FROM 
			GRLS.bv_flag_binary fb
			INNER JOIN GRLS.flag f
				INNER JOIN GRLS.flag_type ft
				ON f.flag_type = ft.id
				INNER JOIN w_flags i
				ON f.flag_abbrev = i.flag_abbrev
			ON fb.flag_abbrev = f.flag_abbrev
		WHERE
			ft.flag_type_abbrev = @flag_type AND 
			fb.flag_type_abbrev = @flag_type
	) --select * from w_searchsum
--	INSERT @result 
	SELECT 
		fs.key_value
	FROM 
		w_searchsum w,
		@flagsum fs
		--LEFT OUTER JOIN @flagsum fs
		--ON m.id = fs.key_value
	WHERE 
		((fs.data_value & w.srchsum != 0 AND @mode = 'ANY') OR 
		(fs.data_value & w.srchsum = w.srchsum AND @mode = 'ALL')) OR 
		w.srchsum IS NULL
*/
/*
;WITH w_id AS (
	SELECT
		m.id AS movie_id
	FROM
		GRLS.movie m
	WHERE
		m.title LIKE JSON_VALUE(@p_input_json, '$."search_term"') AND
		m.rating >= JSON_VALUE(@p_input_json, '$."minimum_rating"')
),
*/
select 
	p.* 
from
	GRLS.movie p
	inner join GRLS.flag_search(@p_input_json, @flagsum) fs 
	ON p.id = fs.object_id
	--INNER JOIN w_id w 
	--on p.id = w.movie_id
order by 
	p.title

--select * from GRLS.bv_flag_binary

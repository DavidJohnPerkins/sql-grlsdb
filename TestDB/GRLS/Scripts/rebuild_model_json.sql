DECLARE @p_input_json		COMMON.json,
		@base_attribs		COMMON.base_attrib_add_list,
		@attribs			COMMON.attrib_add_list,
		@model_names		COMMON.name_add_list,
		@model_flags		COMMON.flag_add_list

SET @p_input_json = (
	SELECT
		m.sobriquet							AS 'base_attribs.sobriquet',
		CONVERT(int, m.hotness_quotient)	AS 'base_attribs.hot_quotient',
		ISNULL(m.year_of_birth, 0)			AS 'base_attribs.yob',
		m.comment							AS 'base_attribs.comment',
		model_names = (
			SELECT
				mn.model_name,
				mn.principal_name
			FROM 
				GRLS.model_name mn 
			WHERE 
				mn.model_id = m.id
			FOR JSON PATH
		),
		model_flags = (
			SELECT
				f.flag_abbrev
			FROM 
				GRLS.model_flag mf 
				INNER JOIN GRLS.flag f 
				ON mf.flag_id = f.flag_id
			WHERE 
				mf.model_id = m.id
			FOR JSON PATH
		),
		attribs = (
			SELECT
				l1.abbrev,
				CONVERT(decimal(2, 1), l1.standout_factor) AS standout_factor,
				options = (
					SELECT DISTINCT
						l2.l2_desc,
						1 AS 'selected'
					FROM 
						GRLS.v_attribute_list l2
					WHERE 
						l2.model_id = l1.model_id AND l2.id = l1.id
					FOR JSON PATH
				)
			FROM
				GRLS.v_attribute_list l1 
			WHERE 
				l1.model_id = m.id
			ORDER BY
				l1.abbrev
			FOR JSON PATH
		)
	FROM 
		GRLS.model m 
	WHERE
		m.sobriquet LIKE 'A%' order by m.sobriquet
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
)
select @p_input_json;
--select * from OPENJSON (@p_input_json, '$.model_names')
--select JSON_QUERY(@p_input_json, '$.model_names')
--select JSON_VALUE(@p_input_json, '$.base_attribs.sobriquet')


INSERT INTO @base_attribs
SELECT
	JSON_VALUE(@p_input_json, '$.base_attribs.sobriquet'),
	JSON_VALUE(@p_input_json, '$.base_attribs.hot_quotient'),
	JSON_VALUE(@p_input_json, '$.base_attribs.yob'),
	JSON_VALUE(@p_input_json, '$.base_attribs.comment')

INSERT INTO @model_names
SELECT
	a.model_name,
	a.principal_name
FROM OPENJSON (@p_input_json, '$.model_names')
WITH
(
	model_name		varchar(50),
	principal_name	bit
) a

INSERT INTO @model_flags
SELECT
	a.flag_abbrev
FROM OPENJSON (@p_input_json, '$.model_flags')
WITH
(
	flag_abbrev	char(8)
) a

INSERT INTO @attribs
SELECT
	a.abbrev,
	a.standout_factor,
	b.l2_desc,
	b.selected
FROM OPENJSON (@p_input_json, '$.attribs')
WITH
(
	abbrev				GRLS.l1_abbrev,
	standout_factor		float,
	options				COMMON.json AS JSON
) a
CROSS APPLY OPENJSON (a.options)
WITH
(
	l2_desc		GRLS.l2_desc,
	selected	bit
) b

select * from @base_attribs
select * from @model_names
select * from @model_flags
select * from @attribs

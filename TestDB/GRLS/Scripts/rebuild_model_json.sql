DECLARE @p_input_json		COMMON.json,
		@base_attribs		COMMON.base_attrib_add_list,
		@attribs			COMMON.attrib_add_list,
		@model_names		COMMON.name_add_list,
		@sobr				GRLS.sobriquet,
		@hquo				int,
		@yob				int,
		@names_json			COMMON.json,
		@attribs_json		COMMON.json,
		@base_attribs_json	COMMON.json

SET @p_input_json = (
	SELECT
		m.sobriquet AS 'base_attribs.sobriquet',
		CONVERT(int, m.hotness_quotient) AS 'base_attribs.hot_quotient',
		ISNULL(m.year_of_birth, 0) AS 'base_attribs.yob',
		model_names = (
			SELECT
				mn.model_name,
				mn.principal_name
				FROM GRLS.model_name mn WHERE mn.model_id = m.id
			FOR JSON PATH
		),
		attribs = (
			SELECT
				l1.abbrev,
				options = (
					SELECT 
						l2.l2_desc,
						1 AS 'selected'
					FROM 
						GRLS.attribute_level_2 l2
						INNER JOIN GRLS.model_attribute ma
						ON l2.l2_id = ma.attribute_id AND l2.l1_id = l1.l1_id
					WHERE 
						ma.model_id = m.id
					FOR JSON PATH
				) 
			FROM 
				GRLS.attribute_level_1 l1
			ORDER BY
				l1.abbrev
			FOR JSON PATH
		)
	FROM GRLS.model m where sobriquet='TALIA'
	FOR JSON PATH
)
select @p_input_json

;WITH w_top_level AS (
	SELECT
		c.base_attribs	AS base_attribs,
		c.model_names	AS model_names,
		c.attribs 		AS attribs
	FROM OPENJSON (@p_input_json)
	WITH
	(
		base_attribs	COMMON.json AS JSON,
		model_names 	COMMON.json AS JSON,
		attribs 		COMMON.json AS JSON
	) c
)
SELECT
	@base_attribs_json	= w.base_attribs,
	@names_json			= w.model_names,
	@attribs_json		= w.attribs
FROM 
	w_top_level w

INSERT INTO @base_attribs
SELECT
	a.sobriquet,
	a.hot_quotient,
	a.yob
FROM OPENJSON(@base_attribs_json)
WITH (
	sobriquet		GRLS.sobriquet, 
	hot_quotient 	int,
	yob				int
) a

INSERT INTO @model_names
SELECT
	a.model_name,
	a.principal_name
FROM OPENJSON (@names_json)
WITH
(
	model_name		varchar(50),
	principal_name	bit
) a

INSERT INTO @attribs
SELECT
	a.abbrev,
	b.l2_desc,
	b.selected
FROM OPENJSON (@attribs_json)
WITH
(
	abbrev	GRLS.l1_abbrev,
	options	COMMON.json AS JSON
) a
CROSS APPLY OPENJSON (a.options)
WITH
(
	l2_desc		GRLS.l2_desc,
	selected	bit
) b

select * from @base_attribs
select * from @model_names
select * from @attribs

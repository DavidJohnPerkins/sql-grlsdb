USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS UTILS.text_search
GO

CREATE VIEW UTILS.text_search AS

SELECT
	s.name		AS [schema],
	o.name 		AS [object],
	o.type_desc AS [object_type],
	c.text		AS [object_definition]
FROM
	sys.all_objects o 
	INNER JOIN sys.schemas s
	ON o.schema_id = s.schema_id
	INNER JOIN sys.syscomments c
	ON o.object_id = c.id
WHERE 
	s.schema_id NOT IN (3, 4) AND 	-- avoid searching in sys and INFORMATION_SCHEMA schemas
	c.text LIKE '%attribute_value_list%'

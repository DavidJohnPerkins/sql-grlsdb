USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_model_extended') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_model_extended
	PRINT '########## GRLS.v_model_extended dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_model_extended AS

	SELECT 
		m.id,
		m.sobriquet,
		CASE WHEN CHARINDEX('/', nm.aliases) = 0 THEN nm.aliases ELSE LEFT(nm.aliases, CHARINDEX('/', nm.aliases) - 2) END AS principal_name,
		CASE WHEN CHARINDEX('/', nm.aliases) = 0 THEN NULL ELSE SUBSTRING(nm.aliases, CHARINDEX('/', nm.aliases) + 2, 255) END AS aliases,
		m.hotness_quotient,
		m.year_of_birth,
		al.l2_desc AS nationality
	FROM
		GRLS.model m
		OUTER APPLY (
			SELECT
				STRING_AGG(x.model_name, ' / ') AS aliases 
			FROM (
				SELECT
					mn.model_name
				FROM 
					GRLS.model_name mn
				WHERE
					mn.model_id = m.id
				ORDER BY
					mn.principal_name DESC,
					mn.model_name OFFSET 0 ROWS) x
		) nm
		INNER JOIN GRLS.v_attribute_list al 
		ON m.id = al.model_id AND al.abbrev = 'NATN'
		
GO
PRINT '########## GRLS.v_model_extended created successfully ##########'

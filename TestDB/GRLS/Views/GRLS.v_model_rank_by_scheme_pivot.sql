USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.v_model_rank_by_scheme_pivot') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.v_model_rank_by_scheme_pivot
	PRINT '########## GRLS.v_model_rank_by_scheme_pivot dropped successfully ##########'
END
GO

CREATE VIEW GRLS.v_model_rank_by_scheme_pivot AS

	SELECT
		piv.* 
	FROM 
		(
			SELECT 
				s.scheme_abbrev AS scheme,
				m.id AS model_id,
				m.sobriquet,
				mn.model_name,
				r.rank
			FROM 
				GRLS.v_model_rank_by_scheme r
				INNER JOIN GRLS.attribute_scheme s
				ON r.scheme_id = s.scheme_id
				INNER JOIN GRLS.model m 
					INNER JOIN GRLS.model_name mn 
					ON m.id = mn.model_id AND mn.principal_name = 1
				ON r.model_id = m.id
			WHERE 
				m.is_excluded = 0
			) d
		PIVOT
		(
			MAX(rank)
			FOR d.scheme IN (LATEADOL, FULLERFIGURE, NOPREF, SIMPLE)
		) piv
		
GO
PRINT '########## GRLS.v_model_rank_by_scheme_pivot created successfully ##########'

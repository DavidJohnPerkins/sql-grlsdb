USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.pv_movie_list') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.pv_movie_list
	PRINT '########## GRLS.pv_movie_list dropped successfully ##########'
END
GO

CREATE VIEW GRLS.pv_movie_list AS

	SELECT
		m.id,
		LEFT(m.title, CHARINDEX('.', m.title) - 1) AS title,
		m.comment,
		m.rating,
		m.participants,
		f.flags,
		n.[names]
	FROM
		GRLS.movie m
		OUTER APPLY (
			SELECT
				STRING_AGG(x.flag_abbrev, '/') AS flags
			FROM (
				SELECT
					fl.flag_abbrev
				FROM
					GRLS.movie_flag mf
					INNER JOIN GRLS.fv_movie_flag fl
					ON mf.flag_id = fl.flag_id
				WHERE
					mf.movie_id = m.id
				ORDER BY
					fl.flag_abbrev OFFSET 0 ROWS) x
		) f
		OUTER APPLY (
			SELECT
				STRING_AGG(x.model_name, ' / ') AS names
			FROM (
				SELECT
					mn.model_name
				FROM 
					GRLS.movie_model mm
					LEFT OUTER JOIN GRLS.model_name mn
					ON mm.model_id = mn.model_id
				WHERE
					mm.movie_id = m.id AND
					mn.is_principal_name = 1
				ORDER BY
					mn.model_name OFFSET 0 ROWS) x
		) n
		
GO
PRINT '########## GRLS.pv_movie_list created successfully ##########'

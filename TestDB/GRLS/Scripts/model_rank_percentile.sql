		SELECT
			m.id,
			m.is_excluded,
			m.sobriquet,
			m.principal_name,
			m.hotness_quotient,
			m.nationality,
			m.ranking,
			m.flags,
			m.TH_url,
			m.movie_count,
            NTILE(10) OVER (ORDER BY convert(int, replace(ranking, '/241', ''))) AS pc_rank
		FROM 
			GRLS.pv_model_short m 
where is_excluded=0
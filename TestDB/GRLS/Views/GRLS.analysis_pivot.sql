USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS GRLS.analysis_pivot
GO

CREATE VIEW GRLS.analysis_pivot AS

	SELECT
		piv.*
	FROM
	(
		SELECT
			ba.model_id,
			ba.sobriquet,
			ba.hotness_quotient,
			ba.abbrev,
			ba.l2_desc + ' (' + CONVERT(varchar, ba.adj_preference) + ')' AS x
		FROM
			GRLS.basic_analysis ba
		) d
	PIVOT
	(
  		MAX(x)
	FOR d.abbrev IN (
					ASHP,
					ASIZ,
					ATTR,
					BILD,
					BRSH,
					BRDR,
					BSIZ,
					CMPX,
					ETHN,
					EYES,
					HAIR,
					MONS,
					NPCL,
					NPSH,
					NPSZ,
					PUAT,
					YTHF)
	) piv;

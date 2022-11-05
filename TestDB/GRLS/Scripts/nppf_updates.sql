DECLARE @updates TABLE (
	sobriquet	GRLS.sobriquet,
	l2_desc 	varchar(50)
)
INSERT INTO @updates VALUES
('IVETA',		'Slightly Pert'),
('AUBREY_SNOW',	'Flat'),
('CIRA',		'Slightly Pert'),
('SYBIL_A',		'Slightly Pert'),
('ZELDA',		'Very Pert'),
('KARA',		'Pert'),
('SARAH',		'Very Pert'),
('MICHELLE_H',	'Pert'),
('MONIKA_DEE',	'Pert'),
('ARIA_A',		'Very Pert'),
('KATHERINNE',	'Very Pert'),
('APOLONIA',	'Very Pert'),
('GRACE',		'Flat'),
('NELA',		'Slightly Pert'),
('EKATERINA_D',	'Flat'),
('ETNA',		'Slightly Pert'),
('TINA',		'Flat'),
('BRIDGIT',		'Slightly Pert'),
('ELISA',		'Pert'),
('SANTA',		'Very Pert'),
('KYLIE_QUINN',	'Flat'),
('GEORGIA',		'Slightly Pert')

BEGIN TRY 
	BEGIN TRANSACTION;

	WITH w_p AS (
		SELECT DISTINCT 
			b.model_id, 
			b.sobriquet,
			b.l2_desc 
		FROM
			GRLS.v_analysis_base b 
		WHERE
			b.abbrev = 'NPSH' AND
			b.l2_desc like '%Puffy%'
	),
	w_not_p AS (
		SELECT DISTINCT 
			b.model_id, 
			b.sobriquet,
			'Not Puffy' AS l2_desc 
		FROM
			GRLS.v_analysis_base b 
			LEFT OUTER JOIN w_p w 
			ON b.model_id = w.model_id
		WHERE
			w.model_id IS NULL
	),
		w_u AS (
		SELECT 
			p.* 
		FROM 
			w_p p 
		UNION 
		SELECT 
			np.* 
		FROM 
			w_not_p np 
	)
	INSERT INTO GRLS.model_attribute 
	SELECT DISTINCT
		u.model_id,
		va.l2_id
	FROM 
		w_u u 
		INNER JOIN GRLS.v_attribute va
		ON u.l2_desc = va.l2_desc
	WHERE 
		va.abbrev = 'NPPF'

	DELETE 
		ma 
	FROM 
		GRLS.model_attribute ma
		INNER JOIN GRLS.v_attribute_list al
			INNER JOIN @updates u 
			ON al.sobriquet = u.sobriquet COLLATE DATABASE_DEFAULT
		ON ma.id = al.id
	WHERE 
		al.abbrev = 'NPSH'

	INSERT INTO GRLS.model_attribute 
	SELECT DISTINCT
		m.id,
		va.l2_id
	FROM
		GRLS.v_attribute va
		INNER JOIN @updates u 
			INNER JOIN GRLS.model m 
			ON u.sobriquet = m.sobriquet COLLATE DATABASE_DEFAULT
		ON va.l2_desc = u.l2_desc COLLATE DATABASE_DEFAULT
	WHERE 
		va.abbrev = 'NPSH'

	DELETE 
		l2d 
	FROM 
		GRLS.attribute_level_2_detail l2d 
		INNER JOIN GRLS.v_attribute va 
		ON l2d.l2_id = va.l2_id
	WHERE
		va.abbrev = 'NPSH' AND 
		va.l2_desc LIKE '%Puffy%'

	COMMIT TRANSACTION
END TRY 
BEGIN CATCH 
	ROLLBACK TRANSACTION 
END CATCH

USE TestDB
GO

DECLARE @new_abbrev 	char(4) = 'NPPF',
		@new_l1_desc	varchar(50) = 'Nipple Puffiness',
		@new_l1_weight 	int = 5,
		@new_l1_id		int 

DECLARE @output TABLE (
	l2_id 		int,
	l2_desc 	varchar(50)
)

DECLARE @work TABLE (
	l2_desc 		varchar(50),
	l2_preference 	int
)

INSERT INTO @work VALUES 
('Not Puffy', 		18),
('Slightly Puffy',	16),
('Puffy',			14),
('Very Puffy',		12)

BEGIN TRY 

	BEGIN TRANSACTION

	IF EXISTS (SELECT 1 FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @new_abbrev)
	BEGIN

		SET @new_l1_id = (SELECT l1.l1_id FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @new_abbrev)

		DELETE 
			ma 
		FROM 
			GRLS.model_attribute ma 
			INNER JOIN GRLS.attribute_level_2 l2
				INNER JOIN GRLS.attribute_level_1 l1 
				ON l2.l1_id = l1.l1_id
			ON ma.attribute_id = l2.l2_id
		WHERE 
			l1.l1_id = @new_l1_id

		DELETE
			l2 
		FROM 
			GRLS.attribute_level_2 l2
			INNER JOIN GRLS.attribute_level_1 l1 
			ON l2.l1_id = l1.l1_id
		WHERE
			l1.l1_id = @new_l1_id

		DELETE
			l1
		FROM 
			GRLS.attribute_level_1 l1 
		WHERE
			l1.l1_id = @new_l1_id
	END

	INSERT INTO GRLS.attribute_level_1 (l1_desc, abbrev, for_aggregation) VALUES 
	(@new_l1_desc, @new_abbrev, 1)

	SET @new_l1_id = @@IDENTITY

	INSERT INTO GRLS.attribute_level_1_detail (l1_id, scheme_id, attr_weight)
	SELECT 
		@new_l1_id,
		s.scheme_id,
		@new_l1_weight
	FROM
		GRLS.attribute_scheme s

	INSERT INTO GRLS.attribute_level_2(l1_id, l2_desc) 
	OUTPUT INSERTED.l2_id, INSERTED.l2_desc INTO @output
	SELECT
		@new_l1_id,	
		l2_desc
	FROM 
		@work

	INSERT INTO GRLS.attribute_level_2_detail (l2_id, scheme_id, l2_preference)
	SELECT
		o.l2_id,
		s.scheme_id,
		w.l2_preference
	FROM 
		GRLS.attribute_scheme s,
		@work w
		INNER JOIN @output o
		ON w.l2_desc = o.l2_desc

	COMMIT TRANSACTION
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH

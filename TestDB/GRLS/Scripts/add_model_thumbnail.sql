USE TestDB
GO

DECLARE @sobr GRLS.sobriquet = ''

DECLARE	@model_id	int = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @sobr)

DECLARE @images_json	COMMON.json = '
	{
		"sobriquet":	"~sobr",
		"update_type":	"C",
		"images": [
			{
				"image_type_abbrev":	"TH",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"RF",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"FA",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"BR",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"PF",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"PR",
				"is_mono":				0,
				"image_url":			""
			},
			{
				"image_type_abbrev":	"AR",
				"is_mono":				0,
				"image_url":			""
			}
		]
	}
'
SET @images_json = REPLACE(@images_json, '~sobr', @sobr)

--			{ "flag_abbrev": "WMNCHILD" }
--			{ "flag_abbrev": "EXCEPTNL" }
DECLARE @flags_json	COMMON.json = '
	{
		"sobriquet":	"~sobr",
		"update_type":	"C",
		"model_flags": [
		]
	}
'
SET @flags_json = REPLACE(@flags_json, '~sobr', @sobr)

/*
DECLARE @sof TABLE (
	abbrev char(4),
	standout_factor	float
)
INSERT INTO @sof VALUES
('ASHP', 1.),
('ASIZ', 1.),
('ATTR', 1.),
('BILD', 1.),
('BRDR', 1.),
('BRSH', 1.),
('BSIZ', 1.),
('CMPX', 1.),
('ETHN', 1.),
('EYES', 1.),
('HAIR', 1.),
('MONS', 1.),
('NATN', 1.),
('NPCL', 1.),
('NPPF', 1.),
('NPSH', 1.),
('NPSZ', 1.),
('PUAT', 1.),
('YTHF', 1.)
*/

BEGIN TRY 

	BEGIN TRANSACTION

/*
	UPDATE 
		m 
	SET 	
		--hotness_quotient = 10,
		comment = ''
	FROM 
		GRLS.model m
	WHERE 
		m.id = @model_id
*/		
	EXEC GRLS.c_model_image_web_json @images_json, 0, 1

	EXEC GRLS.c_model_flag_json @flags_json, 0, 1

/*
	UPDATE
		ma 
		SET standout_factor = s.standout_factor
	FROM 
		GRLS.model_attribute ma 
		INNER JOIN GRLS.attribute_level_2 l2 
			INNER JOIN GRLS.attribute_level_1 l1 
				INNER JOIN @sof s 
				ON l1.abbrev = s.abbrev COLLATE database_default
			ON l2.l1_id = l1.l1_id
		ON ma.attribute_id = l2.l2_id 
	WHERE 
		ma.model_id = @model_id
*/

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int
	
		 IF @@TRANCOUNT != 0
		 	ROLLBACK TRANSACTION

		SELECT   
			@error_message = ERROR_MESSAGE(),  
			@error_severity = ERROR_SEVERITY(),  
			@error_state = ERROR_STATE();  

		RAISERROR (@error_message,
				@error_severity,
				@error_state
				)
END CATCH
--ROLLBACK TRANSACTION;

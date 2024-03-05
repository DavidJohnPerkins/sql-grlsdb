USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_image') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_image
	PRINT '########## COMMON.c_image dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_image
	@p_base_attribs	COMMON.base_attrib_add_list_image	READONLY,
	@p_models		COMMON.image_model_add_list			READONLY,
	@p_attribs		COMMON.attrib_add_list 				READONLY,
	@p_debug		bit = 0,
	@p_execute		bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @image_id		int,
			@image_url		COMMON.image_url 	= (SELECT ba.image_url FROM @p_base_attribs ba),
			@is_monochrome	bit					= (SELECT ba.is_monochrome FROM @p_base_attribs ba)

	BEGIN TRY
	
		IF @p_debug = 1
			SELECT * FROM @p_attribs

		IF @image_url IS NULL
   			RAISERROR ('The image_url value is not found - operation failed.', 16, 1)

		IF @is_monochrome IS NULL OR @is_monochrome NOT IN (0, 1)
   			RAISERROR ('The is_monochrome value is not found or is invalid- operation failed.', 16, 1)

		IF (SELECT COUNT(1) FROM @p_models) = 0
   			RAISERROR ('At least one model is required - operation failed.', 16, 1)

		IF EXISTS (
			SELECT
				1
			FROM
				@p_models p
				LEFT OUTER JOIN GRLS.model m 
				ON p.sobriquet = m.sobriquet COLLATE DATABASE_DEFAULT 
			WHERE 
				m.sobriquet IS NULL 
			)
			RAISERROR ('One or more model sobriquets not found - operation failed.', 16, 1)

		IF 	EXISTS (SELECT a.abbrev COLLATE DATABASE_DEFAULT FROM @p_attribs a EXCEPT SELECT b.ia_abbrev FROM GRLS.image_attribute_level_1 b) OR
			EXISTS (SELECT a.ia_abbrev FROM GRLS.image_attribute_level_1 a EXCEPT SELECT b.abbrev COLLATE DATABASE_DEFAULT FROM @p_attribs b)
				RAISERROR ('There are missing or invalid attributes - operation failed.', 16, 1)

		IF EXISTS (
			SELECT 
				a.abbrev,
				SUM(CASE a.selected WHEN 1 THEN 1 ELSE 0 END) AS num_selected
			FROM 
				@p_attribs a
			GROUP BY 
				a.abbrev
			HAVING
				SUM(CASE a.selected WHEN 1 THEN 1 ELSE 0 END) != 1
			)
			RAISERROR ('One, and only one, option must be selected for each attribute - operation failed.', 16, 1)

		BEGIN TRANSACTION

		INSERT INTO GRLS.image (image_url, is_monochrome)
			SELECT
				ba.image_url,
				ba.is_monochrome
			FROM 
				@p_base_attribs ba

			SET @image_id = @@IDENTITY

		INSERT INTO GRLS.image_model
		SELECT
			@image_id ,
			m.id,
			p.reference_image
		FROM 
			@p_models p
			INNER JOIN GRLS.model m
			ON p.sobriquet = m.sobriquet COLLATE DATABASE_DEFAULT
			
		INSERT INTO GRLS.image_attribute (image_id, image_attr_l2_id)
		SELECT
			@image_id ,
			av.ia_l2_id
		FROM
			@p_attribs a
			CROSS APPLY GRLS.image_attribute_values(a.abbrev, a.l2_desc) av
		WHERE 
			a.selected = 1

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Transaction rolled back - no changes made'
		END

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

END
GO
PRINT '########## COMMON.c_image created successfully ##########'

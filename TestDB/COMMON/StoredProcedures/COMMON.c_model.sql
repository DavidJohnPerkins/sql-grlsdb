USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_model') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_model
	PRINT '########## COMMON.c_model dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_model
	@p_base_attribs	COMMON.base_attrib_add_list	READONLY,
	@p_attribs		COMMON.attrib_add_list 		READONLY,
	@p_model_names	COMMON.name_add_list		READONLY,
	@p_model_images	COMMON.web_image_add_list	READONLY,
	@p_model_flags	COMMON.flag_add_list		READONLY,
	@p_debug		bit = 0,
	@p_execute		bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @model_id	int,
			@image_id	int,
			@sobriquet	GRLS.sobriquet 		= (SELECT ba.sobriquet FROM @p_base_attribs ba),
			@hq			int					= (SELECT ba.hot_quotient FROM @p_base_attribs ba),
			@yob 		int					= (SELECT ba.yob FROM @p_base_attribs ba),
			@comment	nvarchar(MAX)		= (SELECT ba.comment FROM @p_base_attribs ba)

	BEGIN TRY
	
		IF @p_debug = 1
			SELECT * FROM @p_attribs

		IF @sobriquet IS NULL
   			RAISERROR ('The sobriquet value is not found - operation failed.', 16, 1)

		IF CHARINDEX(' ', @sobriquet, 0) != 0
   			RAISERROR ('The sobriquet cannot contain spaces - operation failed.', 16, 1)

		IF ISNULL(@comment, '') = '' 
   			RAISERROR ('The comment value was not found - operation failed.', 16, 1)
		
		IF @hq IS NULL
   			RAISERROR ('The hot_quotient value is not found - operation failed.', 16, 1)

		IF @hq < 1 OR @hq > 10 
   			RAISERROR ('The hot_quotient value must be from 1 - 10 - operation failed.', 16, 1)
		
		IF NOT @yob IS NULL
		BEGIN
			IF @yob != 0 AND @yob NOT BETWEEN 1980 AND 2005
	   			RAISERROR ('The yob value must be 0 or from 1980 - 2005 - operation failed.', 16, 1)
		END

		IF (SELECT COUNT(1) FROM @p_model_names mn WHERE mn.is_principal_name = 1) != 1
			RAISERROR ('There must be one, and only one, principal name - operation failed.', 16, 1)

		IF 	EXISTS (SELECT a.abbrev COLLATE DATABASE_DEFAULT FROM @p_attribs a EXCEPT SELECT b.abbrev FROM GRLS.attribute_level_1 b) OR
			EXISTS (SELECT a.abbrev FROM GRLS.attribute_level_1 a EXCEPT SELECT b.abbrev COLLATE DATABASE_DEFAULT FROM @p_attribs b)
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

		INSERT INTO GRLS.model (sobriquet, hotness_quotient, year_of_birth, comment)
			SELECT
				ba.sobriquet,
				ba.hot_quotient,
				ba.yob,
				ba.comment
			FROM 
				@p_base_attribs ba

			SET @model_id = @@IDENTITY

		INSERT INTO GRLS.model_attribute (model_id, attribute_id, standout_factor)
		SELECT
			@model_id ,
			av.l2_id ,
			a.standout_factor
		FROM
			@p_attribs a
			CROSS APPLY GRLS.attribute_values(a.abbrev, a.l2_desc) av
		WHERE 
			a.selected = 1

		INSERT INTO GRLS.model_name
		SELECT
			@model_id ,
			n.model_name ,
			n.is_principal_name
		FROM 
			@p_model_names n
			
		EXEC COMMON.c_model_flag @p_model_flags, @sobriquet, 'C'
		EXEC COMMON.c_model_image_web @p_model_images, @sobriquet, 'C'

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
PRINT '########## COMMON.c_model created successfully ##########'

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_model_image_web') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_model_image_web
	PRINT '########## COMMON.c_model_image_web dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_model_image_web
	@p_images			COMMON.web_image_add_list READONLY,
	@p_model_sobriquet	GRLS.sobriquet,
	@p_update_type		char(1),
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @inserted TABLE (
		image_url	GRLS.image_url,
		image_id	int
	)

	DECLARE @work TABLE (
		model_id		int,
		image_url		GRLS.image_url,
		image_type_id	int,
		is_mono			bit
	)

	DECLARE @v_model_id int 
	SET @v_model_id = (SELECT m.id FROM GRLS.model m WHERE m.sobriquet = @p_model_sobriquet)

	IF @v_model_id IS NULL
		RAISERROR ('Model with sobriquet %s not found - operation failed.', 16, 1, @p_model_sobriquet)

	IF @p_update_type NOT IN ('C', 'R')
   		RAISERROR ('Update type must be C or R - operation failed.', 16, 1)

	IF 	EXISTS (SELECT i.image_type_abbrev FROM @p_images i EXCEPT SELECT t.image_type_abbrev FROM GRLS.image_type t)
		RAISERROR ('There are invalid image types in the input data - operation failed.', 16, 1)

	IF EXISTS (SELECT t.image_type_abbrev FROM GRLS.image_type t WHERE t.image_type_abbrev != 'OT' EXCEPT SELECT i.image_type_abbrev FROM @p_images i)
		RAISERROR ('There are missing web image abbreviations in the input data - operation failed.', 16, 1)


	INSERT INTO @work
	SELECT 
		@v_model_id,
		p.image_url,
		t.image_type_id,
		p.is_mono
	FROM 
		@p_images p 
		INNER JOIN GRLS.image_type t 
		ON p.image_type_abbrev = t.image_type_abbrev

	BEGIN TRY

		BEGIN TRANSACTION

		INSERT INTO GRLS.[image] (image_url, is_monochrome)
		OUTPUT INSERTED.image_url, INSERTED.image_id INTO @inserted
		SELECT 
			w.image_url,
			w.is_mono
		FROM
			@work w
			LEFT OUTER JOIN GRLS.[image] i 
			ON w.image_url = i.image_url
		WHERE 
			i.image_url IS NULL

		INSERT INTO GRLS.image_model (image_id, model_id, image_type_id)
		SELECT 
			ins.image_id,
			@v_model_id,
			t.image_type_id
		FROM 
			@p_images i1
			INNER JOIN @inserted ins
			ON i1.image_url = ins.image_url
			INNER JOIN GRLS.image_type t 
			ON i1.image_type_abbrev = t.image_type_abbrev

		IF @p_debug = 1
			PRINT 'IMAGE WEB INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'IMAGE WEB COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Image web insert transaction rolled back - no changes made'
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
PRINT '########## COMMON.c_model_image_web created successfully ##########'

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.c_model_movie_json') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.c_model_movie_json
	PRINT '########## GRLS.c_model_movie_json dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.c_model_movie_json
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @v_model_sobriquet	GRLS.sobriquet,
			@v_update_type		char(1),
			@v_movie			COMMON.string_add_list

	BEGIN TRY

		SET @v_model_sobriquet = (SELECT JSON_VALUE(@p_input_json, '$."sobriquet"'))
		SET @v_update_type = (SELECT JSON_VALUE(@p_input_json, '$."update_type"'))

		INSERT INTO @v_movie (string_value)
		SELECT
			m.movie_title
		FROM 
			OPENJSON (@p_input_json, '$.movie_titles')
			WITH
			(
				movie_title	varchar(255)
			) m

	EXEC COMMON.c_model_movie @v_movie, @v_model_sobriquet, @v_update_type, @p_debug, @p_execute

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
PRINT '########## GRLS.c_model_movie_json created successfully ##########'

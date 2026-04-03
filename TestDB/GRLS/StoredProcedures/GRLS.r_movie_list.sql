USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_movie_list') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_movie_list
	PRINT '########## GRLS.r_movie_list dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_movie_list
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 

		DECLARE @model_id				int = (SELECT JSON_VALUE(@p_input_json, '$."model_id"')),
				@title_search_term		varchar(50) = (SELECT JSON_VALUE(@p_input_json, '$."title_search_term"')),
				@comment_search_term	varchar(50) = (SELECT JSON_VALUE(@p_input_json, '$."comment_search_term"')),
				@min_rating				int = (SELECT JSON_VALUE(@p_input_json, '$."minimum_rating"'))

		IF ISNULL(@model_id, '') = ''
			RAISERROR ('The model_id attribute is not present - operation failed.', 16, 1)

		IF ISNULL(@min_rating, 0) = 0
			RAISERROR ('The minumum rating attribute is not present - operation failed.', 16, 1)

		IF ISNULL(@title_search_term, '') = ''
			SET @title_search_term = '%'

		IF ISNULL(@comment_search_term, '') = ''
			SET @comment_search_term = '%'

		IF @p_execute = 1
		BEGIN
			IF @model_id = -1
			BEGIN
				SELECT
					m.*,
					UPPER(LEFT(m.title, 1)) AS image_folder
				FROM 
					GRLS.pv_movie_list m
				WHERE
					m.rating >= @min_rating AND 
					m.title LIKE @title_search_term AND
					m.comment LIKE @comment_search_term 
			END
			ELSE
			BEGIN
				SELECT
					m.*,
					UPPER(LEFT(m.title, 1)) AS image_folder
				FROM 
					GRLS.pv_movie_list m
					INNER JOIN GRLS.movie_model mm
					ON m.id = mm.movie_id AND mm.model_id = @model_id
			END	
		END
	END TRY

	BEGIN CATCH  
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int

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
PRINT '########## GRLS.r_movie_list created successfully ##########'

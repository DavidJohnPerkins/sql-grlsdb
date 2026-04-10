USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_model') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_model
	PRINT '########## GRLS.r_model dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_model
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 

		DECLARE @model_id		int = (SELECT JSON_VALUE(@p_input_json, '$."model_id"')),
				@search_term	varchar(50) = (SELECT JSON_VALUE(@p_input_json, '$."search_term"')),
				@show_excluded	bit = (SELECT e.show_excluded FROM COMMON.bv_environment e)

		IF ISNULL(@model_id, '') = ''
			RAISERROR ('The model_id attribute is not present - operation failed.', 16, 1)

		IF ISNULL(@search_term, '') = ''
			SET @search_term = '%'
			--RAISERROR ('The search_term attribute is not present - operation failed.', 16, 1)

		IF @p_debug = 1 
			PRINT @model_id

		IF @p_execute = 1
		BEGIN
			IF @model_id != -1
			BEGIN
				SELECT
					m.id,
					m.is_excluded,
					m.sobriquet,
					m.principal_name,
					COALESCE(m.aliases, '') AS aliases,
					m.hotness_quotient,
					m.ranking,
					m.year_of_birth,
					m.nationality,
					COALESCE(m.flags, '') AS flags,
					m.comment,
					m.movie_count,
					m.TH_url,
					m.RF_url,
					m.FA_url,
					m.BR_url,
					m.PF_url,
					m.PR_url,
					m.AR_url
				FROM 
					GRLS.pv_model_extended m
				WHERE 
					m.id = @model_id
			END
			ELSE
			BEGIN
				SELECT
					m.id,
					m.is_excluded,
					m.sobriquet,
					m.principal_name,
					COALESCE(m.aliases, '') AS aliases,
					m.hotness_quotient,
					m.ranking,
					m.year_of_birth,
					m.nationality,
					COALESCE(m.flags, '') AS flags,
					m.comment,
					m.movie_count,
					m.TH_url,
					m.RF_url,
					m.FA_url,
					m.BR_url,
					m.PF_url,
					m.PR_url,
					m.AR_url
				INTO
					#temp
				FROM 
					GRLS.pv_model_extended m
				WHERE
					(m.is_excluded = 0 OR m.is_excluded = @show_excluded)
				
				SELECT 
					t.*
				FROM
					#temp t 
				WHERE
					t.principal_name LIKE @search_term
				ORDER BY
					t.principal_name

				DROP TABLE #temp
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
PRINT '########## GRLS.r_model created successfully ##########'

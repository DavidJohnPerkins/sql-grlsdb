USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_model_card_list') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_model_card_list
	PRINT '########## GRLS.r_model_card_list dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_model_card_list
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 
		DECLARE @search_term varchar(50) = (SELECT JSON_VALUE(@p_input_json, '$."search_term"')),
				@show_excluded	bit = (SELECT e.show_excluded FROM COMMON.bv_environment e)

		IF ISNULL(@search_term, '') = ''
			RAISERROR ('The search_term attribute is not present - operation failed.', 16, 1)

		IF @p_execute = 1
		BEGIN
		WITH w_id AS (
			SELECT
				n.model_id,
				SUM(fb.bin_val) AS flag_sum
			FROM
				GRLS.model_name n
				INNER JOIN GRLS.model_flag mf
					INNER JOIN GRLS.bv_flag_binary fb 
					ON mf.flag_id = fb.flag_id
				ON n.model_id = mf.model_id
			WHERE
				n.is_principal_name = 1 AND
				n.model_name LIKE @search_term
			GROUP BY 
				n.model_id
		), --select * from w_id,
		w_flags AS (
			SELECT
				f.value	AS flag_abbrev
			FROM 
				OPENJSON (@p_input_json, '$.search_flags') f
		), --select * from w_flags,
		w_searchsum AS (
			SELECT 
				SUM(fb.bin_val) AS srchsum
			FROM 
				GRLS.bv_flag_binary fb
				INNER JOIN GRLS.flag f
					INNER JOIN GRLS.flag_type ft
					ON f.flag_type = ft.id
					INNER JOIN w_flags i
					ON f.flag_abbrev = i.flag_abbrev
				ON fb.flag_abbrev = f.flag_abbrev
			WHERE
				ft.flag_type_abbrev = 'MOD' AND 
				fb.flag_type_abbrev = 'MOD'
		),
		w_search_flag_result AS (
			SELECT 
				w_id.model_id
			FROM 
				w_searchsum wss,
				w_id w_id
			WHERE 
				(w_id.flag_sum & wss.srchsum = wss.srchsum) OR wss.srchsum IS NULL
		)
		SELECT
			m.id,
			m.is_excluded,
			m.sobriquet,
			m.principal_name,
			m.hotness_quotient,
			m.nationality,
			m.ranking,
			m.flags,
			m.TH_url,
			m.movie_count
		FROM 
			GRLS.pv_model_short m 
			INNER JOIN w_id w 
				INNER JOIN w_search_flag_result sfr
				ON w.model_id = sfr.model_id
			ON m.id = w.model_id
		WHERE
			(m.is_excluded = 0 OR m.is_excluded = @show_excluded)
		ORDER BY
			m.principal_name
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
PRINT '########## GRLS.r_model_card_list created successfully ##########'

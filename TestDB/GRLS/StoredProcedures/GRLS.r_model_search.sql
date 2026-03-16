USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_model_search') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_model_search
	PRINT '########## GRLS.r_model_search dropped successfully ##########'
END
GO

/*
	-- Prototype JSON
	SET @p_input_json = '{
		"model_id": "-1",
		"search_term": "%iff%"
	}
	'
*/

CREATE PROCEDURE GRLS.r_model_search
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 

		DECLARE @search_term	varchar(50) = (SELECT JSON_VALUE(@p_input_json, '$."search_term"')),
				@show_excluded	bit = (SELECT e.show_excluded FROM COMMON.bv_environment e)

		IF ISNULL(@search_term, '') = ''
			RAISERROR ('The search_term attribute is not present - operation failed.', 16, 1)

		IF @p_execute = 1
		BEGIN
			WITH w_id AS (
				SELECT
					n.model_id
				FROM
					GRLS.model_name n
				WHERE
					n.is_principal_name = 1 AND
					n.model_name LIKE @search_term
			)
			SELECT
				m.*
			FROM
				GRLS.pv_model_extended m
				inner join w_id w on m.id = w.model_id
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
PRINT '########## GRLS.r_model_search created successfully ##########'

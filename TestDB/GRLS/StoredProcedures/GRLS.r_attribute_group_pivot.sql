USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_attribute_group_pivot') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_attribute_group_pivot
	PRINT '########## GRLS.r_attribute_group_pivot dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_attribute_group_pivot
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @cols			nvarchar(MAX),
    		@query			nvarchar(MAX),
			@group_abbrev	varchar(10),
			@scheme_abbrev	varchar(20)

	BEGIN TRY

		SET @scheme_abbrev = (SELECT JSON_VALUE(@p_input_json, '$."scheme_abbrev"'))
		SET @group_abbrev = (SELECT JSON_VALUE(@p_input_json, '$."group_abbrev"'))

		SELECT @cols = GRLS.l1_abbrevs_as_string(@group_abbrev) 

		SET @query = '
			SELECT 
				sobriquet, adj_total, ~cols 
			FROM 
				(
					SELECT 
						ga.sobriquet,
						ga.abbrev,
						ga.adj_preference,
						ga.adj_total
					FROM 
						GRLS.v_attribute_group_analysis ga
					WHERE 
						ga.l1_group_abbrev = ^~group^ AND
						ga.scheme_abbrev = ^~scheme^
				) x
			PIVOT 
				(
					MIN(adj_preference)
					FOR abbrev IN (~cols)
			) p '

		SET @query = REPLACE(@query, '~cols', @cols)
		SET @query = REPLACE(@query, '~scheme', @scheme_abbrev)
		SET @query = REPLACE(@query, '~group', @group_abbrev)
		SET @query = REPLACE(@query, '^', '''')

		IF @p_debug = 1 
			PRINT @query

		IF @p_execute = 1
			EXECUTE (@query)

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
PRINT '########## GRLS.r_attribute_group_pivot created successfully ##########'

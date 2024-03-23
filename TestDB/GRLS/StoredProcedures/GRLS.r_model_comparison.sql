USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_model_comparison') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_model_comparison
	PRINT '########## GRLS.r_model_comparison dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_model_comparison
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @models TABLE (
		sobriquet	GRLS.sobriquet
	);

	DECLARE @cols		nvarchar(MAX),
    		@query		nvarchar(MAX),
			@scheme_id	int

	BEGIN TRY

		SET @scheme_id = (SELECT s.scheme_id FROM GRLS.attribute_scheme s WHERE s.scheme_abbrev = (SELECT JSON_VALUE(@p_input_json, '$."scheme_abbrev"')))

		INSERT INTO @models
		SELECT
			c.sobriquet sobriquet
		FROM OPENJSON(@p_input_json, '$.sobriquets')
		WITH
		(
			sobriquet	GRLS.sobriquet
		) c

		UPDATE 
			m 
		SET 
			m.for_comparison = 0
		FROM 
			GRLS.model m

		UPDATE 
			m 
		SET 
			m.for_comparison = 1
		FROM 
			GRLS.model m
			INNER JOIN @models t 
			ON m.sobriquet = t.sobriquet COLLATE DATABASE_DEFAULT

		SELECT @cols = STUFF(
			(
				SELECT DISTINCT 
					',' + QUOTENAME(m.sobriquet) 
				FROM 
					@models m
				FOR XML PATH(''), TYPE
			).value('.', 'NVARCHAR(MAX)'), 1, 1, '')

		SET @query = '
			SELECT 
				abbrev, ~cols 
			FROM 
				(
					SELECT
						m.sobriquet,
						l1.abbrev,
						att.adj_preference
					FROM  						
						GRLS.dv_model_attribute_list att
						INNER JOIN GRLS.model m
						ON att.model_id = m.id
						INNER JOIN GRLS.attribute_level_1 l1
						ON att.l1_id = l1.l1_id
					WHERE
						m.for_comparison = 1 AND
						ab.scheme_abbrev = ^~scheme_id^
					
					UNION 

					SELECT  						
						m.sobriquet,
						^ZTOTAL^,
						SUM(att.adj_preference)
					FROM
						GRLS.dv_model_attribute_list att
						INNER JOIN GRLS.model m
						ON att.model_id = m.id
					WHERE
						m.for_comparison = 1 AND
						ab.scheme_abbrev = ^~scheme_id^
					GROUP BY 
						m.sobriquet
				) x
			PIVOT 
				(
					MIN(x.adj_preference)
					FOR sobriquet IN (~cols,[ZTOTAL])
			) p '

		SET @query = REPLACE(@query, '~cols', @cols)
		SET @query = REPLACE(@query, '~scheme_id', @scheme_id)
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
PRINT '########## GRLS.r_model_comparison created successfully ##########'

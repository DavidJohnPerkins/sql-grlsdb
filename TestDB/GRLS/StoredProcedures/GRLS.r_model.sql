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
		DECLARE @model_id	int = (SELECT JSON_VALUE(@p_input_json, '$."model_id"'))

		IF ISNULL(@model_id, '') = ''
   			RAISERROR ('The model_id attribute is not present - operation failed.', 16, 1)

		IF @p_debug = 1 
			PRINT @model_id

		IF @p_execute = 1
		BEGIN
			IF @model_id != -1
			BEGIN
				SELECT
					m.* 
				FROM 
					GRLS.v_model_extended m 
				WHERE 
					m.id = @model_id
			END
			ELSE
			BEGIN
				SELECT
					m.* 
				FROM 
					GRLS.v_model_extended m 
				ORDER BY
					m.principal_name
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

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_model_associate_list') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_model_associate_list
	PRINT '########## GRLS.r_model_associate_list dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_model_associate_list
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
	BEGIN TRY

		DECLARE @model_id int = (SELECT JSON_VALUE(@p_input_json, '$."model_id"'))

		IF ISNULL(@model_id, '') = ''
			RAISERROR ('The model_id attribute is not present - operation failed.', 16, 1)

		IF @p_execute = 1
			BEGIN
				SELECT
					m.id,
					m.sobriquet,
					mn.model_name AS principal_name
				FROM 
					GRLS.model_associate ma
					INNER JOIN GRLS.model m 
						INNER JOIN GRLS.model_name mn 
						ON m.id = mn.model_id AND mn.is_principal_name = 1
					ON ma.associated_model_id = m.id
				WHERE
					ma.model_id = @model_id
				ORDER BY
					m.sobriquet
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
GO
PRINT '########## GRLS.r_model_associate_list created successfully ##########'

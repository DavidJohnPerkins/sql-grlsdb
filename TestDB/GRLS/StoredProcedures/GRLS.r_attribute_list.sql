USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_attribute_list') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_attribute_list
	PRINT '########## GRLS.r_attribute_list dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_attribute_list
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 
		DECLARE @abbrev	GRLS.l1_abbrev = (SELECT JSON_VALUE(@p_input_json, '$."abbrev"'))

		IF ISNULL(@abbrev, '') = ''
   			RAISERROR ('The abbrev attribute is not present - operation failed.', 16, 1)

		IF NOT EXISTS (SELECT 1 FROM GRLS.attribute_level_1 l1 WHERE l1.abbrev = @abbrev)
   			RAISERROR ('Level 1 attribute %s not found - operation failed.', 16, 1, @abbrev)

		IF @p_debug = 1 
			PRINT @abbrev

		IF @p_execute = 1
		BEGIN
			SELECT
				l2.l2_desc
			FROM
				GRLS.attribute_level_2 l2 
				INNER JOIN GRLS.attribute_level_1 l1 
				ON l2.l1_id = l1.l1_id 
			WHERE
				l1.abbrev = @abbrev
			ORDER BY 
				l2.l2_desc
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
PRINT '########## GRLS.r_attribute_list created successfully ##########'

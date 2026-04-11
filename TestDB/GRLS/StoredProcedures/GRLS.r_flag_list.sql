USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.r_flag_list') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE GRLS.r_flag_list
	PRINT '########## GRLS.r_flag_list dropped successfully ##########'
END
GO

CREATE PROCEDURE GRLS.r_flag_list
	@p_input_json		COMMON.json,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRY 

		DECLARE @flag_type	char(3)	= (SELECT JSON_VALUE(@p_input_json, '$."flag_type"'))

		IF ISNULL(@flag_type, '') = ''
			RAISERROR ('The flag_type attribute is not present - operation failed.', 16, 1)

		IF @p_execute = 1
		BEGIN
			SELECT
				f.flag_abbrev
			FROM
				GRLS.flag f
				INNER JOIN GRLS.flag_type t 
				ON f.flag_type = t.id
			WHERE
				t.flag_type_abbrev = @flag_type
			ORDER BY 
				f.flag_abbrev
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
PRINT '########## GRLS.r_flag_list created successfully ##########'

USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_attribute_scheme') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_attribute_scheme
	PRINT '########## COMMON.c_attribute_scheme dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_attribute_scheme
	@p_scheme_attribs		COMMON.scheme_attrib_add_list READONLY,
	@p_prefs				COMMON.scheme_preference_add_list READONLY,
	@p_debug			bit = 0,
	@p_execute			bit = 1

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @scheme_id	int,
			@scheme_desc	varchar(20) = (SELECT sa.scheme_desc FROM @p_scheme_attribs sa),
			@active			bit 		= (SELECT sa.active FROM @p_scheme_attribs sa),
			@scheme_abbrev	varchar(50) = (SELECT sa.scheme_abbrev FROM @p_scheme_attribs sa)

	BEGIN TRY

		IF @scheme_abbrev IS NULL
   			RAISERROR ('The scheme_abbrev value is not found - operation failed.', 16, 1)

		IF @scheme_desc IS NULL
   			RAISERROR ('The scheme_desc value is not found - operation failed.', 16, 1)

		IF @active IS NULL
   			RAISERROR ('The active value is not found - operation failed.', 16, 1)

		IF 	EXISTS (SELECT a.abbrev COLLATE DATABASE_DEFAULT FROM @p_prefs a EXCEPT SELECT b.abbrev FROM GRLS.attribute_level_1 b) OR
			EXISTS (SELECT a.abbrev FROM GRLS.attribute_level_1 a EXCEPT SELECT b.abbrev COLLATE DATABASE_DEFAULT FROM @p_prefs b)
				RAISERROR ('There are missing or invalid attributes - operation failed.', 16, 1)

		BEGIN TRANSACTION

		INSERT INTO GRLS.attribute_scheme (scheme_desc, active, scheme_abbrev) VALUES (
			@scheme_desc,
			@active,
			@scheme_abbrev)

			SET @scheme_id = @@IDENTITY

		INSERT INTO GRLS.attribute_level_1_detail (l1_id, scheme_id, attr_weight)
		SELECT DISTINCT
			l1.l1_id ,
			@scheme_id ,
			p.attr_weight
		FROM
			@p_prefs p
			INNER JOIN GRLS.attribute_level_1 l1 
			ON p.abbrev = l1.abbrev COLLATE DATABASE_DEFAULT

		INSERT INTO GRLS.attribute_level_2_detail (l2_id, scheme_id, l2_preference)
		SELECT
			av.l2_id,
			@scheme_id,
			p.preference
		FROM
			@p_prefs p
			CROSS APPLY GRLS.attribute_values(p.abbrev, p.l2_desc) av

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Transaction rolled back - no changes made'
		END

	END TRY

	BEGIN CATCH  
		DECLARE @error_message varchar(4000)
		DECLARE @error_severity int  
		DECLARE @error_state int
	
		IF @@TRANCOUNT != 0
			ROLLBACK TRANSACTION

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
PRINT '########## COMMON.c_attribute_scheme created successfully ##########'

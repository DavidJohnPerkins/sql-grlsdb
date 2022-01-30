USE TestDB
GO

DECLARE @new_scheme_id		int,
		@src_scheme_id		int,
		@new_scheme_desc	varchar(50) = 'Fav. Late Adolescence Levelling Minor Attributes',
		@src_scheme_desc	varchar(50) = 'Favouring Late Adolescence'

BEGIN TRY

	IF EXISTS (SELECT 1 FROM GRLS.attribute_scheme s WHERE s.scheme_desc = @src_scheme_desc)
	BEGIN
		SET @src_scheme_id = (SELECT s.scheme_id FROM GRLS.attribute_scheme s WHERE s.scheme_desc = @src_scheme_desc)
	END
	ELSE
	BEGIN
		RAISERROR('Source scheme ''%s'' does not exist', 16, 1, @src_scheme_desc)
	END

	IF NOT EXISTS (SELECT 1 FROM GRLS.attribute_scheme s WHERE s.scheme_desc = @new_scheme_desc)
	BEGIN

		BEGIN TRANSACTION

		INSERT INTO GRLS.attribute_scheme (scheme_desc, active)
		VALUES (@new_scheme_desc, 0)
		SET @new_scheme_id = @@IDENTITY

		INSERT INTO GRLS.attribute_level_1_detail (
			l1_id,
			scheme_id,
			attr_weight
		)
		SELECT 
			l1d.l1_id,
			@new_scheme_id,
			l1d.attr_weight
		FROM
			GRLS.attribute_level_1_detail l1d
		WHERE 
			l1d.scheme_id = @src_scheme_id

		INSERT INTO GRLS.attribute_level_2_detail (
			l2_id,
			scheme_id,
			l2_preference
		)
		SELECT 
			l2d.l2_id,
			@new_scheme_id,
			l2d.l2_preference
		FROM
			GRLS.attribute_level_2_detail l2d
		WHERE 
			l2d.scheme_id = @src_scheme_id

		COMMIT TRANSACTION

	END
	ELSE
	BEGIN
		RAISERROR('Target scheme ''%s'' already exists', 16, 1, @new_scheme_desc)
	END

END TRY
BEGIN CATCH
   SELECT  
		ERROR_NUMBER() AS ErrorNumber , 
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure,  
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage

	IF @@TRANCOUNT != 0
		ROLLBACK TRANSACTION

END CATCH

GO

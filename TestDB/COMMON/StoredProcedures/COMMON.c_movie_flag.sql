USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.c_movie_flag') AND [type] IN ('P', 'PC'))
BEGIN 
	DROP PROCEDURE COMMON.c_movie_flag
	PRINT '########## COMMON.c_movie_flag dropped successfully ##########'
END
GO

CREATE PROCEDURE COMMON.c_movie_flag
	@p_flags		COMMON.flag_add_list READONLY,
	@p_movie_id		int,
	@p_update_type	char(1),
	@p_debug		bit = 0,
	@p_execute		bit = 1

AS
BEGIN

	SET NOCOUNT ON
	
	IF @p_update_type NOT IN ('C', 'R')
   		RAISERROR ('Update type must be C or R - operation failed.', 16, 1)

	IF 	EXISTS (SELECT t.flag_abbrev FROM @p_flags t EXCEPT SELECT f.flag_abbrev FROM GRLS.fv_movie_flag f)
		RAISERROR ('There are invalid flags in the input data - operation failed.', 16, 1)

	BEGIN TRY

		BEGIN TRANSACTION

		IF @p_update_type = 'R'
			DELETE 
				mf 
			FROM 
				GRLS.movie_flag mf 
			WHERE 
				mf.movie_id = @p_movie_id

		INSERT INTO GRLS.movie_flag(movie_id, flag_id)
		SELECT
			@p_movie_id,
			f.flag_id 
		FROM
			@p_flags fl 
			LEFT OUTER JOIN GRLS.fv_movie_flag f 
			ON fl.flag_abbrev = f.flag_abbrev
			LEFT OUTER JOIN GRLS.movie_flag mf 
			ON @p_movie_id = mf.movie_id AND f.flag_id = mf.flag_id
		WHERE 
			mf.id IS NULL

		IF @p_debug = 1
			PRINT 'FLAG INSERTIONS COMPLETE'

		IF @p_execute = 1
		BEGIN
			COMMIT TRANSACTION
			PRINT 'FLAG COMMIT COMPLETE'
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Flag insert transaction rolled back - no changes made'
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
PRINT '########## COMMON.c_movie_flag created successfully ##########'

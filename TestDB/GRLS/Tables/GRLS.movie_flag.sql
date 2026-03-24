USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.movie_flag', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_movieflag_movieid_flagid ON GRLS.movie_flag

	ALTER TABLE GRLS.movie_flag
	DROP CONSTRAINT FK_movieflag_movieid_model

	ALTER TABLE GRLS.movie_flag
	DROP CONSTRAINT FK_movieflag_flagid_flag

	DROP TABLE GRLS.movie_flag

END
GO
CREATE TABLE GRLS.movie_flag
(
	id				int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	movie_id		int	NOT NULL,
	flag_id			int	NOT NULL
)
GO

CREATE UNIQUE INDEX U_IDX_movieflag_movieid_flagid ON GRLS.movie_flag (movie_id, flag_id) ON [PRIMARY];
GO

ALTER TABLE GRLS.movie_flag ADD CONSTRAINT FK_movieflag_movieid_model FOREIGN KEY (movie_id) REFERENCES GRLS.movie(id) ON DELETE CASCADE;
ALTER TABLE GRLS.movie_flag ADD CONSTRAINT FK_movieflag_flagid_flag FOREIGN KEY (flag_id) REFERENCES GRLS.flag(flag_id) ON DELETE CASCADE;
GO

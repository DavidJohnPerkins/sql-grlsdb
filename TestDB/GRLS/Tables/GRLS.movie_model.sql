USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.movie_model', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_movieid_modelid ON GRLS.movie_model

	ALTER TABLE GRLS.movie_model
	DROP CONSTRAINT FK_movie_model_movie

	ALTER TABLE GRLS.movie_model
	DROP CONSTRAINT FK_movie_model_model

	DROP TABLE GRLS.movie_model
	PRINT '########## Table GRLS.movie_model dropped successfully ##########'
END
GO

CREATE TABLE GRLS.movie_model(
	id			int IDENTITY(1, 1) NOT NULL,
	movie_id 	int NOT NULL,
	model_id	int NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE GRLS.movie_model ADD PRIMARY KEY NONCLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_movieid_modelid ON GRLS.movie_model (movie_id, model_id) ON [PRIMARY];
GO
ALTER TABLE GRLS.movie_model ADD CONSTRAINT FK_movie_model_movie FOREIGN KEY (movie_id) REFERENCES GRLS.movie(id) ON DELETE CASCADE;
GO
ALTER TABLE GRLS.movie_model ADD CONSTRAINT FK_movie_model_model FOREIGN KEY (model_id) REFERENCES GRLS.model(id) ON DELETE CASCADE;
GO

PRINT '########## Table GRLS.movie_model modified successfully ##########'

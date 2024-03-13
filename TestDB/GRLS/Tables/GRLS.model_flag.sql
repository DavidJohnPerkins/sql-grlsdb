USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.model_flag', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_modelflag_modelid_flagid ON GRLS.model_flag

	ALTER TABLE GRLS.model_flag
	DROP CONSTRAINT FK_modelflag_modelid_model

	ALTER TABLE GRLS.model_flag
	DROP CONSTRAINT FK_modelflag_flagid_flag

	DROP TABLE GRLS.model_flag

END
GO
CREATE TABLE GRLS.model_flag
(
	id				int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	model_id		int	NOT NULL,
	flag_id			int	NOT NULL
)
GO

CREATE UNIQUE INDEX U_IDX_modelflag_modelid_flagid ON GRLS.model_flag (model_id, flag_id) ON [PRIMARY];
GO

ALTER TABLE GRLS.model_flag ADD CONSTRAINT FK_modelflag_modelid_model FOREIGN KEY (model_id) REFERENCES GRLS.model(id) ON DELETE CASCADE;
ALTER TABLE GRLS.model_flag ADD CONSTRAINT FK_modelflag_flagid_flag FOREIGN KEY (flag_id) REFERENCES GRLS.flag(flag_id) ON DELETE CASCADE;
GO

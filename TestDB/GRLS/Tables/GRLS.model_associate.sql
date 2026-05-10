USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.model_associate', 'U') IS NOT NULL
BEGIN
	DROP TABLE GRLS.model_associate
END
GO
CREATE TABLE GRLS.model_associate
(
	id					int IDENTITY(1, 1)	NOT NULL ,
	model_id			int					NOT NULL ,
	associated_model_id	int					NOT NULL
)
GO
ALTER TABLE GRLS.model_associate ADD PRIMARY KEY NONCLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_modelid_attrid ON GRLS.model_associate (model_id, associated_model_id) ON [PRIMARY];
GO
ALTER TABLE GRLS.model_associate ADD CONSTRAINT fk_model_associate_model FOREIGN KEY (model_id) REFERENCES GRLS.model(id)
ALTER TABLE GRLS.model_associate ADD CONSTRAINT fk_model_associate_associated_model FOREIGN KEY (associated_model_id) REFERENCES GRLS.model(id)

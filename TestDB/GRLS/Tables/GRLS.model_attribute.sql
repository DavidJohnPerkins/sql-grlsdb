USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('GRLS.model_attribute', 'U') IS NOT NULL
BEGIN
	DROP INDEX IF EXISTS U_IDX_modelid_attrid ON GRLS.model_attribute

	ALTER TABLE GRLS.model_attribute
	DROP CONSTRAINT FK_model_attr_attr_l2

	DROP TABLE GRLS.model_attribute

END
GO
CREATE TABLE GRLS.model_attribute
(
	id				int IDENTITY(1, 1)	NOT NULL ,
	model_id		int					NOT NULL ,
	attribute_id	int					NOT NULL
)
GO
ALTER TABLE GRLS.model_attribute ADD PRIMARY KEY NONCLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX U_IDX_modelid_attrid ON GRLS.model_attribute (model_id, attribute_id) ON [PRIMARY];
GO
ALTER TABLE GRLS.model_attribute ADD CONSTRAINT FK_model_attr_attr_l2 FOREIGN KEY (attribute_id) REFERENCES GRLS.attribute_level_2(l2_id)
	ON DELETE CASCADE;
GO
ALTER TABLE GRLS.model_attribute ADD CONSTRAINT FK_model_attr_model_id FOREIGN KEY (model_id) REFERENCES GRLS.model(id)
	ON DELETE CASCADE;
GO

ALTER TABLE GRLS.model_attribute ADD
	standout_factor float NOT NULL DEFAULT 1.0,
	valid_from	datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
	valid_to	datetime

DROP INDEX IF EXISTS U_IDX_modelid_attrid ON GRLS.model_attribute
GO
CREATE CLUSTERED INDEX U_IDX_modelid_attrid ON GRLS.model_attribute (model_id, attribute_id) ON [PRIMARY];
GO

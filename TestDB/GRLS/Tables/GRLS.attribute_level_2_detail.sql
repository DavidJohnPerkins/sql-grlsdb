USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF OBJECT_ID('GRLS.attribute_level_2_detail', 'U') IS NOT NULL
DROP TABLE GRLS.attribute_level_2_detail
GO

CREATE TABLE GRLS.attribute_level_2_detail
(
	l2_det_id		int IDENTITY(1, 1)	NOT NULL ,
	l2_id			int					NOT NULL ,
	scheme_id		int					NOT NULL ,
	l2_preference	int					NOT NULL
)
GO

ALTER TABLE GRLS.attribute_level_2_detail ADD PRIMARY KEY CLUSTERED 
(
	l2_det_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE GRLS.attribute_level_2_detail
	ADD CONSTRAINT FK_attr_level_2_det_attr_level_2 FOREIGN KEY (l2_id) REFERENCES GRLS.attribute_level_2(l2_id)
		ON DELETE CASCADE;
GO

ALTER TABLE GRLS.attribute_level_2_detail
	ADD CONSTRAINT FK_attr_level_2_det_attr_scheme FOREIGN KEY (scheme_id) REFERENCES GRLS.attribute_scheme(scheme_id)
		ON DELETE NO ACTION

INSERT INTO GRLS.attribute_level_2_detail (
	l2_id,
	scheme_id,
	l2_preference
)
SELECT 
	l2.l2_id,
	l2.scheme_id,
	l2.l2_preference
FROM 
	GRLS.attribute_level_2 l2


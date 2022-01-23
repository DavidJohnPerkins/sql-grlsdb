USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF OBJECT_ID('GRLS.attribute_level_1_detail', 'U') IS NOT NULL
DROP TABLE GRLS.attribute_level_1_detail
GO

CREATE TABLE GRLS.attribute_level_1_detail
(
	l1_det_id	int IDENTITY(1, 1)	NOT NULL ,
	l1_id		int					NOT NULL ,
	scheme_id	int					NOT NULL ,
	attr_weight	int					NOT NULL
)
GO

ALTER TABLE GRLS.attribute_level_1_detail ADD PRIMARY KEY CLUSTERED 
(
	l1_det_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE GRLS.attribute_level_1_detail
	ADD CONSTRAINT FK_attr_level_1_det_attr_level_1 FOREIGN KEY (l1_id) REFERENCES GRLS.attribute_level_1(l1_id)
		ON DELETE CASCADE;
GO

ALTER TABLE GRLS.attribute_level_1_detail
	ADD CONSTRAINT FK_attr_level_1_det_attr_scheme FOREIGN KEY (scheme_id) REFERENCES GRLS.attribute_scheme(scheme_id)
		ON DELETE NO ACTION
		
INSERT INTO GRLS.attribute_level_1_detail (
	l1_id,
	scheme_id,
	attr_weight
)
SELECT 
	l1.l1_id,
	l1.scheme_id,
	l1.attr_weight
FROM 
	GRLS.attribute_level_1 l1
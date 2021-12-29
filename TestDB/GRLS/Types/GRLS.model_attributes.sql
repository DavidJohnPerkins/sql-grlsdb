USE [TestDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TYPE IF EXISTS GRLS.model_attributes
GO

CREATE TYPE GRLS.model_attributes AS TABLE   
(
	sobriquet			varchar(50) ,
	eye_colour			varchar(50) ,
	hair_colour			varchar(50) ,
	nationality			varchar(50) ,
	breast_size			varchar(50) ,
	breast_shape		varchar(50) ,
	build				varchar(50) ,
	attractiveness		varchar(50) ,
	youthfulness		varchar(50) ,
	complexion			varchar(50) ,
	pubic_mound_shape	varchar(50) ,
	bum_shape			varchar(50) ,
	bum_size			varchar(50) ,
	ethnicity			varchar(50)
)
GO  
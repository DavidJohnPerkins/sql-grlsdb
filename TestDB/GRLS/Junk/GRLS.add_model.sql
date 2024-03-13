USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS GRLS.add_model
GO

CREATE PROCEDURE GRLS.add_model (
	@model_attribs	GRLS.kv_pair READONLY ,
	@model_names	GRLS.generic_list_vc_int READONLY
)
AS
BEGIN 

	DECLARE @model_id int

	BEGIN TRY

		BEGIN TRANSACTION
		
			INSERT INTO GRLS.model (sobriquet, hotness_quotient)
			SELECT
				a.data_value ,
				CONVERT(int, b.data_value)
			FROM 
				@model_attribs a ,
				@model_attribs b
			WHERE
				a.key_value = 'SOBR' AND
				b.key_value = 'HQUO'

			SET @model_id = @@IDENTITY

			INSERT INTO GRLS.model_attribute (model_id, attribute_id)
			SELECT
				@model_id ,
				av.l2_id
			FROM
				@model_attribs a
				CROSS APPLY GRLS.attribute_values(a.key_value, a.data_value) av

			INSERT INTO GRLS.model_name
			SELECT
				@model_id ,
				n.data_value_vc ,
				n.data_value_int
			FROM 
				@model_names n
				
			COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO
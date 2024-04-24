USE TestDB;  
GO  

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('COMMON.get_binary_sequence', 'IF') IS NOT NULL  
	DROP FUNCTION COMMON.get_binary_sequence
	PRINT '########## COMMON.get_binary_sequence dropped successfully ##########'
GO  

CREATE FUNCTION COMMON.get_binary_sequence(@seq_end int)
RETURNS TABLE AS 
RETURN (
	WITH w_seq_end AS (
		SELECT
			POWER(2, @seq_end - 1) AS e
	),
	w_level_1 AS (
		SELECT
			value AS v1,
			LOG(value, 2) AS v2
		FROM 
			GENERATE_SERIES(1, (SELECT se.e FROM w_seq_end se))
	)
	SELECT
		w1.v1 AS bin_val,
		w1.v2 + 1 AS ord_val
	FROM 
		w_level_1 w1
	WHERE  
		w1.v2 - CONVERT(int, w1.v2) = 0
)
GO
PRINT '########## COMMON.get_binary_sequence created successfully ##########'

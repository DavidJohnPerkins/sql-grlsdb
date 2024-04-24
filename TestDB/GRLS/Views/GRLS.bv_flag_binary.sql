USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'GRLS.bv_flag_binary') AND [type] IN ('V'))
BEGIN 
	DROP VIEW GRLS.bv_flag_binary
	PRINT '########## GRLS.bv_flag_binary dropped successfully ##########'
END
GO

CREATE VIEW GRLS.bv_flag_binary AS

	WITH w_level_1 AS (
		SELECT 
			ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rn,
			f.flag_abbrev
		FROM 
			GRLS.flag f
	)
	SELECT 
		w1.*,
		seq.bin_val
	FROM
		w_level_1 w1
		CROSS APPLY COMMON.get_binary_sequence((SELECT COUNT(1) FROM GRLS.flag)) seq
	WHERE 
		w1.rn = seq.ord_val

GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view returning model flag and ascending binary column header.',
    @level0type = 'SCHEMA', @level0name = N'GRLS',
    @level1type = 'VIEW', @level1name = N'bv_flag_binary';
GO

PRINT '########## GRLS.bv_flag_binary created successfully ##########'

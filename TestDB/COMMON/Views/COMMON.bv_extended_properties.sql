USE TestDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'COMMON.bv_extended_properties') AND [type] IN ('V'))
BEGIN 
	DROP VIEW COMMON.bv_extended_properties
	PRINT '########## COMMON.bv_extended_properties dropped successfully ##########'
END
GO

CREATE VIEW COMMON.bv_extended_properties AS

	WITH w_props (obj_type, ep_value, obj_id, par_obj_id, obj_name, maxlen) AS (
		SELECT 
			obj.type_desc,
			ep.[value],
			obj.object_id,
			obj.parent_object_id,
			obj.name,
			0
		FROM 
			sys.objects obj
			LEFT OUTER JOIN sys.extended_properties ep 
			ON obj.object_id = ep.major_id AND ep.class = 1 AND ep.minor_id = 0 AND ep.name IN ('Caption', 'MS_Description')
		WHERE 
			obj.is_ms_shipped = 0

		UNION ALL  

		SELECT  
			t.name,
			epc.[value],
			0,
			col.object_id,
			col.name,
			col.max_length
		FROM
			sys.columns col 
			INNER JOIN sys.types t 
			ON col.user_type_id = t.user_type_id
			LEFT OUTER JOIN sys.extended_properties epc 
			ON col.object_id = epc.major_id AND epc.class = 1 AND col.column_id = epc.minor_id AND epc.name = 'MS_Description'
		WHERE 
			OBJECTPROPERTYEX(col.object_id, 'IsMSShipped') = 0
	)
	SELECT 
		CASE WHEN par_obj_id > 0 THEN 
			OBJECT_SCHEMA_NAME(par_obj_id) + '.' + OBJECT_NAME(par_obj_id) + '.' + obj_name
		ELSE 
			OBJECT_SCHEMA_NAME(obj_id) + '.' + obj_name 
		END 									AS object_name,
		CASE WHEN objcol.obj_type LIKE '%char' COLLATE DATABASE_DEFAULT THEN 
			objcol.obj_type + COMMON.paren(objcol.maxlen)
		ELSE 
			objcol.obj_type 
		END	COLLATE DATABASE_DEFAULT	AS object_type,
		COALESCE(ep_value, '')			AS property_value
	FROM
		w_props objcol
	WHERE 
		objcol.obj_type NOT LIKE '%CONSTRAINT' COLLATE DATABASE_DEFAULT

GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Base view showing extended properties for all database objects.',
    @level0type = 'SCHEMA', @level0name = N'COMMON',
    @level1type = 'VIEW', @level1name = N'bv_extended_properties';
GO

PRINT '########## COMMON.bv_extended_properties created successfully ##########'

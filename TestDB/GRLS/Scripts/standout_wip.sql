--1select * from GRLS.model_attribute where model_id in (14,78) -- order by sobriquet
--select * from GRLS.v_analysis_pivot where scheme_id=1 order by adjusted_total desc -- where model_id in (14, 78)
--select * from GRLS.model order by sobriquet

--update GRLS.model_attribute set standout_factor=1.25 where id=447

/*
select distinct 
	sobriquet,
	adj_total
from 
	GRLS.v_attribute_group_analysis 
where 
	l1_group_abbrev='WAISTUP' AND
	scheme_id=1
order by 
	adj_total desc
*/

select * from GRLS.v_basic_analysis where abbrev='BSIZ' and l2_desc='Large' order by sobriquet, scheme_id
--select * from GRLS.model_attribute where model_id=23

select * from GRLS.v_scheme_preference_detail order by 1,2

select * from GRLS.attribute_scheme

--update COMMON.environment set env_value = 'FALSE' where env_var = 'USE_STANDOUT'
--select * from GRLS.v_analysis_pivot where /*principal_name IN ('Kara', 'Veselin') and*/ scheme_abbrev='SIMPLE' --order by adjusted_total desc

--select top 10 * from GRLS.v_attribute where scheme_abbrev='NOPREF'
--select * from GRLS.v_model_extended order by sobriquet
--DELETE from GRLS.attribute_scheme WHERE scheme_abbrev='SIMPLE'
--DELETE from GRLS.model WHERE sobriquet='NENSI_B'
--select * from GRLS.v_analysis_base where sobriquet IN ('KARA', 'VESELIN') and scheme_abbrev='SIMPLE' order by abbrev, sobriquet
--select * from GRLS.v_basic_analysis where sobriquet IN ('BAILEY_BAE', 'VESELIN') and scheme_abbrev='SIMPLE'

/*
DECLARE @json COMMON.json = '[
	{"sobriquet": "VESELIN"},
	{"sobriquet": "NIMFA"},
	{"sobriquet": "ALTEA"}
]'
EXECUTE GRLS.r_model_comparison @json, 1, 1

select 	* from GRLS.v_analysis_pivot WHERE scheme_abbrev='SIMPLE' and BRSH LIKE 'Nubs%'
*/

select * from GRLS.attribute_level_1_group_detail where l1_group_id=20
select GRLS.l1_abbrevs_as_string('ALL')

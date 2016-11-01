--select * from [DEV_CDM_OPTUM_V5].dbo.#junk

select top 100 
		cr1.concept_name atc5, cr1.concept_class_id,
		cr2.concept_name other, cr2.concept_class_id,
		cr.relationship_id, 
		destats.*,
		cr.*, rel.*
from [DEV_CDM_OPTUM_V5].dbo.#drug_exposure_stats destats
join [DEV_CDM_OPTUM_V5].dbo.concept_relationship cr on destats.drug_concept_id = cr.concept_id_2
join [DEV_CDM_OPTUM_V5].dbo.concept cr1 on cr.concept_id_1 = cr1.concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept cr2 on cr.concept_id_2 = cr2.concept_id
join [DEV_CDM_OPTUM_V5].dbo.relationship rel on cr.relationship_id = rel.relationship_id
where cr.concept_id_1 in (select concept_id from [DEV_CDM_OPTUM_V5].dbo.concept where concept_class_id like 'ATC 3%')

/*

select top 1000 * from [DEV_CDM_OPTUM_V5].dbo.#drug_exposure_stats

create table [DEV_CDM_OPTUM_V5].dbo.#drug_exposure_stats
with (location = user_db, distribution = replicate)
as (
	select	de.drug_concept_id
			,cde.concept_name drug_name
			,cde.concept_class_id drug_concept_class
			,cdt.concept_name drug_type_name
			,count(*) exposures
			,count(distinct person_id) patients
			,sum(cast(refills as bigint)) refills
			,sum(cast(quantity as bigint)) quantity
			,sum(cast(days_supply as bigint)) days_supply
			,count(distinct cast(person_id as varchar) + cast(provider_id as varchar)) pt_provider_count
	from [DEV_CDM_OPTUM_V5].dbo.drug_exposure de
	join [DEV_CDM_OPTUM_V5].dbo.concept cde on de.drug_concept_id = cde.concept_id and cde.invalid_reason is null
	join [DEV_CDM_OPTUM_V5].dbo.concept cdt on de.drug_type_concept_id = cdt.concept_id
	group by drug_concept_id
			 ,cde.concept_name
			 ,cde.concept_class_id
			 ,cdt.concept_name
)


--join [DEV_CDM_OPTUM_V5].dbo.concept_relationship cr1 on ec.drug_concept_id = cr1.concept_id_1 and cr1.relationship_id = 'RxNorm - ATC'
--join [DEV_CDM_OPTUM_V5].dbo.concept ccr1 on cr1.concept_id_2 = ccr1.concept_id and ccr1.invalid_reason is null




select top 1000 * from [DEV_CDM_OPTUM_V5].dbo.concept

select top 1000 * from [DEV_CDM_OPTUM_V5].dbo.drug_exposure de

select
		ecc.concept_name as drug_name, ec.*,
		cing.concept_name ingredient, 
		cing.concept_id ingredient_concept_id
		--,ccr1.concept_name atc5, ccr1.concept_class_id
from (select drug_concept_id, count(*) exposures
		from [DEV_CDM_OPTUM_V5].dbo.drug_exposure
		group by drug_concept_id
	) ec -- exposure counts
join [DEV_CDM_OPTUM_V5].dbo.concept ecc on ec.drug_concept_id = ecc.concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept_ancestor ca on ec.drug_concept_id = ca.descendant_concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept cing on ca.ancestor_concept_id = cing.concept_id
											  and cing.concept_class_id = 'Ingredient'
											  and cing.standard_concept = 'S'
											  and cing.invalid_reason is null

select top 100 
		cr1.concept_name atc5, cr1.concept_class_id,
		cr2.concept_name other, cr2.concept_class_id,
		cr.relationship_id, cr.*, rel.*
from [DEV_CDM_OPTUM_V5].dbo.concept_relationship cr
join [DEV_CDM_OPTUM_V5].dbo.concept cr1 on cr.concept_id_1 = cr1.concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept cr2 on cr.concept_id_2 = cr2.concept_id
join [DEV_CDM_OPTUM_V5].dbo.relationship rel on cr.relationship_id = rel.relationship_id
where cr.concept_id_1 in
	(select concept_id from [DEV_CDM_OPTUM_V5].dbo.concept where concept_class_id like 'ATC 3%')

select * from [DEV_CDM_OPTUM_V5].dbo.relationship

select	top 1000
		ca.min_levels_of_separation,
		cing.concept_name ingredient, cdex.concept_name drug_name,
		ctype.concept_name drug_type,
		dex.drug_exposure_start_date,
		dex.stop_reason,
		dex.refills,
		dex.quantity,
		dex.days_supply
from [DEV_CDM_OPTUM_V5].dbo.drug_exposure dex
join [DEV_CDM_OPTUM_V5].dbo.concept cdex on dex.drug_concept_id = cdex.concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept ctype on dex.drug_type_concept_id = ctype.concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept_ancestor ca on dex.drug_concept_id = ca.descendant_concept_id
														and ca.ancestor_concept_id is not null
join [DEV_CDM_OPTUM_V5].dbo.concept cing on ca.ancestor_concept_id = cing.concept_id
											  and cing.concept_class_id = 'Ingredient'
											  and cing.standard_concept = 'S'
											  and cing.invalid_reason is null
											  and ca.ancestor_concept_id is not null
--where dex.person_id = 33021531818

--select top 100 * from [DEV_CDM_OPTUM_V5].dbo.concept where concept_id = 38000175




select concept_class_id, count(*)
from [DEV_CDM_OPTUM_V5].dbo.concept
group by concept_class_id
order by 2 desc

select drug_concept_id, count(*) exposures
from [DEV_CDM_OPTUM_V5].dbo.drug_exposure
group by drug_concept_id
order by 2 desc

select top 1000 *
from [DEV_CDM_OPTUM_V5].dbo.drug_exposure
where drug_concept_id = 0


select * from [DEV_CDM_OPTUM_V5].INFORMATION_SCHEMA.tables
ORDER BY 3


select *
from [DEV_CDM_OPTUM_V5].dbo.dose_era dos
where dos.person_id = 33021531818



QUERY TRYING TO CONNECT DRUG EXPOSURES TO THEIR DRUG ERAS THROUGH ANCESTOR RELATIONSHIP AND DATES
select	ca.min_levels_of_separation,
		cera.concept_name, cera.concept_class_id, cdex.concept_name, cdex.concept_class_id,
		era.drug_era_start_date, era.drug_era_end_date,
		dex.drug_exposure_start_date,
		dex.*, era.*
from [DEV_CDM_OPTUM_V5].dbo.concept_ancestor ca
join [DEV_CDM_OPTUM_V5].dbo.drug_exposure dex on ca.descendant_concept_id = dex.drug_concept_id
join [DEV_CDM_OPTUM_V5].dbo.concept cdex on cdex.concept_id = dex.drug_concept_id
left join [DEV_CDM_OPTUM_V5].dbo.drug_era era 
		on ca.ancestor_concept_id = era.drug_concept_id 
		and dex.drug_exposure_start_date >= era.drug_era_start_date
		and cast(dex.drug_exposure_start_date as datetime) + dex.days_supply <= era.drug_era_end_date
left join [DEV_CDM_OPTUM_V5].dbo.concept cera on cera.concept_id = era.drug_concept_id
where dex.person_id = 33021531818
and	  era.person_id = 33021531818
order by 2,4,8
*/
  
/*

select top 100 *
from [DEV_CDM_OPTUM_V5].dbo.observation_period


select distinct period_type_concept_id from [DEV_CDM_OPTUM_V5].dbo.observation_period

select	
		cdex.concept_name, cdex.concept_class_id,
		cds.concept_name, cds.concept_class_id,
		ds.*, dex.*
from [DEV_CDM_OPTUM_V5].dbo.drug_exposure dex
left join [DEV_CDM_OPTUM_V5].dbo.drug_strength ds on dex.drug_concept_id = ds.drug_concept_id
left join [DEV_CDM_OPTUM_V5].dbo.concept cds on cds.concept_id = cds.drug_concept_id
where dex.person_id = 33021531818


select de.*, c.*
from [DEV_CDM_OPTUM_V5].dbo.drug_exposure de
join [DEV_CDM_OPTUM_V5].dbo.concept c on c.concept_id = de.drug_concept_id
where person_id = 33021531818  

select de.*, c.*
from [DEV_CDM_OPTUM_V5].dbo.drug_era de
join [DEV_CDM_OPTUM_V5].dbo.concept c on c.concept_id = de.drug_concept_id
where person_id = 33021531818  
*/
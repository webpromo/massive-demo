select
incidents.id,
state,
injuries.name as injury,
affectedAreas.name as "affectedArea",
causes.name as cause from incidents
join injuries on incidents.injuryId = injuries.id
join affectedAreas on injuries.affectedareaid = affectedAreas.id
join causes on incidents.causeId = causes.id
where state = $1

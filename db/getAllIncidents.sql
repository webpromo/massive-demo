select
  incidents.id,
  state,
  injuries.name as injury,
  affectedAreas.name as affectedarea,
  causes.name as cause
from incidents
join injuries on incidents.injuryid = injuries.id
join affectedAreas on injuries.affectedAreaId = affectedAreas.id
join causes on incidents.causeId = causes.id

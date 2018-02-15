select 
  incidents.id,
  state,
  injuries.name as injury,
  affectedareas.name as affectedarea,
  causes.name as cause
from incidents
join injuries on incidents.injuryid = injuries.id
join affectedareas on injuries.affectedAreaId = affectedareas.id
join causes on incidents.causeId = causes.id
where state = $1

insert into incidents(state, injuryId, causeId)
values($1, $2, $3)
returning *

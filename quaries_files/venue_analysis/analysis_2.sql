-- Most successful team at each venue.

select
    dv.venue,
    dt.team_name,
    count(*) as wins
from fact_match fm
join dim_venue dv on fm.venue_id = dv.venue_id  
join dim_team dt on fm.winner_team_id = dt.team_id
where fm.winner_team_id is not null
group by dv.venue, dt.team_name
order by dv.venue, wins desc;
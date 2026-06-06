-- Chasing success percentage by venue.


select
    dv.venue,
    sum(case when fm.winner_runs = 0 and fm.winner_wickets > 0 then 1 else 0 end) as matches_won_by_chasing,
    count(*) as total_matches,
    round(sum(case when fm.winner_runs = 0 and fm.winner_wickets > 0 then 1 else 0 end) * 100.0 / count(*), 2) as chasing_success_percentage
from fact_match fm
join dim_venue dv on fm.venue_id = dv.venue_id
where fm.winner_runs is not null and fm.winner_wickets is not null  
group by dv.venue
order by chasing_success_percentage desc;
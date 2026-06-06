-- Average first innings score by venue.


select
    dv.venue,
    round(avg(first_innings.team_runs), 2) as avg_first_innings_score
from (
    select
        fm.match_number,
        fm.venue_id,
        sum(fb.score) as team_runs
    from fact_ball fb
    join fact_match fm on fb.match_no = fm.match_number
    where fb.inningno = 1
    group by fm.match_number, fm.venue_id
) as first_innings
join fact_match fm on first_innings.match_number = fm.match_number
join dim_venue dv on fm.venue_id = dv.venue_id
group by dv.venue
order by avg_first_innings_score desc;
-- Which venue has the highest average score?



select
    dv.venue,
    round(avg(team_runs), 2) as avg_first_innings_score 
from (
    select
        fm.match_number,
        fm.venue_id,
        case
            when fb.inningno = 1 then sum(fb.score)
        end as team_runs
    from fact_ball fb
    join fact_match fm on fb.match_no = fm.match_number
    where fb.inningno = 1
    group by fm.match_number, fm.venue_id, fb.inningno
) first_innings 
join dim_venue dv on first_innings.venue_id = dv.venue_id
group by dv.venue
order by avg_first_innings_score desc;
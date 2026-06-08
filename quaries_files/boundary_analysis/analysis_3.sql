-- Team with most boundaries.

select 
    dt.team_name as batting_team,
    count(*) as total_boundaries
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_team dt on (
    (fb.inningno = 1 and fm.team1_id = dt.team_id) or
    (fb.inningno = 2 and fm.team2_id = dt.team_id)
)
where fb.score in (4, 6)
group by dt.team_name
order by total_boundaries desc;
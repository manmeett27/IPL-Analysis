-- Which team has won the most matches?


select
    t.team_name,
    count(*) as wins
from fact_match fm
join dim_team t
    on fm.winner_team_id = t.team_id
group by t.team_name
order by wins desc

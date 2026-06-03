-- Which team has the highest win percentage?



select
    t.team_name,
    sum(case when fm.winner_team_id = t.team_id then 1 else 0 end) as wins,
    count(*) as matches_played,
    round(sum(case when fm.winner_team_id = t.team_id then 1 else 0 end) * 100.0 / count(*), 2) as win_percentage
from dim_team t
join fact_match fm
    on fm.team1_id = t.team_id
    or fm.team2_id = t.team_id
group by t.team_name
order by win_percentage desc;
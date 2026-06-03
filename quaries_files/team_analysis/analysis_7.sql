-- Does winning the toss increase winning chances?



select 
    t.team_name,
    sum(case when fm.toss_winner_team_id = t.team_id then 1 else 0 end) as toss_wins,
    sum(case when fm.winner_team_id = t.team_id then 1 else 0 end) as match_wins,
    round(sum(case when fm.winner_team_id = t.team_id then 1 else 0 end) * 100.0 / count(*), 2) as win_percentage
from dim_team t
join fact_match fm
    on fm.team1_id = t.team_id
    or fm.team2_id = t.team_id
group by t.team_name
order by win_percentage desc;
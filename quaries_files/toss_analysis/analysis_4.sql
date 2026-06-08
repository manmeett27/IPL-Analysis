-- Team-wise toss success rate.


select 
    dt.team_name as toss_winner,
    sum(case when fm.winner_team_id = fm.toss_winner_team_id then 1 else 0 end) as matches_won_after_toss,
    count(*) as total_toss_wins,
    round(sum(case when fm.winner_team_id = fm.toss_winner_team_id then 1 else 0 end) * 100.0 / count(*), 2) as toss_success_percentage
from fact_match fm  
join dim_team dt on fm.toss_winner_team_id = dt.team_id
where fm.toss_winner_team_id is not null
group by dt.team_name
order by toss_success_percentage desc;
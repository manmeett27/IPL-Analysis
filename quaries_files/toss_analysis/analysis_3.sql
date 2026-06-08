-- Does batting first or chasing give an advantage?



select
    dt.team_name as toss_winner,
    count(*) as total_toss_wins,
    sum(case when fm.toss_decision = 'bat' then 1 else 0 end) as toss_decision_bat_first,
    sum(case when fm.toss_decision = 'field' then 1 else 0 end) as toss_decision_field_first,
    sum(case when fm.toss_decision = 'bat' and fm.toss_winner_team_id = fm.winner_team_id then 1 else 0 end) as matches_won_batting_first,
    sum(case when fm.toss_decision = 'field' and fm.toss_winner_team_id = fm.winner_team_id then 1 else 0 end) as matches_won_chasing,
    case 
        when sum(case when fm.toss_decision = 'bat' then 1 else 0 end) = 0 then 0
        else round(sum(case when fm.toss_decision = 'bat' and fm.toss_winner_team_id = fm.winner_team_id then 1 else 0 end) * 100.0 / sum(case when fm.toss_decision = 'bat' then 1 else 0 end), 2)
    end as batting_first_success_percentage,
    case 
        when sum(case when fm.toss_decision = 'field' then 1 else 0 end) = 0 then 0
        else round(sum(case when fm.toss_decision = 'field' and fm.toss_winner_team_id = fm.winner_team_id then 1 else 0 end) * 100.0 / sum(case when fm.toss_decision = 'field' then 1 else 0 end), 2)
    end as chasing_success_percentage
from fact_match fm  
join dim_team dt on fm.toss_winner_team_id = dt.team_id
where fm.toss_winner_team_id is not null
group by dt.team_name
order by dt.team_name;
-- Team head-to-head records.

select
    t1.team_name as team,
    t2.team_name as opponent,
    sum(case when fm.winner_team_id = t1.team_id then 1 else 0 end) as team_wins,
    sum(case when fm.winner_team_id = t2.team_id then 1 else 0 end) as opponent_wins,
    count(*) as matches_played,
    round(sum(case when fm.winner_team_id = t1.team_id then 1 else 0 end) * 100.0 / nullif(count(*), 0), 2) as team_win_percentage
from (
    select
        match_number,
        case when team1_id < team2_id then team1_id else team2_id end as team_a,
        case when team1_id < team2_id then team2_id else team1_id end as team_b,
        winner_team_id
    from fact_match
) fm
join dim_team t1
    on fm.team_a = t1.team_id
join dim_team t2
    on fm.team_b = t2.team_id
group by t1.team_name, t2.team_name
order by team_win_percentage desc;
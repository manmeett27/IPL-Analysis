-- Which team performs best while chasing?
select
    t.team_name,
    sum(case when (
        fm.toss_decision = 'field' and fm.toss_winner_team_id = t.team_id
        or fm.toss_decision = 'bat' and (case when fm.toss_winner_team_id = fm.team1_id then fm.team2_id else fm.team1_id end) = t.team_id
    ) then 1 else 0 end) as matches_chasing,
    sum(case when (
        fm.toss_decision = 'field' and fm.toss_winner_team_id = t.team_id
        or fm.toss_decision = 'bat' and (case when fm.toss_winner_team_id = fm.team1_id then fm.team2_id else fm.team1_id end) = t.team_id
    ) and fm.winner_team_id = t.team_id then 1 else 0 end) as chase_wins,
    round(
        sum(case when (
            fm.toss_decision = 'field' and fm.toss_winner_team_id = t.team_id
            or fm.toss_decision = 'bat' and (case when fm.toss_winner_team_id = fm.team1_id then fm.team2_id else fm.team1_id end) = t.team_id
        ) and fm.winner_team_id = t.team_id then 1 else 0 end) * 100.0 /
        nullif(sum(case when (
            fm.toss_decision = 'field' and fm.toss_winner_team_id = t.team_id
            or fm.toss_decision = 'bat' and (case when fm.toss_winner_team_id = fm.team1_id then fm.team2_id else fm.team1_id end) = t.team_id
        ) then 1 else 0 end), 0),
        2
    ) as chase_win_percentage
from fact_match fm
join dim_team t
    on fm.team1_id = t.team_id
    or fm.team2_id = t.team_id
group by t.team_name
order by chase_win_percentage desc;
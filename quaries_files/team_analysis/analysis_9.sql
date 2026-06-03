-- Most successful team at home venues.

select
    t.team_name,
    sum(case when fm.team1_id = t.team_id then 1 else 0 end) as home_matches,
    sum(case when fm.team1_id = t.team_id and fm.winner_team_id = t.team_id then 1 else 0 end) as home_wins,
    round(
        sum(case when fm.team1_id = t.team_id and fm.winner_team_id = t.team_id then 1 else 0 end) * 100.0 /
        nullif(sum(case when fm.team1_id = t.team_id then 1 else 0 end), 0),
        2
    ) as home_win_percentage
from fact_match fm
join dim_team t
    on fm.team1_id = t.team_id
group by t.team_name
order by home_win_percentage desc;
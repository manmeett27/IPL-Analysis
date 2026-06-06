-- Closest matches.



select
    fm.match_number,
    t1.team_name as team1,
    t2.team_name as team2,
    case
        when fm.winner_runs > 0 then concat(fm.winner_runs, ' runs')
        else concat(fm.winner_wickets, ' wickets')
    end as winning_margin
from fact_match fm
join dim_team t1 on fm.team1_id = t1.team_id
join dim_team t2 on fm.team2_id = t2.team_id
order by least(fm.winner_runs, fm.winner_wickets) asc
limit 10;
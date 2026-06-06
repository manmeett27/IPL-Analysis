-- Largest winning margin (runs).



select
    max(team_runs) - min(team_runs) as largest_winning_margin_runs
from (
    select
        fm.match_number,
        case
            when fb.inningno = 1 then fm.team1_id
            else fm.team2_id
        end as batting_team_id,
        sum(fb.score) as team_runs
    from fact_ball fb
    join fact_match fm
        on fb.match_no = fm.match_number    
    group by fm.match_number, batting_team_id
) runs_per_innings;


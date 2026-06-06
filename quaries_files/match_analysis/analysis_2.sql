-- Lowest team total ever.



select
    t.team_name,
    min(team_runs) as lowest_team_total
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
) runs_per_innings  
join dim_team t
    on runs_per_innings.batting_team_id = t.team_id 
group by t.team_name
order by lowest_team_total asc
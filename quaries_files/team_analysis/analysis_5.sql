-- Which team scores the most runs per match?



select
    t.team_name,
    round(avg(team_runs), 2) as avg_runs_per_match
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
) runs_per_match
join dim_team t
    on runs_per_match.batting_team_id = t.team_id
group by t.team_name
order by avg_runs_per_match desc;
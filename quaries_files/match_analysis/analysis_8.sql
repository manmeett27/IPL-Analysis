-- Average first innings score by season.



select
    ds.season as season,
    round(avg(team_runs), 2) as avg_first_innings_score
from (
    select
        fm.match_number,
        fm.season_id,
        case
            when fb.inningno = 1 then sum(fb.score)
        end as team_runs
    from fact_ball fb
    join fact_match fm on fb.match_no = fm.match_number
    where fb.inningno = 1
    group by fm.match_number, fm.season_id
) first_innings
join dim_season ds on first_innings.season_id = ds.season_id
group by ds.season
order by ds.season;
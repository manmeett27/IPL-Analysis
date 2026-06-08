-- Season-wise run trends.

select
    ds.season,
    round(avg(team_runs), 2) as avg_runs_per_match,
    max(team_runs) as highest_score,
    min(team_runs) as lowest_score
from (
    select
        fm.match_number,
        fm.season_id,
        sum(fb.score) as team_runs
    from fact_ball fb
    join fact_match fm on fb.match_no = fm.match_number
    group by fm.match_number, fm.season_id
) runs_by_match
join dim_season ds on runs_by_match.season_id = ds.season_id
group by ds.season
order by ds.season;
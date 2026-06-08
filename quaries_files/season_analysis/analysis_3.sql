-- Most runs by season.

select
    ds.season,
    sum(fb.score) as total_runs_season
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_season ds on fm.season_id = ds.season_id
group by ds.season
order by ds.season;
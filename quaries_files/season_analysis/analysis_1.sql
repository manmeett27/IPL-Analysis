-- Orange Cap winner each season (Most runs scorer in each season).

select
    ds.season,
    p.player_name,
    sum(fb.runs) as total_runs
from fact_batting fb
join dim_player p on fb.batter_id = p.player_id
join fact_match fm on fb.match_no = fm.match_number
join dim_season ds on fm.season_id = ds.season_id
group by ds.season, p.player_name
order by ds.season, total_runs desc;
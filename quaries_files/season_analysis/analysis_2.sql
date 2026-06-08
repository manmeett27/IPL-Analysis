-- Purple Cap winner each season (Most wickets taker in each season).

select
    ds.season,
    p.player_name,
    sum(case when fb.outcome = 'w' then 1 else 0 end) as total_wickets
from fact_ball fb
join dim_player p on fb.bowler_id = p.player_id
join fact_match fm on fb.match_no = fm.match_number
join dim_season ds on fm.season_id = ds.season_id
where fb.outcome = 'w'
group by ds.season, p.player_name
order by ds.season, total_wickets desc;
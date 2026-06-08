-- Season-wise sixes and fours trends.

select
    ds.season,
    sum(case when fb.score = 4 then 1 else 0 end) as total_fours,
    sum(case when fb.score = 6 then 1 else 0 end) as total_sixes,
    round(sum(case when fb.score = 4 then 1 else 0 end) * 100.0 / count(*), 2) as fours_percentage,
    round(sum(case when fb.score = 6 then 1 else 0 end) * 100.0 / count(*), 2) as sixes_percentage
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_season ds on fm.season_id = ds.season_id
group by ds.season
order by ds.season;
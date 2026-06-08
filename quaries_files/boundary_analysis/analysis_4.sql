-- Boundary percentage by season.

select
    ds.season,
    sum(case when fb.score in (4, 6) then 1 else 0 end) as total_boundaries,
    count(*) as total_balls,
    round(sum(case when fb.score in (4, 6) then 1 else 0 end) * 100.0 / count(*), 2) as boundary_percentage
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_season ds on fm.season_id = ds.season_id
group by ds.season
order by boundary_percentage desc;
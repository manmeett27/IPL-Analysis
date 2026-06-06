-- Boundary percentage by venue.

select
    dv.venue,
    sum(case when fb.score in (4, 6) then 1 else 0 end) as total_boundaries,
    count(*) as total_balls,
    round(sum(case when fb.score in (4, 6) then 1 else 0 end) * 100.0 / count(*), 2) as boundary_percentage
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_venue dv on fm.venue_id = dv.venue_id
group by dv.venue
order by boundary_percentage desc;
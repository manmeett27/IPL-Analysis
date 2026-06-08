-- Venue with most sixes.

select
    dv.venue,
    count(*) as total_sixes
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_venue dv on fm.venue_id = dv.venue_id
where fb.score = 6
group by dv.venue
order by total_sixes desc;
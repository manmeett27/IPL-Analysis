-- Which venue favors bowlers?



select 
    dv.venue as venue,
    ROUND(COUNT(*), 2) as total_wickets
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_venue dv on fm.venue_id = dv.venue_id
where fb.outcome = 'w'
group by dv.venue
order by total_wickets desc;
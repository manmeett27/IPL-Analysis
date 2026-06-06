-- Which venue favors batsmen?



select 
    dv.venue as venue,
    ROUND(SUM(fb.runs), 2) as total_runs
from fact_batting fb
join fact_match fm on fb.match_no = fm.match_number
join dim_venue dv on fm.venue_id = dv.venue_id
group by dv.venue
order by total_runs desc;


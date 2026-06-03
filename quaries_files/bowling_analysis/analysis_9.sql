-- Best bowler at a specific venue.

select
    p.player_name as bowler,
    sum(fb.score) as runs_conceded,
    sum(case when fb.outcome = 'w' then 1 else 0 end) as wickets,
    round(sum(fb.score) * 1.0 / nullif(sum(case when fb.outcome = 'w' then 1 else 0 end), 0), 2) as bowling_average
from fact_ball fb
join fact_match fm
    on fb.match_no = fm.match_number
join dim_player p
    on fb.bowler_id = p.player_id
join dim_venue v
    on fm.venue_id = v.venue_id
where v.venue = 'Wankhede Stadium' -- replace with desired venue
group by p.player_name
having sum(case when fb.outcome = 'w' then 1 else 0 end) > 0
order by bowling_average desc
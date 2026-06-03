-- Which bowler concedes the fewest boundaries?



select
    p.player_name as bowler,
    sum(case when fb.outcome in ('4', '6') then 1 else 0 end) as boundaries_conceded
from fact_ball fb
join dim_player p
    on fb.bowler_id = p.player_id
group by p.player_name
order by boundaries_conceded desc;
-- Which batsman performs best in powerplay overs?




select
    p.player_name as batter,
    sum(fb.score) as powerplay_runs,
    count(*) as balls_faced,
    round(sum(fb.score) * 100.0 / count(*), 2) as strike_rate
from fact_ball fb
join dim_player p
    on fb.batter_id = p.player_id
where fb.over between 1 and 6
group by p.player_name
order by powerplay_runs desc
limit 10;
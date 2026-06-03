-- Which batsman performs best in death overs?




select
    p.player_name as batter,
    sum(fb.score) as death_over_runs,
    count(*) as balls_faced,
    round(sum(fb.score) * 100.0 / count(*), 2) as strike_rate
from fact_ball fb
join dim_player p
    on fb.batter_id = p.player_id
where fb.over >= 16 and fb.over <= 20
group by p.player_name  
order by death_over_runs desc
limit 10;
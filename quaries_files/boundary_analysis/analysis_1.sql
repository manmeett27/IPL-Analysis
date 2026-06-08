-- Most fours by player.



select 
    p.player_name as batter, 
    count(*) as total_fours
from fact_ball fb
join dim_player as p
on fb.batter_id = p.player_id
where fb.score = 4  
group by p.player_name
order by total_fours desc;
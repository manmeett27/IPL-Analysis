-- Which batsman has the highest strike rate?


select 
    batter, 
    strike_rate
from fact_batting as batting
join dim_player as player
on batting.batter_id = player.player_id
order by batting.strike_rate desc

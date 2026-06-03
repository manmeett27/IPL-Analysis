-- Which bowler has the best economy rate?




select 
    player.player_name as bowler, 
    ROUND(bowling.economy) as economy
from fact_bowling as bowling
join dim_player as player   
on bowling.bowler_id = player.player_id
order by bowling.economy DESC
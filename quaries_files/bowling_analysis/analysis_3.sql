-- Which bowler has the best bowling average?




select
    player.player_name as bowler,
    round(sum(fb.score) * 1.0 / nullif(sum(case when fb.outcome = 'w' then 1 else 0 end), 0), 2) as bowling_average
from fact_ball fb
join dim_player as player
    on fb.bowler_id = player.player_id
group by player.player_name
order by bowling_average desc;
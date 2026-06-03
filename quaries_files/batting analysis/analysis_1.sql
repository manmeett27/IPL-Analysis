-- Who scored the most runs in IPL history?


select 
    batter, 
    sum(runs) as total_runs
from fact_batting
join dim_player as player
on fact_batting.batter_id = player.player_id
group by batter
order by total_runs desc

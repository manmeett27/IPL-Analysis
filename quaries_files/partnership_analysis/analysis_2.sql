-- Best batting pairs.



select
    dp1.player_name as player1,
    dp2.player_name as player2,
    sum(fb.score) as total_runs 
from fact_ball fb
join fact_match fm on fb.match_no = fm.match_number
join dim_player dp1 on fb.batter_id = dp1.player_id
join fact_ball fb2 on fb.match_no = fb2.match_no and fb.inningno = fb2.inningno
join dim_player dp2 on fb2.batter_id = dp2.player_id
where dp1.player_id < dp2.player_id
group by dp1.player_name, dp2.player_name
order by total_runs desc
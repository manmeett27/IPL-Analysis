-- Most successful opening pair.

select 
    p1.player_name as opener1,
    p2.player_name as opener2,
    count(distinct fb.match_no) as total_matches
from fact_ball fb
join dim_player p1 on fb.batter_id = p1.player_id
join fact_ball fb2 on fb.match_no = fb2.match_no and fb.inningno = fb2.inningno
join dim_player p2 on fb2.batter_id = p2.player_id
where fb.inningno = 1 and fb.batter_id < fb2.batter_id
group by p1.player_name, p2.player_name
order by total_matches desc
limit 10;
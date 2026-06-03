-- Who has taken the most wickets?




select 
    p.player_name as bowler, 
    count(*) as total_wickets
from fact_ball
join dim_player as p
on fact_ball.bowler_id = p.player_id
where fact_ball.outcome = 'w'
group by p.player_name
order by total_wickets desc

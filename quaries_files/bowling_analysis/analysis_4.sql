-- Most wickets in powerplay.



select
    p.player_name as bowler,
    sum(case when fb.outcome = 'w' then 1 else 0 end) as wickets_in_powerplay
from fact_ball fb
join dim_player p
    on fb.bowler_id = p.player_id
where fb.over >= 1 and fb.over <= 6
group by p.player_name
order by wickets_in_powerplay desc
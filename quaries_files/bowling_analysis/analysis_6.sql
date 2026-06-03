-- Most wickets in death overs.



select
    p.player_name as bowler,
    sum(case when fb.outcome = 'w' then 1 else 0 end) as wickets_in_death_overs
from fact_ball fb
join dim_player p
    on fb.bowler_id = p.player_id
where fb.over >= 16 and fb.over <= 20
group by p.player_name
order by wickets_in_death_overs desc;
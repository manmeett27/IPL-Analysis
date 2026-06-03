-- Best bowler against a particular team.

select
    p.player_name as bowler,
    sum(fb.score) as runs_conceded,
    sum(case when fb.outcome = 'w' then 1 else 0 end) as wickets,
    round(sum(fb.score) * 1.0 / nullif(sum(case when fb.outcome = 'w' then 1 else 0 end), 0), 2) as bowling_average
from fact_ball fb
join fact_match fm
    on fb.match_no = fm.match_number
join dim_player p
    on fb.bowler_id = p.player_id
join dim_team opponent
    on (fb.inningno = 1 and fm.team2_id = opponent.team_id)
    or (fb.inningno = 2 and fm.team1_id = opponent.team_id)
where opponent.team_name = 'RCB' -- replace with desired team
group by p.player_name
having sum(case when fb.outcome = 'w' then 1 else 0 end) > 0
order by bowling_average desc
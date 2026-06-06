-- Number of matches won by batting first vs chasing.



select
    sum(case when winner_runs > 0 then 1 else 0 end) as matches_won_by_batting_first,
    sum(case when winner_runs = 0 and winner_wickets > 0 then 1 else 0 end) as matches_won_by_chasing
from fact_match
where winner_runs is not null and winner_wickets is not null;

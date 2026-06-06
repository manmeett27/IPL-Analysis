-- Largest winning margin (wickets).

select
    max(winner_wickets) as largest_winning_margin_wickets
from fact_match
where winner_wickets is not null;

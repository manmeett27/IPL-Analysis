-- Average winning score by venue.



select
    dv.venue,
    round(avg(
        case
            when fm.winner_runs > 0 then fm.winner_runs
            else 0
        end
    ), 2) as avg_winning_margin_runs,
    round(avg(
        case
            when fm.winner_wickets > 0 then fm.winner_wickets
            else 0
        end
    ), 2) as avg_winning_margin_wickets
from fact_match fm
join dim_venue dv on fm.venue_id = dv.venue_id
where fm.winner_runs is not null and fm.winner_wickets is not null
group by dv.venue
order by avg_winning_margin_runs desc;
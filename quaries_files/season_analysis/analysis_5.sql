-- Champion team by season.

select
    ds.season,
    dt.team_name as champion,
    count(*) as wins_in_season
from fact_match fm
join dim_team dt on fm.winner_team_id = dt.team_id
join dim_season ds on fm.season_id = ds.season_id
group by ds.season, dt.team_name
order by ds.season, wins_in_season desc;
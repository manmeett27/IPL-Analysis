-- Preferred toss decision at each venue.



select 
    dv.venue,
    sum(case when fm.toss_decision = 'bat' then 1 ELSE 0 END) as toss_decision_bat_first,
    sum(case when fm.toss_decision = 'field' then 1 ELSE 0 END) as toss_decision_field_first,
    sum(case when fm.toss_decision = 'bat' and fm.toss_winner_team_id = fm.winner_team_id then 1 ELSE 0 END) as matches_won_batting_first,
    sum(case when fm.toss_decision = 'field' and fm.toss_winner_team_id = fm.winner_team_id then 1 ELSE 0 END) as matches_won_chasing,
    case 
        when sum(case when fm.toss_decision = 'bat' then 1 ELSE 0 END) = 0 then 0
        else round(sum(case when fm.toss_decision = 'bat' and fm.toss_winner_team_id = fm.winner_team_id then 1 ELSE 0 END) * 100.0 / sum(case when fm.toss_decision = 'bat' then 1 ELSE 0 END), 2)
    end as batting_first_success_percentage,
    case 
        when sum(case when fm.toss_decision = 'field' then 1 ELSE 0 END) = 0 then 0
        else round(sum(case when fm.toss_decision = 'field' and fm.toss_winner_team_id = fm.winner_team_id then 1 ELSE 0 END) * 100.0 / sum(case when fm.toss_decision = 'field' then 1 ELSE 0 END), 2)
    end as chasing_success_percentage
FROM fact_match fm
join dim_venue dv on fm.venue_id = dv.venue_id
group by dv.venue
order by venue;
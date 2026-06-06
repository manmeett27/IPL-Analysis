-- Most Super Overs.



select
    count(*) as total_super_overs
from fact_match
where match_type = 'Super Over';
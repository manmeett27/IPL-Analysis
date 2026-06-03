-- Who has scored the most 50s and 100s?




SELECT
    p.player_name,

    SUM(
        CASE
            WHEN fb.runs >= 50
             AND fb.runs < 100
            THEN 1
            ELSE 0
        END
    ) AS fifties,

    SUM(
        CASE
            WHEN fb.runs >= 100
            THEN 1
            ELSE 0
        END
    ) AS hundreds

FROM fact_batting fb
JOIN dim_player p
    ON fb.batter_id = p.player_id

GROUP BY p.player_name

ORDER BY hundreds DESC,
         fifties DESC;
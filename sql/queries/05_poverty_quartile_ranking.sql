WITH quartiled AS (
    SELECT
        d.tract,
        d.poverty_rate,
        d.median_income,
        h.OBESITY_CrudePrev,
        s.snap_rate,
        NTILE(4) OVER (ORDER BY d.poverty_rate DESC) AS poverty_quartile
    FROM tract_demographics d
    JOIN tract_health h ON d.tract = h.tract
    JOIN tract_snap s ON d.tract = s.tract
)
SELECT
    tract,
    poverty_rate,
    poverty_quartile,
    OBESITY_CrudePrev,
    snap_rate,
    median_income,
    RANK() OVER (PARTITION BY poverty_quartile ORDER BY OBESITY_CrudePrev DESC) AS obesity_rank_in_quartile,
    ROUND(AVG(OBESITY_CrudePrev) OVER (PARTITION BY poverty_quartile), 2)       AS avg_obesity_in_quartile
FROM quartiled
ORDER BY poverty_quartile, obesity_rank_in_quartile;

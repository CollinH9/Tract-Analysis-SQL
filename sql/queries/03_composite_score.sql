SELECT
    CASE
        WHEN f.dist_to_grocery_km < 1 THEN 'Near grocery'
        WHEN f.dist_to_grocery_km BETWEEN 1 AND 3 THEN 'Moderate access'
        ELSE 'Far from grocery'
    END AS access_tier,
    ROUND(AVG(h.OBESITY_CrudePrev), 2) AS avg_obesity,
    ROUND(AVG(d.poverty_rate), 2) AS avg_poverty,
    ROUND(AVG(s.snap_rate), 2) AS avg_snap,
    COUNT(*) AS tract_count
FROM tract_food_access f
JOIN tract_health h ON f.tract = h.tract
JOIN tract_demographics d ON f.tract = d.tract
JOIN tract_snap s ON f.tract = s.tract
GROUP BY access_tier
ORDER BY avg_obesity DESC;

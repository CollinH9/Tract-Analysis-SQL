SELECT
    s.tract,
    s.snap_rate,
    h.OBESITY_CrudePrev,
    d.poverty_rate,
    f.dist_to_grocery_km
FROM tract_snap s
JOIN tract_health h ON s.tract = h.tract
JOIN tract_demographics d ON s.tract = d.tract
JOIN tract_food_access f ON s.tract = f.tract
WHERE s.snap_rate > 15
  AND h.OBESITY_CrudePrev < 35
ORDER BY s.snap_rate DESC;

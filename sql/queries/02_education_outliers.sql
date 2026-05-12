SELECT
    s.tract,
    d.percent_no_hs,
    h.OBESITY_CrudePrev,
    s.snap_rate,
    d.poverty_rate,
    f.dist_to_grocery_km
FROM tract_demographics d
JOIN tract_health h ON d.tract = h.tract
JOIN tract_snap s ON d.tract = s.tract
JOIN tract_food_access f ON d.tract = f.tract
WHERE d.percent_no_hs > 10
  AND h.OBESITY_CrudePrev < 35
ORDER BY d.percent_no_hs DESC;

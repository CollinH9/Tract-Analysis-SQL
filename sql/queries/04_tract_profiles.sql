SELECT
    d.tract,
    d.poverty_rate,
    d.percent_no_hs,
    d.percent_uninsured,
    d.percent_no_car,
    d.median_income,
    h.OBESITY_CrudePrev,
    h.DIABETES_CrudePrev,
    h.CHD_CrudePrev,
    f.dist_to_grocery_km,
    f.fast_food_density,
    s.snap_rate,
    s.pct_under_18,
    s.pct_65_plus
FROM tract_demographics d
JOIN tract_health h ON d.tract = h.tract
JOIN tract_food_access f ON d.tract = f.tract
JOIN tract_snap s ON d.tract = s.tract
ORDER BY d.tract;

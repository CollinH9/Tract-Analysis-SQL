CREATE TABLE tract_demographics AS
SELECT tract,
       poverty_rate,
       percent_no_hs,
       percent_uninsured,
       percent_no_car,
       median_income
FROM read_csv_auto('data/Lancaster_County_Final.csv');

CREATE TABLE tract_health AS
SELECT tract,
       OBESITY_CrudePrev,
       DIABETES_CrudePrev,
       CHD_CrudePrev
FROM read_csv_auto('data/Lancaster_County_Final.csv');

CREATE TABLE tract_food_access AS
SELECT tract,
       dist_to_grocery_km,
       fast_food_density
FROM read_csv_auto('data/Lancaster_County_Final.csv');

CREATE TABLE tract_snap AS
SELECT tract,
       snap_rate,
       pct_under_18,
       pct_65_plus
FROM read_csv_auto('data/Lancaster_County_Final.csv');

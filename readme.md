# Lancaster County Health and Food Access Analysis

This project uses SQL as the primary analytical tool to explore the relationship between food access, poverty, and health outcomes across 78 census tracts in Lancaster County, NE. Data loads into a DuckDB in-memory database via a normalized schema, then queries from basic aggregations through window functions and visualizes in a Jupyter notebook.

---

## Schema Design

The source data splits into four domain tables on load. All tables share `tract` as a join key. Normalizing by domain keeps queries focused and makes joins explicit.

**tract_demographics.** tract, poverty_rate, percent_no_hs, percent_uninsured, percent_no_car, median_income

**tract_health.** tract, OBESITY_CrudePrev, DIABETES_CrudePrev, CHD_CrudePrev

**tract_food_access.** tract, dist_to_grocery_km, fast_food_density

**tract_snap.** tract, snap_rate, pct_under_18, pct_65_plus

Schema creates in `sql/schema.sql` using DuckDB's `read_csv_auto`.

---

## Queries

### 01_vulnerability_ranking.sql
Which tracts are most socioeconomically vulnerable?

Computes a composite vulnerability score weighted across educational disadvantage (40%), poverty rate (30%), and SNAP usage (30%). Weights reflect random forest feature importance ordering from the companion analysis. Joins three tables and ranks all 78 tracts by the result.

### 02_education_outliers.sql
Which tracts break the education-obesity relationship?

Filters for tracts where percent without a high school diploma exceeds 10% but obesity stays below 35%. These tracts defy the dominant pattern. What structural factors protect residents from the expected health outcomes despite low educational attainment?

### 03_composite_score.sql
Does physical proximity to a grocery store predict better health outcomes?

Groups tracts into access tiers (near, moderate, far) using a CASE expression and compares average obesity, poverty, and SNAP rates across tiers via group aggregations.

### 04_tract_profiles.sql
What does the full picture look like for every tract?

A wide join across all four tables returning all demographic, health, food access, and assistance variables per tract. Used as the base for scatter plots comparing income to health outcomes.

### 05_poverty_quartile_ranking.sql
Within each poverty tier, which tracts carry the worst obesity burden?

Uses NTILE(4) to assign tracts to poverty quartiles, RANK() OVER (PARTITION BY ...) to rank tracts by obesity within each quartile, and AVG() OVER (PARTITION BY ...) to compute a quartile level obesity average as a window aggregate, all in a single query via a CTE.

---

## Key Findings

**1. Education and SNAP are the dominant predictors, essentially tied.**
SNAP participation (r = 0.76) and percent without a high school diploma (r = 0.75) are the two strongest bivariate predictors of obesity. The random forest breaks the tie. Education carries an importance weight of 0.527, more than double SNAP at 0.241. Both variables concentrate in the same urban core tracts, making them difficult to separate at this geographic scale.

**2. High educational disadvantage with low obesity is rare.**
Only two tracts (7.00 and 10.02) have percent without a high school diploma above 10% and obesity below 35%. Tract 7.00 has high SNAP usage but low obesity, suggesting other protective factors at work. Tract 10.02 has low poverty and low SNAP, meaning its educational disadvantage does not come with the typical financial barriers. When education and economic conditions diverge, health outcomes follow the economics more closely.

**3. Near grocery tracts have the highest average obesity.**
Tracts within 1 km of a grocery store average higher obesity than moderate or far access tracts. Proximity clusters in urban low-income areas where structural poverty drives food insecurity regardless of physical distance to stores.

**4. Poverty quartile analysis confirms a monotonic gradient.**
Average obesity, SNAP usage, and poverty rates decline consistently from Q1 (highest poverty) to Q4 (lowest). Poverty is a stronger structural driver of health outcomes than grocery distance alone.

---

## Running the Notebook

```bash
# From the project root
.venv/Scripts/jupyter notebook analysis.ipynb
```

Requires duckdb, pandas, and matplotlib installed in `.venv`.
# Lancaster County Health Data DB

A DuckDB-powered analysis of health, food access, and economic vulnerability across Lancaster County census tracts.

## Schema

The raw CSV is split into four focused tables:

| Table | Columns |
|---|---|
| `tract_demographics` | poverty rate, education, insurance, car access, income |
| `tract_health` | obesity, diabetes, coronary heart disease prevalence |
| `tract_food_access` | distance to nearest grocery, fast food density |
| `tract_snap` | SNAP participation rate, age distribution |

Normalizing by topic keeps queries focused and makes joins explicit — you always know exactly which dimensions you're combining.

## Queries

| File | Question |
|---|---|
| `01_vulnerability_ranking.sql` | Which tracts are most socioeconomically vulnerable? Composite score: 30% poverty + 30% low education + 40% SNAP rate. |
| `02_snap_outliers.sql` | Which high-SNAP tracts have surprisingly low obesity? These may signal effective food program reach despite poverty. |
| `03_composite_score.sql` | Do tracts farther from a grocery store show worse health outcomes on average? |
| `04_tract_profiles.sql` | Full side-by-side profile of every tract across all dimensions. |

## Key Findings

Tracts with the highest vulnerability scores cluster around high SNAP participation and low educational attainment more than poverty rate alone. Tracts more than 3 km from a grocery store show meaningfully higher average obesity and poverty rates than those within 1 km. A subset of high-SNAP tracts maintain below-average obesity rates, suggesting food access or program effectiveness varies significantly across the county even within similar income bands.

## Running the Analysis

Open `analysis.ipynb` in VS Code or Jupyter. The first cell loads the schema and all subsequent cells run queries and produce charts. Requires `duckdb`, `pandas`, and `matplotlib` installed in your Python environment.

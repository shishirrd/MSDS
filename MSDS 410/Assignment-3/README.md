# MSDS 410 — Assignment 3: Multiple Linear Regression + Nested F-Test (Ames Housing)

## What it does
Continues the Ames Housing analysis from Assignment 1, now fitting multiple linear
regression models. Fits a "Quality/Age Variables" model (OverallQual, YearBuilt,
YearRemodel, GarageYrBlt) and compares it against a combined model via a nested F-test
to determine whether the additional variables provide statistically significant
improvement in explanatory power.

## Techniques/libraries used
- R: `tidyverse`, `knitr`
- Multiple linear regression (`lm`)
- Nested F-test for model comparison (`pf()` for p-value calculation)

## Data note
Ran against the Ames Housing dataset (`ames_housing_data.csv`) — not included (large
dataset file, course-provided, same as Assignment 1).

# MSDS 410 — Assignment 9: Poisson and Zero-Inflated Poisson (ZIP) Regression (Stress Data)

## What it does
Models count data (a stress-response outcome) using Poisson regression and Zero-Inflated
Poisson (ZIP) regression to account for excess zero counts. Compares model fit between
approaches and interprets coefficients in the context of count-data modeling.

## Techniques/libraries used
- R: `readxl`, `ggplot2`, `dplyr`, `knitr`, `gridExtra`, `moments`, `car`, `pROC`, `pscl`
  (`zeroinfl`), `broom`
- Poisson regression, Zero-Inflated Poisson (ZIP) regression, model comparison

## Data note
Ran against the STRESS dataset (`STRESS.csv`/`STRESS.xlsx`) — not included (course-provided
dataset).

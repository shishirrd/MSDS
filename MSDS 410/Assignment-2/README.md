# MSDS 410 — Assignment 2: Simple Linear Regression (US States Demographics)

## What it does
Builds and compares three simple linear regression models predicting state-level
HouseholdIncome from a single explanatory variable each (College %, Obesity rate, Insured
rate). Covers explanatory-vs-response variable classification, descriptive statistics,
scatterplots and Pearson correlations, hypothesis testing (T-tests on coefficients, F-test/
ANOVA on the overall model), manual derivation of SSE/SST/SSR/R-squared (verified against
the built-in ANOVA output), and standardized residual diagnostics for each model.

## Techniques/libraries used
- R: `ggplot2`, `dplyr`, `stats`, `corrplot`, `knitr`
- Simple linear regression (`lm`), ANOVA, T-tests, manual sum-of-squares decomposition
- Standardized residual diagnostics (histogram + fitted-value scatterplot)

## Data note
Ran against a 50-state demographic dataset (`USStates.csv`) — not included (small
course-provided dataset). Path is hardcoded to a local absolute path in the original file —
update to your own working directory before running.

# MSDS 410 — Assignment 6: Variable Selection and Model Validation (Ames Housing)

## What it does
Finalizes the Ames Housing price prediction model. Applies variable selection techniques
(stepwise selection via `stepAIC`) and multicollinearity checks (`vif`), and validates the
resulting model through diagnostic evaluation — bringing together the EDA, transformation,
and model-building work from Assignments 1, 3, and 4 into a validated final model.

## Techniques/libraries used
- R: `tidyr`, `readr`, `MASS` (`stepAIC`), `car` (`vif`), `knitr`, `dplyr`
- Stepwise variable selection, variance inflation factor (multicollinearity) checks
- Model validation diagnostics

## Data note
Ran against the Ames Housing dataset (`ames_housing_data.csv`) — not included (large
dataset file, course-provided, same as Assignments 1, 3, and 4).

## Note
Two earlier draft/scaffold versions of this notebook (`Assignment6_Complete.Rmd` and
`ClaudeCodeAssignment6.Rmd`) existed alongside the final submission — only the final version
is included here. A trivial unrelated scratch calculation file (`Quiz.Rmd`, an AIC/BIC
formula check) was also excluded as non-assignment scratch work.

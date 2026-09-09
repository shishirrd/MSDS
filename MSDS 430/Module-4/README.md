# MSDS 430 — Module 4: File I/O + EDA Project Proposal / Phase 1

## What it does
Two parallel tracks this module:
1. **Python file I/O assignment** — reading data from four file formats (`.txt`, `.csv`,
   `.xlsx`, `.json`) into Python, building/manipulating lists, and writing data back out.
2. **EDA Project kickoff** (Proposal + Phase 1) — the start of a term-long exploratory
   data analysis project. Chose the City of Austin's public financial "eCheckbook" dataset
   (expenditure transactions, ~624K records for FY2020-2025) with a stated goal of analyzing
   departmental spending patterns, vendor concentration risk, and seasonality — motivated by
   parallels to real financial transaction analysis work. Phase 1 covers initial data
   inspection (`info`, `head`, `tail`, `describe`) and cleaning/prep planning.

## Files
- `Deshpande _ Module_4_Python_Assignment.ipynb` — file I/O exercises.
- `Deshpande_EDA_Project_Module4.ipynb` — EDA project proposal + Phase 1 (continues across
  Modules 6, 8, and 10 — see those modules' READMEs).
- `Exploring.ipynb` — exploratory scratch notebook for the EDA dataset.

## Data note
Ran against the City of Austin Finance "eCheckbook" open dataset and a state population
dataset (`population.txt/csv/xlsx/json`) — not included here (large, and some are
professor-provided starter files). Austin dataset: https://data.austintexas.gov/Budget-and-Finance/Austin-Finance-Online-eCheckbook/8c6z-qnmj

## Techniques/libraries used
- pandas (`read_csv`, `read_excel`, `read_json`)
- Python file I/O (`open`)


Readme · MD
# 🏏 IPL Analysis
 
A comprehensive data analysis project on the **Indian Premier League (IPL)**, built entirely with Python. This project explores match statistics, player performances, team strategies, and season-wise trends using structured datasets, Python scripts, and SQL queries.
 
---
 
## 📁 Project Structure
 
```
IPL-Analysis/
│
├── datasets/               # Raw CSV datasets (matches & deliveries)
├── python_files/           # Python scripts for data cleaning, analysis & visualization
├── quaries_files/          # SQL query files for structured data exploration
├── .vscode/                # VS Code workspace settings
└── .gitignore
```
 
---
 
## 📊 About the Project
 
The IPL is one of the world's most popular T20 cricket leagues. This project dives deep into historical IPL data to uncover:
 
- **Team performance** — win/loss records, winning percentages, toss impact
- **Batting analysis** — top run-scorers, strike rates, centuries & half-centuries
- **Bowling analysis** — top wicket-takers, economy rates, dismissal types
- **Match trends** — venue statistics, season-wise comparisons, margin of victories
- **Player of the Match** analysis and key match contributors
---
 
## 🗂️ Datasets
 
The `datasets/` folder contains the core IPL data files (CSV format):
 
| File | Description |
|------|-------------|
| `matches.csv` | Match-level summary — teams, venue, toss, winner, player of the match |
| `deliveries.csv` | Ball-by-ball data — runs, wickets, extras, batting/bowling details |
 
> 📌 Datasets sourced from [Kaggle IPL Dataset](https://www.kaggle.com/datasets/nowke9/ipldata)
 
---
 
## 🐍 Python Files
 
The `python_files/` folder contains Python scripts that perform:
 
- **Data Loading & Cleaning** — handling missing values, data type corrections
- **Data Merging** — joining `matches` and `deliveries` on `match_id`
- **Exploratory Data Analysis (EDA)** — aggregations, groupings, filters
- **Visualizations** — bar charts, pie charts, and trend plots using `Matplotlib` & `Seaborn`
---
 
## 🗃️ Query Files
 
The `quaries_files/` folder contains SQL queries for:
 
- Filtering top batsmen and bowlers by season
- Aggregating team win counts and win percentages
- Identifying match outcomes based on toss decisions
- Venue-based performance breakdowns
---
 
## 🛠️ Tech Stack
 
| Tool / Library | Purpose |
|----------------|---------|
| Python 3.x | Core programming language |
| Pandas | Data manipulation & analysis |
| NumPy | Numerical operations |
| Matplotlib | Static visualizations |
| Seaborn | Statistical data visualization |
| SQL | Structured data querying |
| VS Code | Development environment |
 
---

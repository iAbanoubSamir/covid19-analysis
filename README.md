# COVID-19 Data Analysis Project

A comprehensive analysis of COVID-19 global data using Python, Pandas, and MySQL to uncover insights about the pandemic's spread and impact across different regions.

## 📊 Project Overview

This project analyzes COVID-19 data to understand patterns, trends, and impacts across different countries and regions. We focus on key metrics like case numbers, mortality rates, and regional distribution to provide meaningful insights about the pandemic's progression.

## 🔍 Key Features

- Global trend analysis of COVID-19 cases and deaths
- Regional distribution of cases across WHO regions
- Country-wise comparison of key metrics
- Mortality rate analysis by region
- Growth rate and doubling time calculations
- Advanced data visualization
- MySQL integration for robust data storage

## 🛠️ Technologies Used

- **Python** - Primary programming language
- **Pandas** - Data manipulation and analysis
- **Matplotlib** - Data visualization
- **MySQL** - Database management
- **SQLAlchemy** - Database ORM
- **Jupyter Notebook** - Interactive development
- **Docker** - Containerization

## 📂 Project Structure

```
covid19-data-analysis/
├── CovidDataAnalysis.ipynb    # Main analysis notebook
├── mysql.yml                  # Docker compose configuration
├── requirements.txt           # Python dependencies
├── databases/
│   ├── cleaned_data/         # Processed dataset
│   └── original_data/        # Raw dataset
├── plots/                    # Generated visualizations
└── sql/                      # SQL queries and schemas
```

## 📈 Key Insights

1. **Global Trends**
   - Tracks daily new cases and deaths worldwide
   - Shows 7-day rolling averages for smoother trend lines

2. **Regional Analysis**
   - Distribution of cases across WHO regions
   - Comparative analysis of mortality rates

3. **Country-specific Insights**
   - Top 10 countries by total cases
   - Growth rate analysis for top 5 affected countries
   - First occurrence tracking and peak analysis

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/iAbanoubSamir/covid19-analysis.git
   cd covid19-analysis
   ```

2. **Set up the environment**
   ```bash
   docker-compose -f mysql.yml up -d
   ```

3. **Install Python dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Setup MySQL with MySQL-Workbench**
   - Access it through port 3000 and setup you connection.
<br>

5. **Launch Jupyter Notebook**
   - Access through Docker container, view logs, and open the link you will find with token [ServerApp].
   - Open `CovidDataAnalysis.ipynb` 

## 📊 Data Processing

The analysis includes several data cleaning and processing steps:
- Date formatting and standardization
- Handling missing values
- Calculating derived metrics
- Data quality checks
- Feature engineering

## 🔍 Analysis Features

1. **Time Series Analysis**
   - Daily case tracking
   - Rolling averages
   - Growth rate calculations

2. **Geographic Analysis**
   - Country-wise comparisons
   - Regional distributions
   - WHO region analysis

3. **Statistical Metrics**
   - Mortality rates
   - Recovery rates
   - Case doubling time

## 📊 Visualizations

The project includes several key visualizations that help understand the COVID-19 data patterns and trends:

Some of the visualizations:

### Top 10 Countries Comparison
![Top 10 Countries Comparison](plots/Top%2010%20Countries%20Comparison.png)
This visualization shows the comparison of total confirmed cases among the top 10 most affected countries, helping understand which nations were most impacted by the pandemic.

### WHO Region Distribution
![WHO Region Distribution](plots/WHO%20Region%20Distribution.png)
A pie chart showing the distribution of COVID-19 cases across different WHO regions, providing insights into the geographical spread of the virus.

### Case Growth Analysis
![Case Growth Analysis](plots/Case%20Growth%20Analysis%20for%20Top%205%20Countries.png)
This graph displays the progression of daily new cases (7-day average) for the top 5 most affected countries, showing different waves and patterns of the pandemic across these nations.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

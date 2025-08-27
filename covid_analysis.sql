USE CovidData;


-- Rename some columns names
ALTER TABLE daily_reports
CHANGE COLUMN `Country/Region` Country VARCHAR(100);

ALTER TABLE daily_reports
CHANGE COLUMN `WHO Region` WHO_Region VARCHAR(100);

-- Preview first 10 rows to understand the structure of the dataset
SELECT *
FROM daily_reports
LIMIT 10;


-- Calculate total confirmed cases and deaths worldwide
SELECT 
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered,
    SUM(active) AS total_active
FROM daily_reports;


-- Aggregate total confirmed, deaths, recovered, and active cases by country
SELECT 
    country,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered,
    SUM(active) AS total_active
FROM daily_reports
GROUP BY country
ORDER BY total_confirmed DESC;


-- Show the 10 countries with the highest total deaths
SELECT 
    country,
    SUM(deaths) AS total_deaths
FROM daily_reports
GROUP BY country
ORDER BY total_deaths DESC
LIMIT 10;


-- Compute daily new cases per country
SELECT 
    country,
    date,
    confirmed - LAG(confirmed, 1, 0) OVER (
        PARTITION BY country 
        ORDER BY date
    ) AS new_cases
FROM daily_reports
ORDER BY country, date;


-- Get daily trend of confirmed cases for Egypt
SELECT 
    date,
    confirmed,
    deaths,
    recovered,
    active
FROM daily_reports
WHERE country = 'Egypt'
ORDER BY date;


-- Summarize confirmed, deaths, recovered by WHO region
SELECT 
    who_region,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered,
    SUM(active) AS total_active
FROM daily_reports
GROUP BY who_region
ORDER BY total_confirmed DESC;


-- Calculate mortality rate (deaths/confirmed) and recovery rate (recovered/confirmed) per country
SELECT 
    country,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    (SUM(deaths) / SUM(confirmed)) * 100 AS mortality_rate,
    (SUM(recovered) / SUM(confirmed)) * 100 AS recovery_rate
FROM daily_reports
GROUP BY country
HAVING SUM(confirmed) > 1000 -- filter out very small countries
ORDER BY mortality_rate DESC;


-- Identify countries with the highest daily growth (using 7-day average new cases)
WITH daily_cases AS (
    SELECT 
        country,
        date,
        confirmed - LAG(confirmed, 1, 0) OVER (
            PARTITION BY country 
            ORDER BY date
        ) AS new_cases
    FROM daily_reports
)
SELECT 
    country,
    AVG(new_cases) AS avg_daily_new_cases
FROM daily_cases
WHERE new_cases IS NOT NULL
GROUP BY country
ORDER BY avg_daily_new_cases DESC
LIMIT 10;


-- Compute 7-day moving average of daily new cases for Egypt
WITH daily_cases AS (
    SELECT 
        date,
        confirmed - COALESCE(LAG(confirmed) OVER (
            PARTITION BY country ORDER BY date
        ), 0) AS new_cases
    FROM daily_reports
    WHERE country = 'Egypt'
)
SELECT 
    date,
    ROUND(AVG(new_cases) OVER (
        ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS avg_7day_cases
FROM daily_cases
ORDER BY date;


-- Find the date of the first confirmed case in each country
SELECT 
    country,
    MIN(date) AS first_case_date
FROM daily_reports
WHERE confirmed > 0
GROUP BY country
ORDER BY first_case_date;


-- List the first 10 countries to report confirmed cases
SELECT 
    country,
    MIN(date) AS first_report_date
FROM daily_reports
WHERE confirmed > 0
GROUP BY country
ORDER BY first_report_date
LIMIT 10;


-- Find the maximum single-day new cases for each country
WITH daily_cases AS (
    SELECT 
        country,
        date,
        confirmed - COALESCE(LAG(confirmed) OVER (
            PARTITION BY country ORDER BY date
        ), 0) AS new_cases
    FROM daily_reports
)
SELECT 
    country,
    MAX(new_cases) AS peak_daily_cases
FROM daily_cases
GROUP BY country
ORDER BY peak_daily_cases DESC
LIMIT 10;


-- Compare mortality and recovery rates at the WHO region level
SELECT 
    who_region,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered,
    ROUND(SUM(deaths) / SUM(confirmed) * 100, 2) AS mortality_rate_pct,
    ROUND(SUM(recovered) / SUM(confirmed) * 100, 2) AS recovery_rate_pct
FROM daily_reports
GROUP BY who_region
ORDER BY mortality_rate_pct DESC;

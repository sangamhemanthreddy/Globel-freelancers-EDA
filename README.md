# SQL-EDA-PROJECTS
Aspiring Data Analyst skilled in translating raw data into actionable insights using MySQL, Excel, and Power BI. Dedicated to mastering the technical stack required to drive business decisions. Currently focusing on building a portfolio of impactful projects that will be shared shortly. Eager to connect and learn.

-- 23.List the name of the youngest freelancer (lowest age) who is also in the top 20% of the highest earners (based on hourly rate).
 ```sql
WITH CTE  AS 
( SELECT name, age, `hourly_rate (USD)`,
  PERCENT_RANK() OVER (ORDER BY `hourly_rate (USD)`) AS rate_percentile
   FROM freelancers_data
 )
  SELECT name, age, `hourly_rate (USD)`
FROM CTE
WHERE rate_percentile >= 0.8
ORDER BY age ASC
LIMIT 1 ; ```
<img width="450" height="122" alt="image" src="https://github.com/user-attachments/assets/0b8df81d-17e0-4e1a-976e-2f3ed107ff2f" />


# GLOBAL-FREELANCERS-SQL-DATA ANALASIS 
# Project Overview :
 This project focuses on cleaning, standardizing, and analyzing a raw dataset of global freelancer profiles to extract meaningful business and market insights. The goal was to transform inconsistent, messy text fields into clean, structured data ready for statistical analysis and visualization.
 # Key Data Cleaning Decisions : 
* The primary challenges addressed during the cleaning phase were:
 
* Handling Missing Data: Converted placeholder values (e.g., ’N/A’, blanks) and incorrectly imputed values (e.g., ’0’ in hourly rates) to NULL to preserve data integrity and prevent calculation errors.

* Standardizing Text:
*Gender was standardized to consistent categories (’Male’, ’Female’, etc.).
is_active status was standardized to clear categories (’Yes’ or ’No’).

* Cleaning Numerical Fields: Removed non-numeric characters (like $\text{'$'}$ and ’USD’) from the hourly_rate (USD) column to allow it to be cast to a numeric type (INT or DECIMAL).

* Duplicate Removal: Ensured data uniqueness by removing duplicate entries based on the freelancer_ID.

# Key Insights & Findings from Freelancers-dataset  EDA
* The exploratory analysis revealed several important characteristics of the freelancer market:

 * Rate vs. Experience: A common query pattern explored the relationship between high hourly_rate and years_of_experience, particularly flagging highly-paid beginners (rate>$80, experience<3 years) for further investigation.

* Skill Compensation Disparity: Analysis of AVG( 
hˋ ourly_rate (USD) )ˋ grouped by primary_skill revealed significant pay differences, indicating which skills command the highest market value.

* Compensation and Activity: A comparison of AVG( 
hˋourly_rate (USD) )ˋfor active vs. inactive freelancers provides insight into market competitiveness and pricing strategy.

* High-Quality Segment (Rating ≥4): Identified the languages and countries that produce the largest pool of highly-rated talent, crucial for targeting recruitment or business development efforts.

* Satisfaction Hotspots: Calculation of the percentage of freelancers with client_satisfaction≥4.0 per country highlights regions with strong quality assurance.
# ⚙️ Core Practice Techniques
The project exercises utilized several intermediate MySQL features to demonstrate robust data manipulation skills:

Technique	Purpose
Conditional Aggregation	Used SUM(CASE WHEN ... THEN 1 ELSE 0 END) to calculate percentages and count subsets (e.g., active males, satisfied clients) within GROUP BY clauses.

Subqueries	Used to filter data against overall averages (e.g., finding freelancers with satisfaction above the global mean).

CTEs (Common Table Expressions)	Used to structure complex queries, particularly in multi-step calculations like finding the overall most common language among highly-rated speakers.

Data Segmentation	Used the CASE statement to categorize freelancers into experience levels (Beginner, Intermediate, Expert).



 -- 1. FINDING MIN,MAX,AVG OF  AGE , STDDEV AGE    AND EXPIREICES AS WELL --
```sql  
SELECT 'Age' AS Metric, 
 COUNT(age) AS Non_Null_Count,
    MIN(age) AS Min_Age,
    MAX(age) AS Max_Age, 
   ROUND( AVG(age),3) AS Avg_Age, 
   ROUND( STDDEV(age) ,3)AS StdDev_Age
FROM freelancers_data
UNION ALL
SELECT'Experience' AS Metric,
    COUNT(years_of_experience),
    MIN(years_of_experience),
    MAX(years_of_experience),
  ROUND( AVG(years_of_experience) ,3),
   ROUND( STDDEV(years_of_experience),3)
FROM freelancers_data ; sql```

<img width="792" height="127" alt="image" src="https://github.com/user-attachments/assets/1d5e893d-6d09-4fc3-a345-74fdc37e4fa4" />

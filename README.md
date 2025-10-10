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



 1. FINDING MIN,MAX,AVG OF  AGE , STDDEV AGE    AND EXPIREICES AS WELL --
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
FROM freelancers_data ;
 ```

------------------------------------------------------------------------------
2. Finding Top Skills and Their Average Rates

```sql
SELECT
 primary_skill ,
  COUNT(primary_skill) AS Skill_Count,
  ROUND(AVG( `hourly_rate (USD)` ), 2) AS Avg_Hourly_Rate
FROM
  freelancers_data
GROUP BY
 primary_skill
ORDER BY
  Skill_Count DESC ;
```
This query identifies the most popular skills among freelancers and calculates the average rate associated with each skill.
primary_skill	Skill_Count	Avg_Hourly_Rate

------------------------------------------------------------------------------
 3.List the name of the youngest freelancer (lowest age) who is also in the top 20% of the highest earners (based on hourly rate).
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
LIMIT 5 ;
```
------------------------------------------------------------------------------ 
4 .Show the count of freelancers categorized by both gender and is_active status (Active Count and Inactive Count per Gender).
```sql
SELECT COUNT(*) AS numoffreelancers , gender , is_active
FROM freelancers_data 
GROUP BY gender , is_active 
ORDER BY  numoffreelancers DESC ;

-- out put 
n     g       is active or not
225	 Male      	No
209	 Female 	   Yes
203 	Female 	   No
202 	Male 	     Yes
49 	Female    	Unknown
34	 Male 	    Unknown
```
------------------------------------------------------------------------------
5 .Identify the language that is spoken by the highest number of freelancers who also have a rating of 4 or above.
```sql
WITH CTE AS ( SELECT `language` , COUNT(`language`) AS Numof_speakers  , rating 
  FROM freelancers_data 
  WHERE rating  >= 4 AND `language` IS NOT NULL 
  GROUP BY `language` ,  rating 
  )
  SELECT  `language` , SUM(Numof_speakers) AS Total_numof_speakers
  FROM CTE 
  GROUP BY `language` 
  ORDER BY  SUM(Numof_speakers)  DESC 
  LIMIT 3  ;
```
from this query , 65 freelancers can speak english  , Spanish	29 ,
21 freelancers can speak Korean	 and it also cosiders the rating above 4 ..

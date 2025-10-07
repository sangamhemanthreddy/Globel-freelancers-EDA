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








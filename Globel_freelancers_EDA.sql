SELECT * FROM global_freelancers_raw ;

-- 1.STANDARDIZE THE DATA -- 
-- 2. changing columns thier correct datatypes --
-- 3 filling blanks with nulls  --
-- 4. handling nulls  , if null values are in nummaric columns so we can use their avarage to fill the nulls  --- 

SELECT * FROM 
global_freelancers_raw 
WHERE `hourly_rate (USD)` IS NULL ;

UPDATE  global_freelancers_raw 
SET  `hourly_rate (USD)` = NULL 
WHERE `hourly_rate (USD)` = '' ;

UPDATE global_freelancers_raw 
SET `hourly_rate (USD)`= TRIM(`hourly_rate (USD)`) ;

UPDATE  global_freelancers_raw  
SET `hourly_rate (USD)` = REPLACE(`hourly_rate (USD)` , '$' , '' ) ,
      `hourly_rate (USD)` = REPLACE(`hourly_rate (USD)` , 'USD' , '')   ;
      
   ALTER TABLE global_freelancers_raw 
   MODIFY COLUMN `hourly_rate (USD)` INT ;
      
      SELECT * FROM global_freelancers_raw 
      WHERE client_satisfaction IS NULL ;
      
      UPDATE  global_freelancers_raw 
SET  rating = NULL 
WHERE rating = '' ;
      -- REPLACING BLANKS WITH NULLS -- 
      UPDATE  global_freelancers_raw 
SET  client_satisfaction = NULL 
WHERE client_satisfaction  = '' ;
      
      
      UPDATE  global_freelancers_raw 
SET is_active = NULL 
WHERE is_active  = '' ;

SELECT * FROM global_freelancers_raw ;
-- REMOVING  SPACE FROM COULUMNS -- 

UPDATE global_freelancers_raw  
SET freelancer_ID = TRIM(freelancer_ID) ,
   `name` = TRIM(`name`) ,
   gender = TRIM(gender) ,
   age = TRIM(age) ,
   country = TRIM(country) ,
`language` = TRIM(language) ,
primary_skill = TRIM(primary_skill),
years_of_experience =TRIM(years_of_experience),
`hourly_rate (USD)` = TRIM(`hourly_rate (USD)`),
rating = TRIM(rating) ,
is_active = TRIM(is_active),
client_satisfaction= TRIM(client_satisfaction) ;

SELECT * FROM global_freelancers_raw ;

-- FIXING GANDERS VALUES 

UPDATE global_freelancers_raw 
SET gender = 'Male'
where gender = 'm' ;


UPDATE global_freelancers_raw 
SET gender = 'Female'
where gender = 'FEMALE' ;

select distinct gender from global_freelancers_raw ;

SELECT * FROM global_freelancers_raw ;

-- FIXING ACTIVE COLUMN --

SELECT DISTINCT is_active FROM
global_freelancers_raw ;

SELECT
    is_active,
    CASE
        WHEN LOWER(TRIM(is_active)) LIKE '%n%' THEN 'No'
        WHEN LOWER(TRIM(is_active)) LIKE '%0%' THEN 'No'
        WHEN LOWER(TRIM(is_active)) LIKE '%false%' THEN 'No'
        
        WHEN LOWER(TRIM(is_active)) LIKE '%y%' THEN 'Yes'
        WHEN LOWER(TRIM(is_active)) LIKE '%1%' THEN 'Yes'
        WHEN LOWER(TRIM(is_active)) LIKE '%true%' THEN 'Yes'
	
        ELSE is_active
    END AS Standardized_IsActive
FROM  global_freelancers_raw;


-- UPDATING IS_ACTIVE COLUMN -- 


UPDATE global_freelancers_raw
SET is_active = CASE
    WHEN LOWER(TRIM(is_active)) LIKE '%n%' THEN 'No'
    WHEN LOWER(TRIM(is_active)) LIKE '%0%' THEN 'No'
    WHEN LOWER(TRIM(is_active)) LIKE '%false%' THEN 'No'
    
    WHEN LOWER(TRIM(is_active)) LIKE '%y%' THEN 'Yes'
    WHEN LOWER(TRIM(is_active)) LIKE '%1%' THEN 'Yes'
    WHEN LOWER(TRIM(is_active)) LIKE '%true%' THEN 'Yes'
    
    ELSE is_active 
END;

SELECT * FROM global_freelancers_raw ;

SELECT * FROM global_freelancers_raw
WHERE `hourly_rate (USD)` IS NULL  AND rating IS NULL ;

UPDATE global_freelancers_raw
SET client_satisfaction = REPLACE(TRIM(client_satisfaction), '%' , '');
 
 ALTER TABLE global_freelancers_raw 
 MODIFY COLUMN client_satisfaction DOUBLE ;

ALTER TABLE global_freelancers_raw 
 MODIFY COLUMN freelancer_ID  VARCHAR(25) ;

UPDATE global_freelancers_raw 
SET is_active  = "Unknown"
WHERE  is_active  IS NULL  ;

-- LEST FIX NULL VALUES IN hourly_rate (USD) AND client_satisfaction  , BY FILLING  THEIR AVG'S --

SELECT  ROUND( AVG(`hourly_rate (USD)`) ,2)FROM global_freelancers_raw 
WHERE `hourly_rate (USD)` IS NOT NULL ;

-- AVG  52.49

SELECT  ROUND( AVG(client_satisfaction) ,2)
FROM global_freelancers_raw 
WHERE  client_satisfaction IS NOT NULL ;
-- AVGH 79.35 

UPDATE  global_freelancers_raw 
SET client_satisfaction = 79.35 
WHERE  client_satisfaction  IS NULL ;

UPDATE  global_freelancers_raw 
SET `hourly_rate (USD)`  = 52.49
WHERE  `hourly_rate (USD)`  IS NULL ;


SELECT  * FROM global_freelancers_raw ;


DESCRIBE global_freelancers_raw ;

ALTER TABLE global_freelancers_raw 
MODIFY COLUMN rating int ;

-- DATA CLEANING  IS COMPLETED -- 

-- LETS EXPLORE THE DATA -- 
 
 -- 1. FINDING MIN,MAX,AVG OF  AGE , STDDEV AGE    AND EXPIREICES AS WELL --
  
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


-- output --
--  Metric , Non_Null_Count,  Min_Age,     Max_Age,    Avg_Age,    StdDev_Age
-- Age   	    922	          20	        60	       40.582       11.964
-- Experience	922	   	 	   0            41         11.483        9.752



 -- tranfering data into new table  , cleaned data  --
CREATE TABLE  Freelancers_data
like  global_freelancers_raw ; 


INSERT Freelancers_data
SELECT * 
FROM global_freelancers_raw ; 


drop table global_freelancers_raw ;

select * from freelancers_data ;

-- so i can show you the diferrence between raw_data and cleand data  -- 

-- 2.HOW MANY freelancer'S ARE THEIR BY COUNTRY / FIND WHICH COUNTRY HAS MORE FREELANCER'S --

SELECT COUNT(freelancer_ID) TOTAL_freelancers , country
FROM  freelancers_data 
GROUP BY country 
ORDER BY TOTAL_freelancers desc 
LIMIT 3 
;

-- TOTAL_freelancers ,    country
--    63	            South Korea
--    63          	    Canada
--    51             	Australia
 

 /* 1.HOW MANY freelancer'S ARE THEIR BY COUNTRY / FIND WHICH COUNTRY HAS MORE FREELANCER'S --
 
 2.Select all the columns for freelancers who are active and have a rating of 5.

3.Find the names and primary skills of all freelancers whose hourly rate is between 40 and 60 USD (inclusive).

4.List the unique countries represented in the table.

5.Retrieve the ID, name, and age of freelancers who have 'Data' in their primary skill (case-insensitive search).

6.Calculate the average hourly rate for all freelancers.

7 Find the total number of freelancers from each country, only listing countries with more than 10 freelancers.

8 Determine the highest and lowest years of experience among all active female freelancers.

9 Calculate the average rating and average hourly rate for each primary skill.

10 List the top 5 highest-paid freelancers, showing their name, skill, and hourly rate.

11.Find the oldest freelancer for each country, showing the country and the maximum age.

 12 Identify the freelancers whose client satisfaction is above the overall average client satisfaction.

13 Count how many freelancers are considered 'Beginner' (years of experience <2), 'Intermediate' (2≤ experience ≤5), and 'Expert' (experience >5).
 
 14 Find the name, hourly rate, and years of experience for freelancers who charge over $80/hour but have less than 3 years of experience.

15 .List the freelancer ID and client satisfaction score for anyone whose score is more than 1 standard deviation below the overall average.

16 Show the count of freelancers categorized by both gender and is_active status (Active Count and Inactive Count per Gender).

17 .Identify the top 5 primary skills based on the highest average rating.

18.Calculate the median age of all freelancers in the table.

19 Compare the average hourly rate for active freelancers versus inactive freelancers.

20 Find the freelancer ID, age, and years of experience for any freelancer whose age is less than their years of experience (data quality check).

21 Identify the language that is spoken by the highest number of freelancers who also have a rating of 4 or above.

22 .Calculate the percentage of freelancers in each country that have a client satisfaction score of 4.0 or higher.

23.List the name of the youngest freelancer (lowest age) who is also in the top 10% of the highest earners (based on hourly rate).

*/  




-- 1.HOW MANY freelancer'S ARE THEIR BY COUNTRY / FIND WHICH COUNTRY HAS MORE FREELANCER'S --

SELECT COUNT(freelancer_ID) TOTAL_freelancers , country
FROM  freelancers_data 
GROUP BY country 
ORDER BY TOTAL_freelancers desc 
LIMIT 10 
;


 -- 2.Select all the columns for freelancers who are active and have a rating of 5.
SELECT  * 
FROM 
freelancers_data 
WHERE is_active IN('YES') AND rating = 5 ;


-- 3.Find the names and primary skills of all freelancers whose hourly rate is between 40 and 60 USD (inclusive).

SELECT `name` , primary_skill ,`hourly_rate (USD)`
FROM freelancers_data 
WHERE `hourly_rate (USD)` BETWEEN 40 AND 60 
 ;                                                       -- WE WANT INCLUDE 40 AND 60 >>>> BETWEEN 39 AND 61 


-- 4.List the unique countries represented in the table.

SELECT DISTINCT country 
FROM freelancers_data 
ORDER BY  country ;

SELECT COUNT(DISTINCT country) AS total_countries 
FROM freelancers_data ;

-- 5.Retrieve the ID, name, and age of freelancers who have 'Data' in their primary skill (case-insensitive search).

SELECT freelancer_ID, `name` ,age , primary_skill
FROM
freelancers_data 
WHERE primary_skill  LIKE '%Data%' ;

-- 6.Calculate the average hourly rate for all freelancers.

SELECT AVG(`hourly_rate (USD)`) AS AVG_chargeperhour FROM 
freelancers_data  
where `hourly_rate (USD)` IS NOT NULL ;

-- 7 Find the total number of freelancers from each country, only listing countries with more than 10 freelancers.

SELECT COUNT(freelancer_ID) AS NUMOFfreelancerS , 
country 
 FROM freelancers_data
 GROUP BY country 
 HAVING  COUNT(freelancer_ID) > 10 ;

-- 8 Determine the highest and lowest years of experience among all active female freelancers. --

SELECT * FROM freelancers_data ;

SELECT MAX(years_of_experience) AS  highest_Yearsof_ex_female ,
MIN( years_of_experience) AS  Lowset_Yearsof_ex_female
FROM freelancers_data 
WHERE gender = 'Female' AND is_active = 'Yes' ;

-- 9  Calculate the average rating and average hourly rate for each primary skill. -- 
 
SELECT AVG(rating) AS AVG_Rating, 
AVG(`hourly_rate (USD)`) avg_hourlyrate ,
primary_skill
FROM freelancers_data  
GROUP BY primary_skill 
ORDER BY avg_hourlyrate  DESC ;

-- 10 List the top 5 highest-paid freelancers, showing their name, skill, and hourly rate.

SELECT name, primary_skill,`hourly_rate (USD)`
 FROM freelancers_data 
ORDER BY `hourly_rate (USD)` DESC 
LIMIT 5 ;

-- 11.Find the oldest freelancer for each country, showing the country and the maximum age. --

SELECT MAX(age) AS Oldest_freelancer ,
country 
 FROM freelancers_data 
 group by  country 
 order by MAX(age) desc ;

-- 12 Identify the freelancers whose client satisfaction is above the overall average client satisfaction. \

SELECT freelancer_ID, name,
 client_satisfaction
FROM freelancers_data
WHERE client_satisfaction > (SELECT AVG(client_satisfaction)FROM freelancers_data);

-- 13 Count how many freelancers are considered 'Beginner' (years of experience <2), 'Intermediate' (2≤ experience ≤5), and 'Expert' (experience >5). */

SELECT
    CASE
        WHEN years_of_experience < 2 THEN 'Beginner'
        WHEN years_of_experience BETWEEN 2 AND 5 THEN 'Intermediate'
        WHEN years_of_experience > 5 THEN 'Expert'
        ELSE 'Undefined'
    END AS Experience_Level ,
    COUNT(*) AS Total_Count
FROM freelancers_data
GROUP BY Experience_Level ;

-- 14 Find the name, hourly rate, and years of experience for freelancers who charge over $50/hour but have less than 3 years of experience.

SELECT name , `hourly_rate (USD)` , years_of_experience 
 FROM  
freelancers_data 
WHERE `hourly_rate (USD)` = 50   AND years_of_experience < 3 ;

-- 15 .List the freelancer ID and client satisfaction score for anyone whose score is more than 1 standard deviation below the overall average.

--  1 standard deviation below the overall average. e:i : AVG()-STDDEV()

SELECT freelancer_ID , client_satisfaction
FROM freelancers_data 
WHERE client_satisfaction > (SELECT AVG(client_satisfaction) - STDDEV(client_satisfaction)  FROM freelancers_data )      
 AND client_satisfaction IS NOT NULL ;

 -- 16 Show the count of freelancers categorized by both gender and is_active status (Active Count and Inactive Count per Gender).

SELECT COUNT(*) AS numoffreelancers , gender , is_active
FROM freelancers_data 
GROUP BY gender , is_active 
ORDER BY  numoffreelancers DESC ;


-- 17 .Identify the top 5 primary skills based on the highest average rating. --

SELECT primary_skill , AVG(rating) AS avg_rating
 FROM freelancers_data 
 WHERE rating IS NOT NULL 
 GROUP BY primary_skill 
 ORDER BY  AVG(rating) DESC 
 LIMIT 5 ;

-- 18.Calculate the median age of all freelancers in the table.

SELECT AVG(age) AS Median_age 
FROM ( SELECT age ,
ROW_NUMBER()OVER(ORDER BY age) AS rn ,
count(*) over()  as toatl_count 
 FROM freelancers_data    
 WHERE AGE IS NOT NULL
 ) AS SUBQURY
 WHERE rn IN(FLOOR((toatl_count + 1) / 2) , CEIL((toatl_count +1) / 2)) ;
 

-- 19 Compare the average hourly rate for active freelancers versus inactive freelancers.
 
 SELECT AVG(`hourly_rate (USD)`)  AS avg_hourly_rate , is_active
 FROM freelancers_data 
 WHERE is_active IS NOT NULL 
 GROUP BY is_active 
 ORDER BY is_active DESC ;


-- 20 Find the freelancer ID, age, and years of experience for any freelancer whose age is less than their years of experience (data quality check).

SELECT * FROM 
freelancers_data 
WHERE age < years_of_experience
 ;
 -- 21 Identify the language that is spoken by the highest number of freelancers who also have a rating of 4 or above.

SELECT * FROM freelancers_data ;

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
 
 -- 22 .Calculate the percentage of freelancers in each country that have a client satisfaction score of 9.0 or higher.
 
 SELECT * FROM freelancers_data ;
 
 SELECT country,
    ROUND( (SUM(CASE WHEN client_satisfaction >= 9.0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS percentage_high_satisfaction
FROM freelancers_data
-- WHERE LOWER(is_active) = 'yes'
GROUP BY country
ORDER BY percentage_high_satisfaction DESC ;

   -- 23.List the name of the youngest freelancer (lowest age) who is also in the top 20% of the highest earners (based on hourly rate).
 
WITH CTE  AS 
( SELECT name, age, `hourly_rate (USD)`,
  PERCENT_RANK() OVER (ORDER BY `hourly_rate (USD)`) AS rate_percentile
   FROM freelancers_data
 )
  SELECT name, age, `hourly_rate (USD)`
FROM CTE
WHERE rate_percentile >= 0.8
ORDER BY age ASC
LIMIT 1 ;




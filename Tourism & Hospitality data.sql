CREATE DATABASE tourism_hospitality;
USE tourism_hospitality;
CREATE TABLE tourism_stats (
    Record_ID INT PRIMARY KEY,
    Country VARCHAR(100),
    City VARCHAR(100),
    Year INT,
    Month INT,
    Number_of_Tourists INT,
    Purpose_of_Visit VARCHAR(50),
    Average_Length_of_Stay DECIMAL(5,2),
    Tourist_Spending_USD DECIMAL(15,2),
    Tourism_Revenue_USD DECIMAL(15,2),
    Employment_in_Tourism INT,
    Contribution_to_GDP_Percent DECIMAL(5,2),
    Tourist_Satisfaction_Score DECIMAL(3,1),
    Number_of_Online_Reviews INT
);

CREATE TABLE hospitality_stats (
    Record_ID INT PRIMARY KEY,
    Country VARCHAR(100),
    City VARCHAR(100),
    Year INT,
    Month INT,
    Hotel_Occupancy_Rate DECIMAL(5,2),
    Number_of_Hotels INT,
    Hotel_Rating VARCHAR(20),
    Average_Room_Price_USD DECIMAL(10,2),
    Number_of_Flights INT,
    Airport_Passenger_Traffic INT,
    Transport_Infrastructure_Quality DECIMAL(3,1),
    Eco_Tourism_Revenue_USD DECIMAL(15,2),
    Carbon_Footprint_kg DECIMAL(15,2),
    Waste_Management_Rating DECIMAL(3,1),
    FOREIGN KEY (Record_ID) REFERENCES tourism_stats(Record_ID)
);
SELECT * FROM tourism_stats
WHERE Country = 'India';






SELECT * FROM hospitality_stats LIMIT 10;
SELECT t.City, t.Country, t.Number_of_Tourists, h.Hotel_Occupancy_Rate
FROM tourism_stats t
JOIN hospitality_stats h ON t.Record_ID = h.Record_ID
LIMIT 10;

SELECT City, Number_of_Tourists
FROM tourism_stats
ORDER BY Number_of_Tourists DESC
LIMIT 5;

SELECT SUM(Tourism_Revenue_USD) 
AS Total_Revenue
FROM tourism_stats;

SELECT Country, 
AVG(Tourist_Satisfaction_Score) 
AS Avg_Satisfaction
FROM tourism_stats
GROUP BY Country
HAVING AVG(Tourist_Satisfaction_Score) > 8;

SELECT City, 
Tourism_Revenue_USD
FROM tourism_stats
ORDER BY Tourism_Revenue_USD DESC
LIMIT 3;

SELECT City,
  CASE
    WHEN Number_of_Tourists > 150000 THEN 'High'
    WHEN Number_of_Tourists >= 80000 THEN 'Medium'
    ELSE 'Low'
  END AS Tourist_Volume
FROM tourism_stats;

SELECT t.City, t.Number_of_Tourists, h.Hotel_Occupancy_Rate
FROM tourism_stats t
JOIN hospitality_stats h ON t.Record_ID = h.Record_ID;


-- LEFT JOIN
SELECT t.Record_ID, h.Record_ID
FROM tourism_stats t
LEFT JOIN hospitality_stats h ON t.Record_ID = h.Record_ID
WHERE h.Record_ID IS NULL;

-- SELF JOIN
SELECT a.City AS City_A, b.City AS City_B, a.Country
FROM tourism_stats a
JOIN tourism_stats b ON a.Country = b.Country AND a.City <> b.City;

SELECT City, Tourism_Revenue_USD
FROM tourism_stats
WHERE Tourism_Revenue_USD > (SELECT AVG(Tourism_Revenue_USD) 
FROM tourism_stats);

WITH RankedRevenue AS (
  SELECT Country, City, Tourism_Revenue_USD,
         RANK() OVER (PARTITION BY Country ORDER BY Tourism_Revenue_USD DESC) AS rnk
  FROM tourism_stats
)
SELECT Country, City, Tourism_Revenue_USD
FROM RankedRevenue
WHERE rnk = 1;

SELECT City, Country, Tourism_Revenue_USD,
       RANK() OVER (PARTITION BY Country ORDER BY Tourism_Revenue_USD DESC) AS Revenue_Rank
FROM tourism_stats;



SELECT City, Country, Number_of_Tourists, 'Top by Tourists' AS Metric
FROM tourism_stats
ORDER BY Number_of_Tourists DESC
LIMIT 5

UNION

SELECT City, Country, Number_of_Tourists, 'Top by Revenue' AS Metric
FROM tourism_stats
ORDER BY Tourism_Revenue_USD DESC
LIMIT 5;

(SELECT City, Country, Number_of_Tourists, 'Top by Tourists' AS Metric
 FROM tourism_stats
 ORDER BY Number_of_Tourists DESC
 LIMIT 5)

UNION

(SELECT City, Country, Number_of_Tourists, 'Top by Revenue' AS Metric
 FROM tourism_stats
 ORDER BY Tourism_Revenue_USD DESC
 LIMIT 5);

CREATE VIEW top_cities_view AS




SELECT City, Country, Tourism_Revenue_USD
FROM tourism_stats
WHERE Tourism_Revenue_USD > (SELECT AVG(Tourism_Revenue_USD) FROM tourism_stats);

SELECT * FROM top_cities_view LIMIT 5;





SELECT COUNT(*) AS total_records 
FROM tourism_stats;


CREATE TABLE tourism_stats (
    Record_ID INT PRIMARY KEY,
    Country VARCHAR(100),
    City VARCHAR(100),
    Year INT,
    Month INT,
    Number_of_Tourists INT,
    Purpose_of_Visit VARCHAR(100),
    Average_Length_of_Stay DECIMAL(5,2),
    Tourist_Spending_USD DECIMAL(12,2),
    Tourism_Revenue_USD DECIMAL(12,2),
    Employment_in_Tourism INT,
    Contribution_to_GDP_Percent DECIMAL(5,2),
    Tourist_Satisfaction_Score DECIMAL(3,2),
    Number_of_Online_Reviews INT
);
CREATE DATABASE tourism_hospitality;
USE tourism_hospitality;

CREATE TABLE tourism_stats (
    Record_ID INT PRIMARY KEY,
    Country VARCHAR(100),
    City VARCHAR(100),
    Year INT,
    Month INT,
    Number_of_Tourists INT,
    Purpose_of_Visit VARCHAR(50),
    Average_Length_of_Stay DECIMAL(5,2),
    Tourist_Spending_USD DECIMAL(15,2),
    Tourism_Revenue_USD DECIMAL(15,2),
    Employment_in_Tourism INT,
    Contribution_to_GDP_Percent DECIMAL(5,2),
    Tourist_Satisfaction_Score DECIMAL(3,1),
    Number_of_Online_Reviews INT
);

CREATE TABLE hospitality_stats (
    Record_ID INT PRIMARY KEY,
    Country VARCHAR(100),
    City VARCHAR(100),
    Year INT,
    Month INT,
    Hotel_Occupancy_Rate DECIMAL(5,2),
    Number_of_Hotels INT,
    Hotel_Rating VARCHAR(20),
    Average_Room_Price_USD DECIMAL(10,2),
    Number_of_Flights INT,
    Airport_Passenger_Traffic INT,
    Transport_Infrastructure_Quality DECIMAL(3,1),
    Eco_Tourism_Revenue_USD DECIMAL(15,2),
    Carbon_Footprint_kg DECIMAL(15,2),
    Waste_Management_Rating DECIMAL(3,1),
    FOREIGN KEY (Record_ID) REFERENCES tourism_stats(Record_ID)
);

SELECT COUNT(*) AS total_records 
FROM tourism_stats;

SELECT Record_ID, Country, City, Tourism_Revenue_USD 
FROM tourism_stats 
WHERE Country = 'India';

SELECT DISTINCT Purpose_of_Visit 
FROM tourism_stats;

SELECT City, SUM(Number_of_Tourists) AS Total_Tourists 
FROM tourism_stats 
GROUP BY City 
ORDER BY Total_Tourists DESC 
LIMIT 5;

SELECT City, AVG(Average_Room_Price_USD) AS Avg_Price 
FROM hospitality_stats 
GROUP BY City 
ORDER BY Avg_Price DESC 
LIMIT 1;

SELECT Record_ID, City, Tourism_Revenue_USD 
FROM tourism_stats 
WHERE Tourism_Revenue_USD BETWEEN 200000 AND 400000;

SELECT SUM(Tourism_Revenue_USD) AS Total_Revenue 
FROM tourism_stats;

SELECT Country, SUM(Number_of_Tourists) AS Total_Tourists 
FROM tourism_stats 
GROUP BY Country 
ORDER BY Total_Tourists DESC 
LIMIT 5;

SELECT Purpose_of_Visit, 
       AVG(Tourist_Spending_USD) AS Avg_Spending 
FROM tourism_stats 
GROUP BY Purpose_of_Visit 
ORDER BY Avg_Spending DESC;


SELECT Year, AVG(Hotel_Occupancy_Rate) AS Avg_Occupancy 
FROM hospitality_stats 
GROUP BY Year 
ORDER BY Year ASC;

SELECT Country, 
       AVG(Tourist_Satisfaction_Score) AS Avg_Satisfaction 
FROM tourism_stats 
GROUP BY Country 
HAVING AVG(Tourist_Satisfaction_Score) > 8.0;

SELECT City, SUM(Tourism_Revenue_USD) AS Total_Revenue 
FROM tourism_stats 
GROUP BY City 
ORDER BY Total_Revenue DESC 
LIMIT 3;


SELECT City, SUM(Number_of_Tourists) AS Total_Tourists,
  CASE 
    WHEN SUM(Number_of_Tourists) >= 1500000 THEN 'High'
    WHEN SUM(Number_of_Tourists) BETWEEN 1000000 AND 1499999 THEN 'Medium'
    ELSE 'Low'
  END AS Volume_Category
FROM tourism_stats
GROUP BY City LIMIT 5;


SELECT City, SUM(Eco_Tourism_Revenue_USD) AS Total_Eco_Rev,
  CASE 
    WHEN SUM(Eco_Tourism_Revenue_USD) > 500000 THEN 'Eco-Friendly'
    ELSE 'Standard'
  END AS Eco_Status
FROM hospitality_stats
GROUP BY City 
order by City ASC LIMIT 5; 

SELECT t.Record_ID, t.City, t.Tourism_Revenue_USD, 
       h.Hotel_Occupancy_Rate, h.Average_Room_Price_USD
FROM tourism_stats t
INNER JOIN hospitality_stats h 
  ON t.Record_ID = h.Record_ID
LIMIT 5;


SELECT t.Record_ID, t.City 
FROM tourism_stats t
LEFT JOIN hospitality_stats h 
  ON t.Record_ID = h.Record_ID
WHERE h.Record_ID IS NULL;


SELECT t.Record_ID, t.City 
FROM tourism_stats t
LEFT JOIN hospitality_stats h 
  ON t.Record_ID = h.Record_ID
WHERE h.Record_ID IS NULL;


SELECT DISTINCT t1.Country, t1.City AS City_1, t2.City AS City_2
FROM tourism_stats t1
INNER JOIN tourism_stats t2 
  ON t1.Country = t2.Country AND t1.City < t2.City
ORDER BY t1.Country LIMIT 5;


SELECT t.Purpose_of_Visit, h.Hotel_Rating, 
       COUNT(*) AS Total_Hotels_Logged
FROM tourism_stats t
INNER JOIN hospitality_stats h ON t.Record_ID = h.Record_ID
WHERE t.Purpose_of_Visit = 'Business'
GROUP  BY t.Purpose_of_Visit, h.Hotel_Rating;



SELECT City, SUM(Tourism_Revenue_USD) AS Total_Revenue
FROM tourism_stats
GROUP BY City
HAVING SUM(Tourism_Revenue_USD) > (
  SELECT AVG(Tourism_Revenue_USD) FROM tourism_stats
)
ORDER BY Total_Revenue DESC
LIMIT 5;



WITH CityRevenue AS (
  SELECT Country, City, SUM(Tourism_Revenue_USD) AS Revenue
  FROM tourism_stats
  GROUP BY Country, City
),
RankedCities AS (
  SELECT Country, City, Revenue,
         RANK() OVER (PARTITION BY Country ORDER BY Revenue DESC) AS rnk
  FROM CityRevenue
)
SELECT Country, City, Revenue
FROM RankedCities
WHERE rnk = 1
ORDER BY Country ASC
LIMIT 5;

SELECT DISTINCT Country 
FROM hospitality_stats h
WHERE EXISTS (
  SELECT 1 FROM hospitality_stats h2 
  WHERE h2.Country = h.Country AND h2.Hotel_Rating = '5-star'
) LIMIT 5;

WITH CityRev AS (
  SELECT Country, City, SUM(Tourism_Revenue_USD) AS Total_Rev
  FROM tourism_stats GROUP BY Country, City
),
Ranked AS (
  SELECT Country, City, Total_Rev,
         RANK() OVER (PARTITION BY Country ORDER BY Total_Rev DESC) as rnk
  FROM CityRev
)
SELECT Country, City, Total_Rev FROM Ranked WHERE rnk = 1 LIMIT 5;

SELECT Country, City, SUM(Tourism_Revenue_USD) AS Revenue,
       RANK() OVER (PARTITION BY Country ORDER BY SUM(Tourism_Revenue_USD) DESC) AS Rev_Rank
FROM tourism_stats
GROUP BY Country, City LIMIT 5;

WITH MonthlyData AS (
  SELECT City, Year, Month, SUM(Number_of_Tourists) AS Tourists,
         ROW_NUMBER() OVER (PARTITION BY City ORDER BY SUM(Number_of_Tourists) DESC) AS rn
  FROM tourism_stats GROUP BY City, Year, Month
)
SELECT City, Year, Month, Tourists FROM MonthlyData WHERE rn = 1 LIMIT 5;


SELECT City, Year, Month, SUM(Number_of_Tourists) AS Tourists,
       LAG(SUM(Number_of_Tourists)) OVER (
         PARTITION BY City ORDER BY Year, Month
       ) AS Prev_Month_Tourists
FROM tourism_stats
GROUP BY City, Year, Month LIMIT 5;

SELECT Country, City, SUM(Tourism_Revenue_USD) AS City_Revenue,
       SUM(SUM(Tourism_Revenue_USD)) OVER (
         PARTITION BY Country
       ) AS Cumulative_Country_Revenue
FROM tourism_stats
GROUP BY Country, City LIMIT 5;

SELECT Country, City, SUM(Tourism_Revenue_USD) AS City_Rev,
       ROUND(100.0 * SUM(Tourism_Revenue_USD) / 
         SUM(SUM(Tourism_Revenue_USD)) OVER (PARTITION BY Country), 2) AS Rev_Pct
FROM tourism_stats
GROUP BY Country, City LIMIT 5;



SELECT City, 'Top Tourists' AS Criteria FROM (
  SELECT City FROM tourism_stats GROUP BY City ORDER BY SUM(Number_of_Tourists) DESC LIMIT 5
) AS t1
UNION
SELECT City, 'Top Revenue' AS Criteria FROM (
  SELECT City FROM tourism_stats GROUP BY City ORDER BY SUM(Tourism_Revenue_USD) DESC LIMIT 5
) AS t2;

SELECT DISTINCT UPPER(CONCAT(City, ', ', Country)) AS City_Country_Label 
FROM tourism_stats 
ORDER BY City_Country_Label 
LIMIT 5;

SELECT 
  CASE 
    WHEN Month IN (1,2,3) THEN 'Q1'
    WHEN Month IN (4,5,6) THEN 'Q2'
    WHEN Month IN (7,8,9) THEN 'Q3'
    ELSE 'Q4'
  END AS Quarter, 
  SUM(Number_of_Tourists) AS Total_Tourists
FROM tourism_stats
GROUP BY Quarter ORDER BY Quarter;



SHOW DATABASES;
USE your_database_name;

-- Verify tourism_stats exists
SHOW TABLES LIKE 'tourism_stats';
CREATE OR REPLACE VIEW top_cities_view AS 
SELECT City, Country, SUM(Tourism_Revenue_USD) AS Total_Revenue 
FROM tourism_stats 
GROUP BY City, Country 
ORDER BY Total_Revenue DESC;
SELECT * FROM top_cities_view LIMIT 3;


CREATE INDEX idx_country_city 
ON tourism_stats(Country, City);

-- Query execution path uses index scan:
SELECT * FROM tourism_stats 
WHERE Country = 'India' AND City = 'Mumbai';
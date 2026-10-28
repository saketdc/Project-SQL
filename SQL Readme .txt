# 🌍 Tourism & Hospitality Data Analysis Using SQL

A MySQL project that analyzes global tourism and hospitality data across two related tables. It demonstrates core and advanced SQL concepts, from basic filtering to window functions, through practical, business-focused queries on tourist volume, revenue, hotel pricing, occupancy, satisfaction, and eco-tourism.

---

## 📌 Project Overview

The project answers real-world tourism questions using SQL, such as:

- Which cities and countries attract the most tourists?
- Which destinations generate the highest revenue?
- How much do travelers spend based on their purpose of visit?
- Which city has the highest average hotel room price?
- How does hotel occupancy change over the years?
- Which cities qualify as eco-tourism hubs?
- What are the peak travel months and quarters?

---

## 📂 Repository Contents

| File | Description |
|------|-------------|
| `Tourism & Hospitality data.sql` | Database schema and all SQL queries |
| `Final_Project_SQL_Concepts_in_Action_Tourism_Hospitality.pptx` | Presentation with each query, its output, and key takeaway |
| `README.md` | Project documentation |

---

## 🗃️ Database Schema

**Database:** `tourism_hospitality`

### `tourism_stats`

| Column | Type | Description |
|--------|------|-------------|
| `Record_ID` | INT (PK) | Unique record identifier |
| `Country`, `City` | VARCHAR | Destination location |
| `Year`, `Month` | INT | Time period |
| `Number_of_Tourists` | INT | Visitor count |
| `Purpose_of_Visit` | VARCHAR | Business, leisure, cultural, medical, etc. |
| `Average_Length_of_Stay` | DECIMAL | Average stay duration |
| `Tourist_Spending_USD` | DECIMAL | Spending per tourist |
| `Tourism_Revenue_USD` | DECIMAL | Total tourism revenue |
| `Employment_in_Tourism` | INT | Tourism-related jobs |
| `Contribution_to_GDP_Percent` | DECIMAL | Share of GDP |
| `Tourist_Satisfaction_Score` | DECIMAL | Satisfaction rating |
| `Number_of_Online_Reviews` | INT | Review count |

### `hospitality_stats`

| Column | Type | Description |
|--------|------|-------------|
| `Record_ID` | INT (FK) | Links to `tourism_stats.Record_ID` |
| `Country`, `City` | VARCHAR | Location |
| `Year`, `Month` | INT | Time period |
| `Hotel_Occupancy_Rate` | DECIMAL | Occupancy percentage |
| `Number_of_Hotels` | INT | Hotels in the area |
| `Hotel_Rating` | VARCHAR | Star rating |
| `Average_Room_Price_USD` | DECIMAL | Average room rate |
| `Number_of_Flights` | INT | Flight count |
| `Airport_Passenger_Traffic` | INT | Airport passengers |
| `Transport_Infrastructure_Quality` | DECIMAL | Infrastructure score |
| `Eco_Tourism_Revenue_USD` | DECIMAL | Eco-tourism revenue |
| `Carbon_Footprint_kg` | DECIMAL | Carbon footprint |
| `Waste_Management_Rating` | DECIMAL | Waste management score |

**Relationship:** `hospitality_stats.Record_ID` → `tourism_stats.Record_ID` (one-to-one foreign key)

---

## 🧠 SQL Concepts Covered

| Category | Concepts |
|----------|----------|
| **Basic Retrieval** | `COUNT(*)`, `WHERE`, `DISTINCT`, `ORDER BY` + `LIMIT`, `BETWEEN` |
| **Aggregation & Grouping** | `SUM()`, `AVG()`, `GROUP BY`, `HAVING` |
| **Conditional Logic** | `CASE WHEN` for tourist volume tiers and eco-tourism flags |
| **Joins** | `INNER JOIN`, `LEFT JOIN` with `IS NULL`, `SELF JOIN`, multi-table aggregation |
| **Subqueries & CTEs** | Scalar subquery, correlated subquery, `WITH` clause, `EXISTS` |
| **Window Functions** | `RANK()`, `ROW_NUMBER()`, `LAG()`, `SUM() OVER()`, percentage contribution |
| **Set, String & Date** | `UNION`, `UPPER()`, `CONCAT()`, quarterly bucketing |
| **Database Objects** | Views (`CREATE VIEW`) and indexes (`CREATE INDEX`) |

---

## 🔍 Sample Queries

**Top 5 cities by tourist volume**
```sql
SELECT City, SUM(Number_of_Tourists) AS Total_Tourists
FROM tourism_stats
GROUP BY City
ORDER BY Total_Tourists DESC
LIMIT 5;
```

**Highest revenue city in each country (CTE + window function)**
```sql
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
WHERE rnk = 1;
```

**Month-over-month tourist change (LAG)**
```sql
SELECT City, Year, Month, SUM(Number_of_Tourists) AS Tourists,
       LAG(SUM(Number_of_Tourists)) OVER (
         PARTITION BY City ORDER BY Year, Month
       ) AS Prev_Month_Tourists
FROM tourism_stats
GROUP BY City, Year, Month;
```

---

## 📊 Key Insights

- **Visitor volume:** Johannesburg and Luxor lead globally, each exceeding 2.3 million tourists.
- **Top destination countries:** China and Italy each attract over 4 million visitors.
- **Highest revenue city:** Luxor leads with $8.31M USD in total revenue.
- **Premium pricing:** Puerto Vallarta has the highest average room rate at $347.11.
- **Spending by purpose:** Business travelers spend the most per trip at $2,922.60.
- **Satisfaction:** Egypt is the only country with an average satisfaction score above 8.0.
- **Hotel occupancy:** Global occupancy stayed stable between 63% and 68%.
- **Seasonality:** Visitor volume peaks in Q1 and Q3 and is lowest in Q4.
- **Eco-tourism:** Antalya, Athens, and Bangkok exceed $500K in eco-revenue.
- **Data integrity:** All `tourism_stats` records have a matching `hospitality_stats` record.

---

## 🚀 How to Run

1. Install **MySQL** (8.0 or later is required for window functions and CTEs) and a client such as MySQL Workbench.
2. Run the schema section of `Tourism & Hospitality data.sql` to create the database and tables.
3. Import your CSV data into the tables, for example:
   ```sql
   LOAD DATA INFILE 'FILE.CSV' INTO TABLE tourism_stats
   FIELDS TERMINATED BY ','
   IGNORE 1 LINES;
   ```
4. Run the queries one by one and compare the results with the presentation.

---

## 🛠️ Tools Used

- MySQL
- MySQL Workbench
- Microsoft PowerPoint (for the project presentation)

---

## 👤 Author

**Your Name**
[GitHub](https://github.com/your-username) · [LinkedIn](https://linkedin.com/in/your-profile)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
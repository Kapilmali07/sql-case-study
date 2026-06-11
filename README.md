# 🚗 SQL Case Study Portfolio — Owner-Car & Corporate Employee Schema

> **Author:** Kapil Sanjay Mali  
> **Tool:** MySQL 8.4  
> **Domain:** Relational Database Design · Business Query Solving  
> **Level:** Intermediate SQL

---

## 📌 Project Overview

This project demonstrates hands-on SQL skills through two end-to-end relational database case studies — from schema design and data modelling to writing optimised business queries. Each case study covers real-world scenarios that are commonly tested in Data Analyst interviews.

---

## 📘 Case Study 1 — Owner & Car Database

### Problem Statement
Design a relational database for vehicle ownership. An owner can possess multiple cars (One-to-Many relationship). Solve business queries using JOINs, subqueries, and filters.

### Entity-Relationship Design

```
OWNER                         CAR
─────────────────────         ──────────────────────────
Licence_No  PK  INT           Car_No      PK   INT
Name             VARCHAR       Model            VARCHAR
Address          VARCHAR       Color            VARCHAR
Phone            BIGINT        Licence_No  FK → OWNER
```

### Queries Solved

| # | Business Question | SQL Concepts Used |
|---|-------------------|-------------------|
| Q1 | Find owners of 'Zen' and 'Indica' cars | INNER JOIN, IN, DISTINCT |
| Q2 | Insert a new car record | INSERT INTO |
| Q3 | Models owned by 'Mr. Shah' with color 'Blue' | JOIN + WHERE, Subquery (both approaches) |
| Q4 | All cars registered in Pune | INNER JOIN, WHERE filter |

### Sample Output — Q1 (Owner of Zen & Indica)

| Owner_Name  | Car_Model |
|-------------|-----------|
| Mr. Shah    | Zen       |
| Kapil Mali  | Indica    |

---

## 📗 Case Study 4 — Corporate Employee & Manager Schema

### Problem Statement
Design a multi-table database representing employees, their employers, salaries, city locations, and reporting managers. Answer analytical business queries using aggregation and subqueries.

### Entity-Relationship Design

```
LIVES                    WORKS                    LOCATED_IN
──────────────────       ──────────────────────   ──────────────────
Person_Name  PK          Person_Name  FK → LIVES  Company_Name  PK
Street                   Company_Name             City
City                     Salary

MANAGER
──────────────────
Person_Name  FK → LIVES
Manager_Name
```

### Queries Solved

| # | Business Question | SQL Concepts Used |
|---|-------------------|-------------------|
| Q1 | Employees earning above their company's average salary | Subquery, GROUP BY, AVG, JOIN |
| Q2 | Company with the least number of employees | GROUP BY, COUNT, ORDER BY, LIMIT |
| BONUS 1 | Rank employees by salary within each company | Window Function — RANK() OVER (PARTITION BY) |
| BONUS 2 | Employees living in the same city as company HQ | Multi-table JOIN, column comparison |
| BONUS 3 | Managers handling more than one team member | GROUP BY, HAVING, COUNT |

### Sample Output — Q1 (Above-Average Earners)

| Person_Name | Company_Name | Employee_Salary | Company_Avg_Salary |
|-------------|-------------|----------------|--------------------|
| Neha        | Infosys     | 75,000         | 65,000             |
| Sahil       | Infosys     | 70,000         | 65,000             |
| Meera       | Google      | 1,35,000       | 1,23,600           |
| Yash        | Google      | 1,25,000       | 1,23,600           |

---

## 🛠️ SQL Concepts Demonstrated

| Category | Skills |
|----------|--------|
| **DDL** | CREATE TABLE, PRIMARY KEY, FOREIGN KEY constraints |
| **DML** | INSERT, UPDATE, SELECT |
| **Joins** | INNER JOIN across multiple tables |
| **Filtering** | WHERE, IN, AND |
| **Aggregation** | GROUP BY, COUNT, AVG, ROUND, CEIL |
| **Subqueries** | Correlated subquery, derived table (inline view) |
| **Window Functions** | RANK() OVER (PARTITION BY ... ORDER BY ...) |
| **Sorting & Limiting** | ORDER BY, LIMIT |
| **Best Practices** | Named constraints, consistent aliasing, inline comments |

---

## ▶️ How to Run

1. Install [MySQL 8.x](https://dev.mysql.com/downloads/mysql/) or use [MySQL Workbench](https://www.mysql.com/products/workbench/)
2. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/sql-case-study.git
   ```
3. Open MySQL Workbench (or your preferred SQL client)
4. Open `Kapil_Mali_SQL_Case_Study.sql`
5. Execute the full script — it will create the database, tables, insert data, and run all queries

---

## 💡 Key Learnings

- Designed normalised relational schemas with proper PK/FK constraints
- Solved above-average salary problem using a **derived table (inline subquery)** — a classic interview question
- Demonstrated **two approaches** for the same query (JOIN vs Subquery) to show flexibility
- Added **Window Function** bonus queries to reflect 2026 industry expectations

---

## 👨‍💻 About the Author

**Kapil Sanjay Mali**
Data Analyst | Python | SQL | Excel | Power BI
LinkedIn: https://www.linkedin.com/in/kapil-mali/
GitHub: https://github.com/Kapilmali07 

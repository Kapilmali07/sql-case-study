-- ============================================================
-- SQL CASE STUDY PORTFOLIO
-- Author  : Kapil Sanjay Mali
-- Tool    : MySQL 8.4
-- Purpose : Relational Database Design + Business Query Solving
-- GitHub  : github.com/KapilMali  [update with your handle]
-- ============================================================

CREATE DATABASE IF NOT EXISTS SQL_CASE_STUDY;
USE SQL_CASE_STUDY;

-- ============================================================
-- CASE STUDY 1 : Owner–Car Relationship
-- ============================================================
/*
  ENTITIES & RELATIONSHIPS
  ─────────────────────────
  Owner(Licence_No PK, Name, Address, Phone)
  Car(Car_No, Model, Color, Licence_No FK → Owner)
  Relationship: One Owner → Many Cars (1:N)

  BUSINESS QUESTIONS SOLVED
  ──────────────────────────
  Q1. Find the name of owner of 'Zen' and 'Indica' cars.
  Q2. Insert a new record in the Car relation.
  Q3. List all models owned by 'Mr. Shah' with color 'Blue'.
  Q4. List information of all cars registered in Pune.
*/

-- ── DDL ─────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS OWNER (
    Licence_No  INT          PRIMARY KEY,
    Name        VARCHAR(50)  NOT NULL,
    Address     VARCHAR(100) NOT NULL,
    Phone       BIGINT       NOT NULL
);

CREATE TABLE IF NOT EXISTS CAR (
    Car_No      INT          PRIMARY KEY,
    Model       VARCHAR(30)  NOT NULL,
    Color       VARCHAR(20)  NOT NULL,
    Licence_No  INT,
    CONSTRAINT fk_car_owner FOREIGN KEY (Licence_No) REFERENCES OWNER(Licence_No)
);

-- ── SEED DATA ────────────────────────────────────────────────

INSERT INTO OWNER (Licence_No, Name, Address, Phone) VALUES
(201, 'Mr. Shah',      'Pune',    9876500001),
(202, 'Kapil Mali',    'Mumbai',  9876500002),
(203, 'Rahul Sharma',  'Pune',    9876500003),
(204, 'Sneha Patil',   'Delhi',   9876500004),
(205, 'Amit Verma',    'Pune',    9876500005),
(206, 'Priya Singh',   'Nagpur',  9876500006),
(207, 'Ankit Jain',    'Pune',    9876500007),
(208, 'Neha Joshi',    'Mumbai',  9876500008),
(209, 'Rohit Mehta',   'Pune',    9876500009),
(210, 'Vikas Yadav',   'Delhi',   9876500010),
(211, 'Mr. Shah',      'Pune',    9876500011),
(212, 'Kapil Mali',    'Mumbai',  9876500012);

INSERT INTO CAR (Car_No, Model, Color, Licence_No) VALUES
(101, 'Zen',      'White',  201),
(102, 'Indica',   'Silver', 202),
(103, 'Swift',    'Blue',   201),
(104, 'City',     'Black',  203),
(105, 'Creta',    'Blue',   204),
(106, 'Baleno',   'Red',    205),
(107, 'Thar',     'Black',  206),
(108, 'i20',      'Blue',   207),
(109, 'Verna',    'White',  208),
(110, 'Fortuner', 'Grey',   209),
(111, 'Scorpio',  'Blue',   201),
(112, 'Venue',    'Silver', 210),
(113, 'Nexon',    'White',  203),
(114, 'Safari',   'Black',  205),
(115, 'Altroz',   'Blue',   207),
(116, 'Zen',      'Blue',   211),
(117, 'Indica',   'White',  212),
(118, 'Swift',    'Blue',   211);

-- ── QUERIES ──────────────────────────────────────────────────

-- Q1. Find the name of owner of 'Zen' and 'Indica' cars.
-- Approach: INNER JOIN + IN filter; DISTINCT avoids duplicate owner names
SELECT DISTINCT
    O.Name   AS Owner_Name,
    C.Model  AS Car_Model
FROM OWNER AS O
INNER JOIN CAR AS C ON O.Licence_No = C.Licence_No
WHERE C.Model IN ('Zen', 'Indica');

-- Q2. Insert a new record in the Car relation.
INSERT INTO CAR (Car_No, Model, Color, Licence_No)
VALUES (119, 'Fortuner', 'White', 210);

-- Verify
SELECT * FROM CAR WHERE Car_No = 119;

-- Q3. List all models owned by 'Mr. Shah' with color 'Blue'.

-- Approach A – JOIN (readable, preferred)
SELECT
    C.Model  AS Car_Model,
    O.Name   AS Owner_Name,
    C.Color  AS Car_Color
FROM OWNER AS O
INNER JOIN CAR AS C ON O.Licence_No = C.Licence_No
WHERE O.Name = 'Mr. Shah'
  AND C.Color = 'Blue';

-- Approach B – Correlated Subquery (alternative technique)
SELECT Model
FROM CAR
WHERE Color = 'Blue'
  AND Licence_No IN (
      SELECT Licence_No
      FROM OWNER
      WHERE Name = 'Mr. Shah'
  );

-- Q4. List information of all cars registered in Pune.
SELECT
    C.Car_No,
    C.Model,
    C.Color,
    O.Name     AS Owner_Name,
    O.Address  AS Owner_City
FROM OWNER AS O
INNER JOIN CAR AS C ON O.Licence_No = C.Licence_No
WHERE O.Address = 'Pune';


-- ============================================================
-- CASE STUDY 2 : Corporate Employee–Manager Schema
-- ============================================================
/*
  ENTITIES & RELATIONSHIPS
  ─────────────────────────
  Lives(Person_Name PK, Street, City)
  Works(Person_Name FK, Company_Name, Salary)
  Located_In(Company_Name PK, City)
  Manager(Person_Name FK, Manager_Name)

  BUSINESS QUESTIONS SOLVED
  ──────────────────────────
  Q1. Find all employees who earn MORE than the average salary
      of ALL employees in their own company.
  Q2. Find the company with the least number of employees.
*/

-- ── DDL ─────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS LIVES (
    Person_Name  VARCHAR(50)  PRIMARY KEY,
    Street       VARCHAR(100) NOT NULL,
    City         VARCHAR(30)  NOT NULL
);

CREATE TABLE IF NOT EXISTS WORKS (
    Person_Name   VARCHAR(50),
    Company_Name  VARCHAR(50)  NOT NULL,
    Salary        BIGINT       NOT NULL,
    CONSTRAINT fk_works_lives FOREIGN KEY (Person_Name) REFERENCES LIVES(Person_Name)
);

CREATE TABLE IF NOT EXISTS LOCATED_IN (
    Company_Name  VARCHAR(50)  PRIMARY KEY,
    City          VARCHAR(50)  NOT NULL
);

CREATE TABLE IF NOT EXISTS MANAGER (
    Person_Name   VARCHAR(50),
    Manager_Name  VARCHAR(50)  NOT NULL,
    CONSTRAINT fk_mgr_lives FOREIGN KEY (Person_Name) REFERENCES LIVES(Person_Name)
);

-- ── SEED DATA ────────────────────────────────────────────────

INSERT INTO LIVES (Person_Name, Street, City) VALUES
('Amit',    'MG Road',          'Pune'),
('Neha',    'FC Road',          'Pune'),
('Rohit',   'Baner Road',       'Pune'),
('Riya',    'MG Road',          'Pune'),
('Sahil',   'Hinjewadi',        'Pune'),
('Sneha',   'JM Road',          'Mumbai'),
('Karan',   'Link Road',        'Mumbai'),
('Pooja',   'Ring Road',        'Delhi'),
('Ajay',    'Powai',            'Mumbai'),
('Tina',    'Borivali',         'Mumbai'),
('Vikas',   'Civil Lines',      'Delhi'),
('Anjali',  'Sector 21',        'Noida'),
('Komal',   'Wakad',            'Pune'),
('Tarun',   'Sector 18',        'Noida'),
('Rahul',   'Park Street',      'Kolkata'),
('Meera',   'Anna Nagar',       'Chennai'),
('Arjun',   'BTM Layout',       'Bangalore'),
('Yash',    'Indiranagar',      'Bangalore'),
('Payal',   'Electronic City',  'Bangalore'),
('Priya',   'Whitefield',       'Bangalore'),
('Nikhil',  'Salt Lake',        'Kolkata'),
('Harsh',   'Howrah',           'Kolkata'),
('Divya',   'T Nagar',          'Chennai'),
('Simran',  'Andheri',          'Mumbai'),
('Varun',   'Camp',             'Pune'),
('Isha',    'Rajouri Garden',   'Delhi'),
('Deepak',  'Karol Bagh',       'Delhi'),
('Manoj',   'Dwarka',           'Delhi'),
('Kriti',   'Rohini',           'Delhi'),
('Naina',   'Malad',            'Mumbai');

INSERT INTO WORKS (Person_Name, Company_Name, Salary) VALUES
('Neha',    'Infosys',    75000),
('Rohit',   'Infosys',    65000),
('Riya',    'Infosys',    50000),
('Sahil',   'Infosys',    70000),
('Sneha',   'TCS',        40000),
('Karan',   'TCS',        45000),
('Pooja',   'TCS',        50000),
('Ajay',    'TCS',        42000),
('Tina',    'TCS',        47000),
('Vikas',   'Wipro',      60000),
('Anjali',  'Wipro',      62000),
('Komal',   'Wipro',      58000),
('Tarun',   'Wipro',      64000),
('Rahul',   'Google',    120000),
('Meera',   'Google',    135000),
('Arjun',   'Google',    110000),
('Yash',    'Google',    125000),
('Payal',   'Google',    128000),
('Priya',   'Amazon',     95000),
('Nikhil',  'Amazon',     85000),
('Harsh',   'Amazon',     90000),
('Divya',   'Amazon',     92000),
('Simran',  'Capgemini',  48000),
('Varun',   'Capgemini',  51000),
('Isha',    'Capgemini',  53000),
('Deepak',  'IBM',        70000),
('Manoj',   'IBM',        72000),
('Kriti',   'IBM',        68000),
('Naina',   'IBM',        71000);

INSERT INTO LOCATED_IN (Company_Name, City) VALUES
('Infosys',    'Pune'),
('TCS',        'Mumbai'),
('Wipro',      'Bangalore'),
('Google',     'Hyderabad'),
('Amazon',     'Bangalore'),
('Capgemini',  'Pune'),
('IBM',        'Delhi');

INSERT INTO MANAGER (Person_Name, Manager_Name) VALUES
('Amit',    'Neha'),
('Neha',    'Rohit'),
('Rohit',   'Neha'),
('Riya',    'Neha'),
('Sahil',   'Rohit'),
('Sneha',   'Karan'),
('Karan',   'Pooja'),
('Pooja',   'Karan'),
('Ajay',    'Pooja'),
('Tina',    'Karan'),
('Vikas',   'Anjali'),
('Anjali',  'Vikas'),
('Komal',   'Anjali'),
('Tarun',   'Vikas'),
('Rahul',   'Meera'),
('Meera',   'Rahul'),
('Arjun',   'Meera'),
('Yash',    'Rahul'),
('Payal',   'Meera'),
('Priya',   'Nikhil'),
('Nikhil',  'Priya'),
('Harsh',   'Priya'),
('Divya',   'Nikhil'),
('Simran',  'Varun'),
('Varun',   'Isha'),
('Isha',    'Varun'),
('Deepak',  'Manoj'),
('Manoj',   'Kriti'),
('Kriti',   'Manoj'),
('Naina',   'Deepak');

-- ── QUERIES ──────────────────────────────────────────────────

-- Q1. Find all employees who earn MORE than the average salary
--     of ALL employees in their own company.
-- Approach: Self-join WORKS with a subquery that computes per-company AVG salary.
--           Then filter where individual salary > that company's average.
SELECT
    W.Person_Name,
    W.Company_Name,
    W.Salary                          AS Employee_Salary,
    ROUND(CA.Avg_Company_Salary, 2)   AS Company_Avg_Salary
FROM WORKS AS W
INNER JOIN (
    SELECT
        Company_Name,
        AVG(Salary) AS Avg_Company_Salary
    FROM WORKS
    GROUP BY Company_Name
) AS CA ON W.Company_Name = CA.Company_Name
WHERE W.Salary > CA.Avg_Company_Salary
ORDER BY W.Company_Name, W.Salary DESC;

-- Q2. Find the company with the least number of employees.
-- Approach: GROUP BY + ORDER BY + LIMIT 1
SELECT
    Company_Name,
    COUNT(*) AS Employee_Count
FROM WORKS
GROUP BY Company_Name
ORDER BY Employee_Count ASC
LIMIT 1;

-- ── BONUS QUERIES (demonstrates extended SQL skills) ─────────

-- BONUS 1: Rank employees within each company by salary (Window Function)
SELECT
    Person_Name,
    Company_Name,
    Salary,
    RANK() OVER (PARTITION BY Company_Name ORDER BY Salary DESC) AS Salary_Rank
FROM WORKS;

-- BONUS 2: Find employees who live in the same city as their company's HQ
SELECT
    W.Person_Name,
    W.Company_Name,
    L.City    AS Employee_City,
    LI.City   AS Company_City
FROM WORKS AS W
INNER JOIN LIVES AS L      ON W.Person_Name  = L.Person_Name
INNER JOIN LOCATED_IN AS LI ON W.Company_Name = LI.Company_Name
WHERE L.City = LI.City;

-- BONUS 3: Find managers who manage more than one person
SELECT
    Manager_Name,
    COUNT(*) AS Team_Size
FROM MANAGER
GROUP BY Manager_Name
HAVING COUNT(*) > 1
ORDER BY Team_Size DESC;

-- ============================================================
-- END OF CASE STUDIES
-- ============================================================

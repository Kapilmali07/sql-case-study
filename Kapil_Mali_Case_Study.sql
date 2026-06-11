/*
CASE STUDY 1) Consider the following entities and relationships.

Owner(licence_no, Name, Address, Phone)
car(Carno, Model, Color)

Owner and car are related with one to many relationships. create a RDB for the above and solve the four following queries in SQL.

Q1. Find the name of owner of 'Zen' and 'Indica' cars.
Q2. Insert a record in a car relation.
Q3. List all the models of owner 'Mr.Shah' having color 'blue'
Q4. To list the information of all cars in pune.
*/

CREATE DATABASE CASE_STUDY;

USE CASE_STUDY;

CREATE TABLE OWNER(
Licence_No INT PRIMARY KEY,
Name VARCHAR(30),
Address TEXT,
Phone BIGINT NOT NULL
);

CREATE TABLE CAR(
Car_No INT,
Model VARCHAR(20),
Color VARCHAR(20),
Licence_No INT REFERENCES OWNER(Licence_No)
);


INSERT INTO OWNER VALUES
(201, 'Mr.Shah', 'Pune', 9876500001),
(202, 'Kapil Mali', 'Mumbai', 9876500002),
(203, 'Rahul Sharma', 'Pune', 9876500003),
(204, 'Sneha Patil', 'Delhi', 9876500004),
(205, 'Amit Verma', 'Pune', 9876500005),
(206, 'Priya Singh', 'Nagpur', 9876500006),
(207, 'Ankit Jain', 'Pune', 9876500007),
(208, 'Neha Joshi', 'Mumbai', 9876500008),
(209, 'Rohit Mehta', 'Pune', 9876500009),
(210, 'Vikas Yadav', 'Delhi', 9876500010),
(211, 'Mr.Shah', 'Pune', 9876500011),
(212, 'Kapil Mali', 'Mumbai', 9876500012),
(213, 'Rahul Sharma', 'Pune', 9876500013),
(214, 'Sneha Patil', 'Delhi', 9876500014),
(215, 'Amit Verma', 'Pune', 9876500015),
(216, 'Priya Singh', 'Nagpur', 9876500016),
(217, 'Ankit Jain', 'Pune', 9876500017),
(218, 'Neha Joshi', 'Mumbai', 9876500018),
(219, 'Rohit Mehta', 'Pune', 9876500019),
(220, 'Vikas Yadav', 'Delhi', 9876500020),
(221, 'Mr.Shah', 'Pune', 9876500021),
(222, 'Kapil Mali', 'Mumbai', 9876500022),
(223, 'Rahul Sharma', 'Pune', 9876500023),
(224, 'Sneha Patil', 'Delhi', 9876500024),
(225, 'Amit Verma', 'Pune', 9876500025),
(226, 'Priya Singh', 'Nagpur', 9876500026),
(227, 'Ankit Jain', 'Pune', 9876500027),
(228, 'Neha Joshi', 'Mumbai', 9876500028),
(229, 'Rohit Mehta', 'Pune', 9876500029),
(230, 'Vikas Yadav', 'Delhi', 9876500030);

INSERT INTO CAR VALUES
(101, 'Zen', 'White', 201),
(102, 'Indica', 'Silver', 202),
(103, 'Swift', 'Blue', 201),
(104, 'City', 'Black', 203),
(105, 'Creta', 'Blue', 204),
(106, 'Baleno', 'Red', 205),
(107, 'Thar', 'Black', 206),
(108, 'i20', 'Blue', 207),
(109, 'Verna', 'White', 208),
(110, 'Fortuner', 'Grey', 209),
(111, 'Scorpio', 'Blue', 201),
(112, 'Venue', 'Silver', 210),
(113, 'Nexon', 'White', 203),
(114, 'Safari', 'Black', 205),
(115, 'Altroz', 'Blue', 207),
(116, 'Zen', 'Blue', 211),
(117, 'Indica', 'White', 212),
(118, 'Swift', 'Blue', 211),
(119, 'City', 'Silver', 213),
(120, 'Creta', 'Black', 214),
(121, 'Baleno', 'Red', 215),
(122, 'Thar', 'Blue', 216),
(123, 'i20', 'White', 217),
(124, 'Verna', 'Black', 218),
(125, 'Fortuner', 'Blue', 219),
(126, 'Scorpio', 'Grey', 221),
(127, 'Venue', 'Blue', 222),
(128, 'Nexon', 'Silver', 223),
(129, 'Safari', 'Black', 224),
(130, 'Altroz', 'Blue', 225);

SELECT * FROM OWNER;
SELECT * FROM CAR;

-- Q1. Find the name of owner of 'Zen' and 'Indica' cars.
SELECT DISTINCT O.NAME, C.MODEL
FROM OWNER AS O
INNER JOIN CAR AS C
ON O.LICENCE_NO = C.LICENCE_NO
WHERE C.MODEL IN ('ZEN','INDICA');

-- Q2. Insert a record in a car relation.

INSERT INTO CAR VALUES
(131, 'Fortuner', 'White', 230);

SELECT * FROM CAR;

-- Q3. List all the models of owner 'Mr.Shah' having color 'blue'

SELECT C.MODEL, O.NAME,C.COLOR
FROM OWNER AS O
INNER JOIN CAR AS C
ON O.LICENCE_NO = C.LICENCE_NO
WHERE O.NAME = 'Mr.Shah' and C.COLOR='BLUE';

-- OR 

SELECT MODEL
FROM CAR
WHERE COLOR = 'BLUE' AND LICENCE_NO IN (
SELECT LICENCE_NO 
FROM OWNER
WHERE NAME="MR.SHAH"
); 

-- Q4. To list the information of all cars in pune.

SELECT C.CAR_NO, C.MODEL, C.COLOR, C.LICENCE_NO,O.ADDRESS
FROM OWNER AS O
INNER JOIN CAR AS C
ON O.LICENCE_NO = C.LICENCE_NO
WHERE O.ADDRESS = "PUNE";

-- ------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------
/* 
CASE STUDY 4) Consider the following entities and relationships:-

Lives(Person_name, Street, City)
Works(Person_name, Company_name, salary)
Located_in(Company_name, City)
Manager(Person_name, Manager_name)

Create a RDB for the above and solve the FIVE following queries in SQL.

Q1. Find all employees who have more than the average salary of employee in their company.
Q2. Find the company with least number of employees.
*/

CREATE TABLE LIVES(
PERSON_NAME VARCHAR(50) PRIMARY KEY,
STREET TEXT,
CITY VARCHAR(30)
);

CREATE TABLE WORKS(
PERSON_NAME VARCHAR(50) REFERENCES LIVES(PERSON_NAME),
COMPANY_NAME VARCHAR(50),
SALARY BIGINT
);

CREATE TABLE LOCATED_IN(
COMPANY_NAME VARCHAR(30) PRIMARY KEY,
CITY VARCHAR(50)
);

CREATE TABLE MANAGER(
PERSON_NAME VARCHAR(50) REFERENCES LIVES(PERSON_NAME),
MANAGER_NAME VARCHAR(50)
);

INSERT INTO LIVES VALUES
('Amit','MG Road','Pune'),
('Neha','FC Road','Pune'),
('Rohit','Baner Road','Pune'),
('Sneha','JM Road','Mumbai'),
('Karan','Link Road','Mumbai'),
('Pooja','Ring Road','Delhi'),
('Vikas','Civil Lines','Delhi'),
('Anjali','Sector 21','Noida'),
('Rahul','Park Street','Kolkata'),
('Meera','Anna Nagar','Chennai'),
('Arjun','BTM Layout','Bangalore'),
('Priya','Whitefield','Bangalore'),
('Nikhil','Salt Lake','Kolkata'),
('Simran','Andheri','Mumbai'),
('Deepak','Karol Bagh','Delhi'),
('Riya','MG Road','Pune'),
('Sahil','Hinjewadi','Pune'),
('Komal','Wakad','Pune'),
('Ajay','Powai','Mumbai'),
('Tina','Borivali','Mumbai'),
('Manoj','Dwarka','Delhi'),
('Kriti','Rohini','Delhi'),
('Yash','Indiranagar','Bangalore'),
('Payal','Electronic City','Bangalore'),
('Tarun','Sector 18','Noida'),
('Isha','Rajouri Garden','Delhi'),
('Varun','Camp','Pune'),
('Naina','Malad','Mumbai'),
('Harsh','Howrah','Kolkata'),
('Divya','T Nagar','Chennai');

INSERT INTO WORKS VALUES
('Kapil','Meta',2400000),
('Neha','Infosys',75000),
('Rohit','Infosys',65000),
('Riya','Infosys',50000),
('Sahil','Infosys',70000),
('Sneha','TCS',40000),
('Karan','TCS',45000),
('Pooja','TCS',50000),
('Ajay','TCS',42000),
('Tina','TCS',47000),
('Vikas','Wipro',60000),
('Anjali','Wipro',62000),
('Komal','Wipro',58000),
('Tarun','Wipro',64000),
('Rahul','Google',120000),
('Meera','Google',135000),
('Arjun','Google',110000),
('Yash','Google',125000),
('Payal','Google',128000),
('Priya','Amazon',95000),
('Nikhil','Amazon',85000),
('Harsh','Amazon',90000),
('Divya','Amazon',92000),
('Simran','Capgemini',48000),
('Varun','Capgemini',51000),
('Isha','Capgemini',53000),
('Deepak','IBM',70000),
('Manoj','IBM',72000),
('Kriti','IBM',68000),
('Naina','IBM',71000);

INSERT INTO LOCATED_IN VALUES
('Infosys','Pune'),
('TCS','Mumbai'),
('Wipro','Bangalore'),
('Google','Hyderabad'),
('Amazon','Bangalore'),
('Capgemini','Pune'),
('IBM','Delhi'),
('Accenture','Mumbai'),
('Cognizant','Chennai'),
('Oracle','Noida'),
('Microsoft','Hyderabad'),
('Deloitte','Pune'),
('TechMahindra','Pune'),
('HCL','Noida'),
('Mindtree','Bangalore'),
('Zoho','Chennai'),
('Flipkart','Bangalore'),
('Paytm','Noida'),
('Adobe','Noida'),
('Intel','Bangalore'),
('SAP','Bangalore'),
('Infosys BPO','Pune'),
('LTI','Mumbai'),
('Mphasis','Bangalore'),
('Persistent','Pune'),
('Virtusa','Hyderabad'),
('Hexaware','Mumbai'),
('Birlasoft','Noida'),
('Tata Elxsi','Bangalore'),
('Genpact','Delhi');

INSERT INTO MANAGER VALUES
('Amit','Neha'),
('Neha','Rohit'),
('Rohit','Neha'),
('Riya','Neha'),
('Sahil','Rohit'),
('Sneha','Karan'),
('Karan','Pooja'),
('Pooja','Karan'),
('Ajay','Pooja'),
('Tina','Karan'),
('Vikas','Anjali'),
('Anjali','Vikas'),
('Komal','Anjali'),
('Tarun','Vikas'),
('Rahul','Meera'),
('Meera','Rahul'),
('Arjun','Meera'),
('Yash','Rahul'),
('Payal','Meera'),
('Priya','Nikhil'),
('Nikhil','Priya'),
('Harsh','Priya'),
('Divya','Nikhil'),
('Simran','Varun'),
('Varun','Isha'),
('Isha','Varun'),
('Deepak','Manoj'),
('Manoj','Kriti'),
('Kriti','Manoj'),
('Naina','Deepak');

SELECT * FROM LIVES;
SELECT * FROM WORKS;
SELECT * FROM LOCATED_IN;
SELECT * FROM MANAGER;

UPDATE WORKS
SET SALARY=240000
WHERE PERSON_NAME='KAPIL';

-- Q1. Find all employees who have more than the average salary of employee in their company.

SELECT COMPANY_NAME, PERSON_NAME, CEIL(AVG(SALARY)) AS AVG_SALARY
FROM WORKS
GROUP BY COMPANY_NAME, PERSON_NAME
HAVING AVG(SALARY) > 
(
SELECT AVG(NEWAVG) FROM 
	(
    SELECT COMPANY_NAME, AVG(SALARY) AS NEWAVG
    FROM WORKS
    GROUP BY COMPANY_NAME
    ) AS T1
); 


-- Q2. Find the company with least number of employees.

SELECT COMPANY_NAME, COUNT(*) AS RESULT
FROM WORKS
GROUP BY COMPANY_NAME
ORDER BY COUNT(*) ASC
LIMIT 1;


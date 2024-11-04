-- Creating Data_Base of Office 
CREATE DATABASE Office;

-- we can see all the database list
SHOW DATABASES;

USE Office;

-- Create the Table_Data of Worker

-- Contarins :- PRIMARY KEY => NOT NULL , UNIQUE 

CREATE TABLE Worker(
Worker_ID INT PRIMARY KEY AUTO_INCREMENT,
First_Name VARCHAR(255),
Last_Name VARCHAR(255), 
Salaray INT DEFAULT 25000, 
Join_Date DATE,
Department VARCHAR(255) 
-- Age INT CHECK (Age >= 18)

-- Age INT , 
-- CONSTRAINT Age_Check CHECK (Age >= 18 && Last_Name = 'Mathapati')

);


-- Inserting the Values in the Table 

INSERT INTO Worker 
( Worker_ID , First_Name , Last_Name , Salaray , Join_Date , Department ) VALUES
( 1 , 'Shivam' , 	 'Mathapati' , 500 , '01-01-20' , 'IT'),
( 2 , 'Vivekanand' , 'Mathapati' , 100 , '01-01-20' , 'IT'),
( 3 , 'Laxmi' ,      'Mathapati' , 200 , '01-01-20' , 'IT'),
( 4 , 'Prem' ,       'Mathapati' , 40 , '01-01-20' , 'IT'),
( 5 , 'Nayna' ,      'Mathapati' , 50 , '01-01-20' , 'IT');

SELECT * FROM Worker;

-- By using DISTINCT => we can get only the unique not repeating values
SELECT DISTINCT Department FROM Worker;


-- Create Bonus Table_Data 

CREATE TABLE Bonus(
Worker_Ref_ID INT,
Bonus_AMT INT,
Bonus_Date DATE,
FOREIGN KEY (Worker_Ref_ID)
			REFERENCES Worker(Worker_ID)
            ON DELETE CASCADE
);


-- Inserting the Data in Bonus 

INSERT INTO Bonus
(Worker_Ref_ID , Bonus_AMT , Bonus_Date ) VALUES
( 1 , 10 , '01-01-20'),
( 2 , 20 , '01-01-20'),
( 3 , 30 , '01-01-20'),
( 4 , 40 , '01-01-20'),
( 5 , 50 , '01-01-20');

SELECT * FROM Bonus;


-- Create Table_Data of Tittle 

CREATE TABLE Tittle(
Worker_Ref_ID INT,
Worker_Tittle VARCHAR(255),
Tech_Stack VARCHAR(255),
FOREIGN KEY	(Worker_Ref_ID)
			REFERENCES Worker(Worker_ID)
            ON DELETE CASCADE
);

-- Inserting values in the Tittle Table 


INSERT INTO Tittle
(Worker_Ref_ID , Worker_Tittle , Tech_Stack ) VALUES
( 1 , 'FullStack Developer' , '01-01-20'),
( 2 , 'Frontend Developer' , '01-01-20'),
( 3 , 'Backend Developer' , '01-01-20'),
( 4 , 'DataBase Developer' , '01-01-20'),
( 5 , 'AR_VR Developer' , '01-01-20');


SELECT * FROM Tittle;

-- Commands for Deleting Tables and DataBases 
-- DROP TABLE table_name 
-- DROP DATABASE db_name


-- Deep into SELECT COMMAND 
-- we can get custom data from Tables 

SELECT First_Name , Last_Name , Salaray FROM Worker;

-- We can use SELECT commnad without using FROM with the help of Dual Tables 

SELECT 10 + 10;
SELECT now();
SELECT ucase('shivam');
SELECT lcase('SHIVAM');

-- We can put the Condition to reduce the Row and any Particular Data we want 

SELECT * FROM Worker;
-- now here we can get the data for applied condition  
SELECT * FROM Worker WHERE Salaray > 40; 
-- we can give String as well 
SELECT * FROM Worker WHERE Last_Name = 'Mathapati';


-- BETWEEN :- Limits are Enclusive (included)
SELECT * FROM Worker WHERE Salaray BETWEEN 50 AND 500; -- 50 & 500 are Enclusive

-- Logical Commands :- AND , OR , NOT 

-- AND :- BOTH_TRUE 
-- OR :- ATLEAST_ONE_TRUE
-- NOT :- NEGATION 


-- AND 
SELECT * FROM Worker WHERE First_Name = 'Shivam' AND Department = 'IT';

-- OR
SELECT * FROM Worker WHERE Last_Name = 'Mathapati' AND Salaray > 200;

-- NOT IN
-- its gives all the worker list whose salaray not 20 or 500
SELECT * FROM Worker WHERE Salaray NOT IN (20 , 500); -- we can give the List 


-- IN :- to reduces the Multiple OR Conditions 

SELECT * FROM Tittle WHERE Worker_Tittle = 'FullStack Developer' OR Worker_Tittle = 'Backend Developer' OR Worker_Tittle = 'DataBase Developer'; -- and many more 

-- Best_Way :- 
-- its give all the data whose worker_tittle is in ("values") bracktes
SELECT * FROM Tittle WHERE Worker_Tittle IN ('FullStack Developer' , 'Backend Developer' , 'DataBase Developer');


-- IS NULL :- if we pull any of the value in table as NUll , by the IS NULL Command we get the row where the entry is NULL
-- SELECT * FROM Tittle WHERE Worker_Tittle IS NULL; 



-- LIMIT :- we can set the limit on how much rows of data we get 
CREATE TABLE new_temp_table(
tempID INT PRIMARY KEY AUTO_INCREMENT
);

INSERT INTO new_temp_table (tempID) VALUES
(1),
(2),
(3),
(4),
(5);

-- LIMIT :- we want only 3 rows , hence we will set the limit of 3 

SELECT * FROM new_temp_table LIMIT 3;



-- Pattern Searching / Wildcard :-  % :- for any character , _ :- for only one character
SELECT * FROM Worker WHERE First_Name LIKE '_i%';
--    _  :- only one character is allowed before i 
--    %  :- for any character is allowed after i 


-- Sorting in SQl : if we want the data of users in sorted format , use :- ORDER BY
-- Default - ASC (Ascending) , 
-- DESC (Descending Order) 
SELECT * FROM Worker ORDER BY Salaray ; -- ASC Default 
SELECT * FROM Worker ORDER BY Salaray DESC;

-- Question we want top 3 students with the marks :- 
CREATE TABLE Students_Marks(
stdID INT PRIMARY KEY AUTO_INCREMENT ,
sName VARCHAR(50) ,
marks INT NOT NULL 
);

INSERT INTO Students_Marks( stdID , sName, marks) VALUES
(1 , "gopal" , 80),
(2 , "shravan" , 90),
(3 , "bhushan" , 95),
(4 , "ranjeet" , 89),
(5 , "shivam" , 99);

-- now find the top 3 students by their marks 
SELECT * FROM Students_Marks ORDER BY marks DESC LIMIT 3;

-- if we want the Distinct data : example :- if we want to get the all distinct department of workers 
SELECT DISTINCT Worker_Tittle FROM Tittle; -- we can all the list of different distinct department list


-- Grouping of data :- if we want the count of worker working at different departments
-- we want the customer count from different countries from amazon data_base 
-- GROUP BY 
-- if we not using the aggregation function then it acts as a DISTINCT 

-- aggregation function :- count() , sum() , avg() , min() , max();

-- aggregate function returns the single value 

SELECT * FROM Tittle;
-- COUNT()
SELECT Worker_Tittle , COUNT(Worker_Tittle) FROM Tittle GROUP BY Worker_Tittle;

-- AVG()
SELECT Department , AVG(Salaray)  FROM Worker GROUP BY Department;

-- MIN() / MAX()
SELECT Department , MIN(Salaray)  FROM Worker GROUP BY Department;
SELECT Department , MAX(Salaray)  FROM Worker GROUP BY Department;

-- if we wanted to add the condition with the GROUP BY 
-- if we wanted the departement where the count of employ is greater than 2 
-- 1> use GROUP BY  and calculate COUNT() then by using GROUP BY HAVING put condition
SELECT * FROM Worker;
SELECT Department , COUNT(Department)  FROM Worker GROUP BY Department;
-- here we get the Deparment where the Worker are more than 3
SELECT Department , COUNT(Department)  FROM Worker GROUP BY Department HAVING COUNT(Department) > 3 ;

-- Question find the avg marks of students from differnt citys 

CREATE TABLE Student_Marks(
id INT PRIMARY KEY ,
marks INT ,
city VARCHAR(50)
);


INSERT INTO Student_Marks(id , marks , city) VALUES
(1 , 90 , "Pune"),
(2 , 93 , "Pune"),
(3 , 99 , "Latur"),
(4 , 80 , "Mumbai"),
(5 , 98 , "Latur");

-- find the avg marks per city :- 

SELECT city , AVG(marks) FROM Student_Marks GROUP BY city ORDER BY AVG(marks) DESC; 

-- here we are grouping the sutudents by the city and find the avg marks accordingly 


CREATE TABLE Payment(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(50),
mode VARCHAR(50), 
city VARCHAR(50)
);

INSERT INTO Payment(customer_id , customer_name , mode , city) VALUES
(1 , "nameOne" , "netbanking" , "latur"),
(2 , "nameTwo" , "credit card" , "pune"),
(3 , "nameThree" , "credit card" , "sangli"),
(4 , "nameFour" , "netbanking" , "pilani"),
(5 , "nameFive" , "credit card" , "mumbai"),
(6 , "nameSix" , "debit card" , "nanded"),
(7 , "nameSeven" , "debit card" , "baramati");

-- find the total payment according to each payment mode 

SELECT mode as Payment_Method , COUNT(customer_id) as Total_Payment FROM Payment GROUP BY mode ORDER BY COUNT(customer_id);

-- Difference Between WHERE and HAVING 

-- HAVING is used for applying condition on GROUPS 
-- means it is used when they is GROUP BY 

-- Example and flow of the Query :- 

SELECT city 
FROM Stundet_Table 
WHERE Last_Name = 'Mathapati'
GROUP BY city 
HAVING MAX(marks) >= 90
ORDER BY MAX(marks) DESC
LIMIT 3; 

-- ---------------------------------------------------------------------------------------------



-- DDL () Data Defination Language (Constrains)

-- Primary Key :- it can be unique and not null 
-- Foregin Key :- this will be included from the Another table_data
-- Unique :- something that should be unique for each person :- ex :- username
-- Check :- we use to add the checks while entry of database , if user puts the data which is not fullfill the checks then it will show error
-- Default :- we can set the default values of some rows 

CREATE TABLE bankAcc(
-- Here we are taking bank_ID as a foregin key from worker 
bank_ID INT NOT NULL PRIMARY KEY, 
user_name VARCHAR(255) UNIQUE, 
age INT DEFAULT 0, 

-- Adding the Constarains check values before inserting 

acc_balance INT DEFAULT 0,
CONSTRAINT 	age_check CHECK(age > 18),
CONSTRAINT acc_balance_check CHECK(acc_balance > 10) ,

FOREIGN KEY (bank_ID)
		REFERENCES Worker(Worker_ID)
        ON DELETE CASCADE
);


-- ----------------------------------

-- Alter Operations are used to Change the Schema 
-- Add , Modify , Change Column name , Drop Column , Change Table name


CREATE DATABASE Bank;
SHOW DATABASES;
USE Bank;

CREATE TABLE details_user (
acc_number INT PRIMARY KEY AUTO_INCREMENT ,
user_name VARCHAR(255) UNIQUE NOT NULL,
balance INT DEFAULT 0
);

-- ADD :- Adding new Column of address in the Table :- User 
ALTER TABLE details_user ADD COLUMN address VARCHAR(255) DEFAULT 'INDIA';

SELECT * FROM details_user;

-- we can get all the information about our schema 
DESC details_user;

-- MODIFY :- Change the data_type and Constrains of attributes , change data_type of address to DOUBLE 
ALTER TABLE details_user MODIFY address DOUBLE;

-- CHANGE COLUMN :- change / rename the column name 
ALTER TABLE details_user CHANGE COLUMN address user_address DOUBLE; -- OLD NAME -- NEW NAME

-- DROP COLUMN :- Deleting the Column 
ALTER TABLE details_user DROP COLUMN user_address;

-- RENAME :- Changing the name of Table :-
ALTER TABLE details_user RENAME TO user_details;

DESC user_details;


-- --------------------------------------------------------------------


-- Data Manipulation Language (DML)

CREATE TABLE Customer (
customer_ID INT PRIMARY KEY NOT NULL,
customer_name VARCHAR(255),
customer_address VARCHAR(255),
customer_pincode VARCHAR(255) NOT NULL
);



INSERT INTO Customer
(customer_ID, customer_name, customer_address, customer_pincode) VALUES
( 1 , 'Shivam' , 'Latur' , '413512'),
( 2 , 'Sharavan' , 'Solapur' , '413896'),
( 3 , 'Ranjeet' , 'Nagpur' , '889777'),
( 4 , 'Sharvari' , 'Kolhapur' , '235789'),
( 5 , 'Bhushan' , 'Dhule' , '12546');


SELECT * FROM Customer;

-- before Upadting , we have to OFF The SQL SAFE MODE :- 

SET SQL_SAFE_UPDATES = 0;

-- to on SAFE MODE again 

SET SQL_SAFE_UPDATES = 1;

-- For Updating the ROWS we are using UPDATE and SET

-- INSERT :- for inserting the data into the table 
-- UPDATE :- we can  update the data in the table (Rows) using , UPDATE and SET Command 

UPDATE Customer SET customer_address = "Latur" WHERE customer_ID = 4;


UPDATE Customer SET customer_pincode = '000999' WHERE customer_ID = 4;

-- if we want to upadate multiple rows , ex :- if we want to change all the pincode to 999999 then 
-- use UPDATE without using WHERE , 
UPDATE Customer SET customer_pincode = '123456';
-- it will give an Security error to resolve this , use Command :- 
-- SET SQL_SAFE_UPDATES = 0;


-- DELETE :- we can delete particular row of the table or we can delete whole table 
-- for delete table , we have to make 0 to the sql security 

DELETE FROM Customer WHERE customer_ID = 4;
-- Now Row with the ID = 4 has been deleted from the Table 

-- Delete all the Table :- 
-- SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM Customer;

-- ON UPDATE CASCADE :- if there will be upadtes done in parent table , it will be refelects  in the child table as well 

-- ON DELETE CASCADE :- we use this for the foregin key , use :- whenever we delete row from parent automatically it will deleted from child 
-- parent_row -> delete : child_row -> delete

-- ON DELETE NULL :- if we delete row from the parent row then the correspoing row from the child node will be set to be null
-- parent_row ->delete : child_row -> Null

-- Replace :- there are two behavior of replace :- 1> if data is already present then it will Replace 
-- 2> if data not exist : new data has been added (behaive as a INSERT)


-- --------------------------------------------------------------

-- Difference Between the DROP , DELETE and TRUNCATE 
-- DELERE and DROP directly deletes the table from the database permenantly 
-- but TRUNCATE just delete the Data from the Table , not delete whole table 

TRUNCATE TABLE Student_Table;


-- ---------------------------------------------------------------

SELECT * FROM Customer;

-- here the ID Exist hence it replace all the values 
REPLACE INTO Customer(customer_ID, customer_name, customer_address, customer_pincode) VALUES
(2 , 'Shrutika' , 'Sangli' , '122334');

-- here values not exists , hence add new Row (acts as INSERT)
REPLACE INTO Customer(customer_ID, customer_name, customer_address, customer_pincode) VALUES
(4 , 'Omkar' , 'Nashik' , '899665');

-- Another way of writting same Queries :- 
REPLACE INTO Customer SET customer_ID = 6 , customer_name = 'Purva', customer_address='Jayshinghpur', customer_pincode = '900999';

REPLACE INTO Customer SET customer_ID = 6 , customer_name = 'Shraddha', customer_address='Nagpur', customer_pincode = '900999';


SELECT * FROM Customer;

-- ---------------------------------------------------------------------


-- Joining Tables :- 
-- Types of Joining Tables :- 1> Inner_Join 2> Outter_Join - 2.1> Left_Join , 2.2> Right_Join , 2.3> Full_Join 3> Cross_Join 4> Self Join  

-- Creating new DataBase as Company and Apply All the Join Methods :- 
CREATE DATABASE Company;
SHOW DATABASES;
USE Company;

-- Employee Table => Parent_Table 


CREATE TABLE Employe(
id INT PRIMARY KEY NOT NULL UNIQUE , 
f_name VARCHAR(255),
l_name VARCHAR(255), 
age INT,
email VARCHAR(255),
phone_no INT,
city VARCHAR(255)
);

INSERT INTO Employe
(id , f_name , l_name , age , email , phone_no , city) VALUES
(1 , 'Shivam' , 'Mathapati' , 10 , 'shivam@gmail.com' , 10 , 'Latur'),
(2 , 'Shravan' , 'Jare' , 20 , 'shravan@gmail.com' , 20 , 'Solapur'),
(3 , 'Ranjeet' , 'Revatkar' , 30 , 'ranjeet@gmail.com' , 30 , 'Nagpur'),
(4 , 'Sharvari' , 'Jadhav' , 40 , 'sharvari@gmail.com' , 40 , 'Kolhapur'),
(5 , 'Manas' , 'Gedam' , 50 , 'manas@gmail.com' , 50 , 'Amravati');


SELECT * FROM Employe;

-- Client Table => Child_Table 

CREATE TABLE Client_I(
id INT, 
f_name VARCHAR(255),
l_name VARCHAR(255),
age INT,
email VARCHAR(255),
phone_no INT , 
city VARCHAR(255),
emp_ID INT ,

FOREIGN KEY (emp_ID)
		REFERENCES Employe(id)
        ON DELETE CASCADE

);

INSERT INTO Client_I
(id , f_name , l_name , age , email , phone_no , city  , emp_ID) VALUES
(1  , 'Vivek' , 'Mathapati' , 60 , 'vivek@gmail,com' , 10 , 'Latur' ,     1 ),
(2  , 'Laxmi' , 'Mathapati' , 70 , 'laxmi@gmail,com' , 20 , 'Latur' ,     2 ),
(3  , 'Parvati' , 'Mathapati' , 80 , 'parvati@gmail,com' , 30 , 'Latur' , 3 ),
(4  , 'Uma' , 'Mathapati' , 90 , 'uma@gmail,com' , 40 , 'Latur' ,         4 ),
(5  , 'Madhu' , 'Mathapati' , 100 , 'madhu@gmail,com' , 50 , 'Latur' ,    5 );

Select * from Client_I;


-- Project Table (Child_Table)

CREATE TABLE Project(
id_P INT, 
emp_ID INT, -- Foregin_Key from Employe
p_name VARCHAR(255),
start_date DATE,
client_ID INT, -- Foregin_Key from Client_I

FOREIGN KEY (emp_ID)
		REFERENCES Employe(id)
		ON DELETE CASCADE       
);

INSERT INTO Project
(id_P , emp_ID , p_name , start_date , client_ID) VALUES
(1 , 1 , 'pOne' , '01-01-20' , 1),
(2 , 2 , 'pTwo' , '02-01-20' , 2),
(3 , 3 , 'pThree' , '03-01-20' , 3),
(4 , 4 , 'pFour' , '04-01-20' , 4),
(5 , 5 , 'pFive' , '05-01-20' , 5);

SELECT * FROM Project; 


-- Use all the Joining Types :- 


-- 1) 	INNER JOIN : Employe Names and Project Names and date
SELECT e.f_name , e.l_name , p.p_name , p.start_date FROM Employe AS e
INNER JOIN 
Project as p ON e.id = p.emp_ID; 

-- we can use INNER JOIN without writting INNER JOIN 
-- replace INNER JOIN with , and ON by WHERE 

SELECT e.f_name , e.l_name , p.p_name , p.start_date FROM Employe AS e , Project as p WHERE e.id = p.emp_ID; 


-- 2) Left Join / Right Join both are the same implementation is different we can implement both 
-- Project : p_name , start_date , Client : client_name(f,l)
SELECT p.p_name , p.start_date , e.f_name , e.l_name FROM Project AS p 
LEFT JOIN 
Employe as e ON p.emp_ID = e.id;

-- FULL JOIN  :- join all the tables 
-- Project :- p_name , start_date :  Employe :- f_name , l_name : Client :- f_name , l_name 
-- here Left_table Union Right_table 
SELECT p.p_name , p.start_date , e.f_name , e.l_name FROM Project as p 
LEFT JOIN Employe as e ON p.emp_ID = e.id
UNION 
SELECT c.f_name , c.l_name , e.f_name , e.l_name FROM Client_I as c
RIGHT JOIN Employe as e ON c.emp_ID = e.id;


-- Self Join 
CREATE TABLE Employe_Table(
id INT PRIMARY KEY ,
e_name VARCHAR(50) ,
manager_id INT NOT NULL
);

ALTER TABLE Employe_Table MODIFY manager_id INT;

INSERT INTO Employe_Table(id , e_name , manager_id) VALUES
(101 , 'adam'  , 103),
(102 , 'bob'  , 104),
(103 , 'casey'  , null),
(104 , 'donal'  , 103);

-- Self Join :- 
SELECT a.e_name as Manager_Name , b.e_name as Employe_Name 
FROM Employe_Table as a
JOIN Employe_Table as b
ON a.id = b.manager_id;


-- --------------------------------------------------------------------

-- Set Operation 

CREATE DATABASE Startup;
SHOW DATABASES;
USE Startup;

CREATE TABLE Department_One(
emp_ID INT NOT NULL PRIMARY KEY , 
emp_name VARCHAR(255) , 
emp_role VARCHAR(255)
);


INSERT INTO Department_One
(emp_ID , emp_name , emp_role) VALUES
(1  , 'Shivam' , 'Engineer'),
(2  , 'Shravan' , 'Salesman'),
(3  , 'Ranjeet' , 'Manager'),
(4  , 'Manas' , 'Salesman'),
(5  , 'Sharvari' , 'Engineer');


CREATE TABLE Department_Two(
emp_ID INT, 
emp_name VARCHAR(255) , 
emp_role VARCHAR(255) 
);


INSERT INTO Department_Two
(emp_ID , emp_name , emp_role) VALUES
(3  , 'Ranjeet' , 'Manager'),
(6  , 'Omkar' , 'Marketing'),
(7  , 'Gopal' , 'Salesman');


-- Set Operations :- Union , Intersection , Minus 

-- UNION :- here the repeated rows comes once , the col must be same of both tables and data_type also must be same 

-- UNION ALL :- we can also get the duplicate rows / data as well

SELECT * FROM Department_One 
UNION 
SELECT * FROM Department_Two;

-- INTERSECTION :- there is no any key word for intersection , to implement it we have to emulate usign INNER JOIN 
SELECT DISTINCT emp_ID FROM Department_One
INNER JOIN Department_Two USING(emp_ID);

-- MINUS :- again there is no any keyword for Minus , we have emulate it using Left_Join 

SELECT emp_ID FROM Department_One 
LEFT JOIN Department_Two USING(emp_ID) WHERE Department_Two.emp_ID IS NULL;


-- View we can set different view for the different users
-- there is an Employee data which has colummn as :- f_name , l_name , age , location , salaray 
-- but we want to show only the f_name and age 
-- create view in which there is only f_name and age , it is not a new table , its just a filter from where we can only f_name and age 

SELECT * FROM Department_One;

-- Create View , Show :- emp_name and emp_Id
CREATE VIEW Custom_View AS SELECT emp_ID , emp_name FROM Department_One;

-- Seeing View :-
SELECT * FROM Custom_View;

-- Altering View :- Adding new values in View :- 
ALTER VIEW Custom_View AS SELECT emp_ID , emp_name ,emp_role FROM Department_One;

-- DROP VIEW :- 
DROP VIEW IF EXISTS Custom_View;

-- Sub_Query :- Nested Query 
-- it is used in 1> SELECT , 2> FROM , 3> WHERE (generally / normally used)

CREATE TABLE ClassRoom(
rollno INT PRIMARY KEY ,
s_name VARCHAR(50) ,
marks INT NOT NULL
);

INSERT INTO ClassRoom(rollno , s_name , marks) VALUES
(1 , 'nameOne' , 80),
(2 , 'nameTwo' , 86),
(3 , 'nameThree' , 98),
(4 , 'nameFour' , 70),
(5 , 'nameFive' , 99);

-- get name of all students who scored more than class avg 
-- 1> find class avg 
-- 2> stds with > avg

SELECT AVG(marks) 
FROM ClassRoom;

-- avg = 86.60

SELECT * FROM ClassRoom WHERE marks > 86.60;

-- BY Using the nested Query :- 

SELECT * 
FROM ClassRoom 
WHERE marks > ( SELECT AVG(marks) FROM ClassRoom );

-- find the name of all students with even roll numbers 
SELECT s_name 
FROM ClassRoom 
WHERE rollno % 2 = 0;

SELECT s_name , rollno
FROM (SELECT * FROM ClassRoom WHERE rollno % 2 = 0) AS Student_Name;




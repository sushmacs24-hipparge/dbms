-- Create Database
CREATE DATABASE Employee;
USE Employee;

-- Create Department Table
CREATE TABLE Dept (
    DeptNo INT PRIMARY KEY,
    Dname VARCHAR(30),
    Dloc VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE Employee (
    Eno INT PRIMARY KEY,
    Ename VARCHAR(30) NOT NULL,
    Mgr_No INT,
    Hiredate DATE,
    Sal DECIMAL(10,2),
    DeptNo INT,
    FOREIGN KEY (DeptNo) REFERENCES Dept(DeptNo)
);

-- Create Project Table
CREATE TABLE Project (
    Pno INT PRIMARY KEY,
    Pname VARCHAR(30),
    Ploc VARCHAR(50)
);

-- Create AssignedTo Table (junction table)
CREATE TABLE AssignedTo (
    Eno INT,
    Pno INT,
    JobRole VARCHAR(50),
    PRIMARY KEY (Eno, Pno),
    FOREIGN KEY (Eno) REFERENCES Employee(Eno),
    FOREIGN KEY (Pno) REFERENCES Project(Pno)
);

-- Create Incentive Table
CREATE TABLE Incentive (
    Eno INT,
    Incentive_Date DATE,
    Incentive_Amount DECIMAL(10,2),
    FOREIGN KEY (Eno) REFERENCES Employee(Eno)
);

-- Insert values into Dept
INSERT INTO Dept (DeptNo, Dname, Dloc)
VALUES
(10, 'HR', 'Mysore'),
(20, 'IT', 'Bangalore'),
(30, 'Finance', 'Delhi'),
(40, 'Marketing', 'Chennai'),
(50, 'Operations', 'Hyderabad');

-- Insert values into Employee
INSERT INTO Employee (Eno, Ename, Mgr_No, Hiredate, Sal, DeptNo)
VALUES
(101, 'Rajesh', NULL, '2019-04-12', 55000.00, 10),
(102, 'Sneha', 101, '2020-07-13', 48000.00, 20),
(103, 'Kiran', 101, '2021-01-25', 42000.00, 30),
(104, 'Priya', 103, '2022-04-14', 39000.00, 40),
(105, 'Arjun', 103, '2023-11-15', 38000.00, 50);

-- Insert values into Project
INSERT INTO Project (Pno, Pname, Ploc)
VALUES
(1, 'Recruitment', 'Mysore'),
(2, 'ERP Upgrade', 'Bangalore'),
(3, 'Audit System', 'Delhi'),
(4, 'Product Launch', 'Chennai'),
(5, 'Logistic Hub', 'Hyderabad');

-- Insert values into AssignedTo
INSERT INTO AssignedTo (Eno, Pno, JobRole)
VALUES
(101, 1, 'Project Manager'),
(102, 2, 'Software Engineer'),
(103, 3, 'Analyst'),
(104, 4, 'Accountant'),
(105, 5, 'Coordinator');

-- Insert values into Incentive
INSERT INTO Incentive (Eno, Incentive_Date, Incentive_Amount)
VALUES
(101, '2024-02-10', 5000.00),
(102, '2024-06-25', 3000.00),
(103, '2024-07-18', 2800.00),
(104, '2024-09-12', 2800.00),
(105, '2024-12-05', 3200.00);

-- Display Data
SELECT * FROM Dept;
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM AssignedTo;
SELECT * FROM Incentive;
Drop database employee;

-- Queries

-- query1:
select e.Eno,e.Ename,d.Dname,d.Dloc
from Employee e
Join Dept d On e.DeptNo = d.DeptNo;
-- query2:
SELECT e.Eno, e.Ename
FROM Employee e
LEFT JOIN AssignedTo a ON e.Eno = a.Eno
WHERE a.Pno IS NULL;
SELECT p.Pname, COUNT(a.Eno) AS HEADCOUNT
FROM Project p
LEFT JOIN AssignedTo a ON p.Pno = a.Pno
GROUP BY p.Pname;
-- query3:
SELECT d.Dname, 
       AVG(e.Sal) AS AVG_SALARY, 
       MAX(e.Sal) AS MAX_SALARY
FROM Employee e
JOIN Dept d ON e.DeptNo = d.DeptNo
GROUP BY d.Dname;
-- query4:

SELECT E.Eno, E.Ename, SUM(I.Incentive_Amount) AS Total_Incentives
FROM Employee E
JOIN Incentive I ON E.Eno = I.Eno
GROUP BY E.Eno, E.Ename;
-- query 5:
 
SELECT E.Eno, E.Ename
FROM Employee E
JOIN AssignedTo A ON E.Eno = A.Eno
JOIN Project P ON A.Pno = P.Pno
WHERE P.Pname = 'Recruitment';
-- query 6:

SELECT D.DeptNo, D.Dname
FROM Dept D
LEFT JOIN Employee E ON D.DeptNo = E.DeptNo
WHERE E.Eno IS NULL;
-- query 7:

SELECT M.Eno AS Manager_ID, M.Ename AS Manager_Name, COUNT(E.Eno) AS Report_Count
FROM Employee M
JOIN Employee E ON M.Eno = E.Mgr_No
GROUP BY M.Eno, M.Ename;
-- query 8:

SELECT E.Eno, E.Ename, COUNT(A.Pno) AS Project_Count
FROM Employee E
JOIN AssignedTo A ON E.Eno = A.Eno
GROUP BY E.Eno, E.Ename
HAVING COUNT(A.Pno) > 1;








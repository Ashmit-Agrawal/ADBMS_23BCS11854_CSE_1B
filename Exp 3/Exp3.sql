--------------------EXPERIMENT 03: (MEDIUM LEVEL)---------------------
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

--Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


--Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

--Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'JACK', 90000, 1);

SELECT D.dept_name, E.name, E.salary
FROM Employee E
INNER JOIN Department D
  ON E.department_id = D.id
WHERE E.salary = (
    SELECT MAX(E2.salary)
    FROM Employee E2
    WHERE E2.department_id = E.department_id    
)

order by D.dept_name;



--------------------EXPERIMENT 03: (HARD LEVEL)

CREATE TABLE TBL_A(
EMP_ID INT PRIMARY KEY,
ENAME VARCHAR(20), 
SALARY INT);

CREATE TABLE TBL_B(
EMP_ID INT PRIMARY KEY,
ENAME VARCHAR(20), 
SALARY INT);

INSERT INTO TBL_A VALUES
(1, 'AA', 1000),
(2, 'BB', 300);

INSERT INTO TBL_B VALUES
(2, 'BB', 300),
(3, 'CC', 100);

SELECT EMP_ID, MIN(ENAME), MIN(SALARY)
FROM (SELECT A.*
FROM TBL_A AS A
UNION ALL
SELECT B.*
FROM TBL_B AS B) as INTER_RESULT
GROUP BY EMP_ID;

-- Step 1: Create Tables
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Step 2: Insert Data into Departments
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Civil Engineering'),
(5, 'Mathematics');

-- Step 3: Insert Data into Courses
INSERT INTO Courses (course_id, course_name, department_id) VALUES
(101, 'Data Structures', 1),
(102, 'Operating Systems', 1),
(103, 'Machine Learning', 1),
(104, 'Thermodynamics', 2),
(105, 'Fluid Mechanics', 2),
(106, 'Circuits and Systems', 3),
(107, 'Control Systems', 3),
(108, 'Structural Analysis', 4),
(109, 'Linear Algebra', 5),
(110, 'Calculus', 5),
(111, 'Probability Theory', 5);

-- Step 4: Count Number of Courses per Department
SELECT 
    department_name,
    (SELECT COUNT(*) 
     FROM Courses c 
     WHERE c.department_id = d.department_id) AS course_count
FROM Departments d;

-- Step 5: Filter Departments Offering More Than 2 Courses
SELECT 
    department_name,
    (SELECT COUNT(*) 
     FROM Courses c 
     WHERE c.department_id = d.department_id) AS course_count
FROM Departments d
WHERE (SELECT COUNT(*) 
       FROM Courses c 
       WHERE c.department_id = d.department_id) > 2;


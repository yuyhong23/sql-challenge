-- Data Engineering

CREATE TABLE Titles (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

CREATE TABLE Employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no,salary
     )
);

CREATE TABLE Departments (
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Department_Employees (
    emp_no INT NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    CONSTRAINT pk_Department_Employees PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE Department_Managers (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    CONSTRAINT pk_Department_Managers PRIMARY KEY (
        dept_no,emp_no
     )
);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Department_Employees ADD CONSTRAINT fk_Department_Employees_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Department_Employees ADD CONSTRAINT fk_Department_Employees_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Department_Managers ADD CONSTRAINT fk_Department_Managers_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Department_Managers ADD CONSTRAINT fk_Department_Managers_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

-- Data Analysis

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp_no AS "employee number", last_name AS "last name", first_name AS "first name",
	sex, (SELECT salary FROM Salaries WHERE Salaries.emp_no = Employees.emp_no)
FROM Employees;

--2.List first name, last name, and hire date for employees who were hired in 1986.

--Note on optimization: muti-indexes is the best, follow by index, and no index.
EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", hire_date AS "hire date"
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Index for hire_date
DROP INDEX hire_date_index;
CREATE INDEX hire_date_index ON Employees (hire_date);

EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", hire_date AS "hire date"
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Index for hire_date, first_name, last_name
DROP INDEX hire_date_index;
CREATE INDEX hire_date_index ON Employees (hire_date, first_name, last_name);

EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", hire_date AS "hire date"
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.	
SELECT Departments.dept_no AS "department number", 
	Departments.dept_name AS "department name", Employees.emp_no AS "employee number",
	Employees.last_name AS "last name", Employees.first_name AS "first name"
From Department_Managers
INNER JOIN Employees ON
	Employees.emp_no = Department_Managers.emp_no
INNER JOIN Departments ON
	Departments.dept_no = Department_Managers.dept_no;

--4.List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT Department_Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
	Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments"ON
	Departments.dept_no = Department_Employees.dept_no;

--5.List first name, last name, and sex for employees whose first name is "Hercules" 
--and last names begin with "B."

--Note on optimization: multi-index is the best, follow by two indexes, partial indexes, then without index.
EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", "sex"
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--Create partial indexes of first_name and last_name
DROP INDEX IF EXISTS first_name_index, last_name_index;
CREATE INDEX first_name_index ON Employees (first_name) WHERE first_name = 'Hercules';
CREATE INDEX last_name_index ON Employees (last_name) WHERE last_name LIKE 'B%';

EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", "sex"
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--Create indexes of first_name and last_name
DROP INDEX IF EXISTS first_name_index, last_name_index
CREATE INDEX first_name_index ON Employees (first_name);
CREATE INDEX last_name_index ON Employees (last_name);

EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", "sex"
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--Create multi-index of first_name and last_name
DROP INDEX IF EXISTS name_index;
CREATE INDEX name_index ON Employees (first_name, last_name);

EXPLAIN ANALYZE SELECT first_name AS "first name", last_name AS "last name", "sex"
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6.List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

--Note on optimization, partial index is the best, follow by index and no index.
EXPLAIN ANALYZE SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", 
	Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
WHERE Departments.dept_name = 'Sales';

--Create a partial index of dept_name
DROP INDEX IF EXISTS dept_name_index;
CREATE INDEX dept_name_index ON Departments (dept_name) WHERE dept_name = 'Sales';

EXPLAIN ANALYZE SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", 
	Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
WHERE Departments.dept_name = 'Sales';

--Create a index of dept_name
DROP INDEX IF EXISTS dept_name_index;
CREATE INDEX dept_name_index ON Departments (dept_name);

EXPLAIN ANALYZE SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", 
	Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
WHERE Departments.dept_name = 'Sales';

--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

--Note on optimization, best with index
EXPLAIN ANALYZE SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", 
	Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
WHERE Departments.dept_name = 'Sales'
OR Departments.dept_name = 'Development';

--Create a index of dept_name
DROP INDEX IF EXISTS dept_name_index;
CREATE INDEX dept_name_index ON Departments (dept_name);

EXPLAIN ANALYZE SELECT Employees.emp_no AS "employee number", Employees.last_name AS "last name", 
	Employees.first_name AS "first name", 
	Departments.dept_name AS "department name"
FROM Department_Employees
INNER JOIN Employees ON
Employees.emp_no = Department_Employees.emp_no
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
WHERE Departments.dept_name = 'Sales'
OR Departments.dept_name = 'Development';

--8.In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

--Note on optimization, no index is the best, follow by index for the last_name and index of last_name specifying DESC.
EXPLAIN ANALYZE SELECT last_name AS "last name", COUNT(last_name) AS "Count of Last Name"
FROM Employees
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;

--Create a index of last_name
DROP INDEX IF EXISTS lastname_index;
CREATE INDEX lastname_index ON Employees (last_name);

EXPLAIN ANALYZE SELECT last_name AS "last name", COUNT(last_name) AS "Count of Last Name"
FROM Employees
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;

--Create a partial index of last_name specifying DESC
DROP INDEX IF EXISTS lastname_index;
CREATE INDEX lastname_index ON Employees (last_name DESC);

EXPLAIN ANALYZE SELECT last_name AS "last name", COUNT(last_name) AS "Count of Last Name"
FROM Employees
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;

--EXTRA Epilogue
--It uses primary key as indexes
EXPLAIN ANALYZE SELECT Employees.emp_no, Departments.dept_no, Departments.dept_name, Employees.emp_title_id,
	Titles.title, Employees.first_name, Employees.last_name, Salaries.salary,
	Employees.sex, Employees.birth_date, Employees.hire_date
FROM Department_Employees
INNER JOIN Departments ON
Departments.dept_no = Department_Employees.dept_no
INNER JOIN Salaries ON
	Salaries.emp_no = Department_Employees.emp_no
INNER JOIN Employees ON
	Employees.emp_no = Department_Employees.emp_no
INNER JOIN Titles ON
Titles.title_id = Employees.emp_title_id
WHERE Employees.emp_no = 499942;
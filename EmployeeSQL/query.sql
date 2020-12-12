-- Data Analysis

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT "emp_no" AS "employee number", "last_name" AS "last name", "first_name" AS "first name",
	"sex", (SELECT "salary" FROM "Salaries" WHERE "Salaries"."emp_no" = "Employees"."emp_no")
FROM "Employees";

--2.List first name, last name, and hire date for employees who were hired in 1986.
SELECT "first_name" AS "first name", "last_name" AS "last name", "hire_date" AS "hire date"
FROM "Employees"
WHERE "hire_date" BETWEEN '1986-01-01' AND '1986-12-31';

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.	
SELECT "Departments"."dept_no" AS "department number", 
	"Departments"."dept_name" AS "department name", "Employees"."emp_no" AS "employee number",
	"Employees"."last_name" AS "last name", "Employees"."first_name" AS "first name"
From "Department_Managers"
INNER JOIN "Employees" ON
	"Employees"."emp_no" = "Department_Managers"."emp_no"
INNER JOIN "Departments" ON
	"Departments"."dept_no" = "Department_Managers"."dept_no";

--4.List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT "Department_Employees"."emp_no" AS "employee number", "Employees"."last_name" AS "last name", 
	"Employees"."first_name" AS "first name", "Departments"."dept_name" AS "department name"
FROM "Department_Employees"
INNER JOIN "Employees" ON
	"Employees"."emp_no" = "Department_Employees"."emp_no"
INNER JOIN "Departments" ON
	"Departments"."dept_no" = "Department_Employees"."dept_no";

--5.List first name, last name, and sex for employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT "first_name" AS "first name", "last_name" AS "last name", "sex"
FROM "Employees"
WHERE "first_name" = 'Hercules'
AND "last_name" LIKE 'B%';

--6.List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT "Employees"."emp_no" AS "employee number", "Employees"."last_name" AS "last name", 
	"Employees"."first_name" AS "first name", 
	"Departments"."dept_name" AS "department name"
FROM "Department_Employees"
INNER JOIN "Employees" ON
"Employees"."emp_no" = "Department_Employees"."emp_no"
INNER JOIN "Departments" ON
"Departments"."dept_no" = "Department_Employees"."dept_no"
WHERE "Departments"."dept_name" = 'Sales';

--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT "Employees"."emp_no" AS "employee number", "Employees"."last_name" AS "last name", 
	"Employees"."first_name" AS "first name", 
	"Departments"."dept_name" AS "department name"
FROM "Department_Employees"
INNER JOIN "Employees" ON
"Employees"."emp_no" = "Department_Employees"."emp_no"
INNER JOIN "Departments" ON
"Departments"."dept_no" = "Department_Employees"."dept_no"
WHERE "Departments"."dept_name" = 'Sales'
OR "Departments"."dept_name" = 'Development';

--8.In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT "last_name" AS "last name", COUNT("last_name") AS "Count of Last Name"
FROM "Employees"
GROUP BY "last_name"
ORDER BY "Count of Last Name" DESC;

--EXTRA Epilogue
SELECT "Employees"."emp_no", "Departments"."dept_no", "Departments"."dept_name", "Employees"."emp_title_id",
	"Titles"."title", "Employees"."first_name", "Employees"."last_name", "Salaries"."salary",
	"Employees"."sex", "Employees"."birth_date", "Employees"."hire_date"
FROM "Department_Employees"
INNER JOIN "Departments" ON
"Departments"."dept_no" = "Department_Employees"."dept_no"
INNER JOIN "Salaries" ON
	"Salaries"."emp_no" = "Department_Employees"."emp_no"
INNER JOIN "Employees" ON
	"Employees"."emp_no" = "Department_Employees"."emp_no"
INNER JOIN "Titles" ON
"Titles"."title_id" = "Employees"."emp_title_id"
WHERE "Employees"."emp_no" = 499942;
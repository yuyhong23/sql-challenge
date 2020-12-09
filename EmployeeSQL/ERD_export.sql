-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/ouAPqJ
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "Departments" (
    "Dept_No" VARCHAR(4)   NOT NULL,
    "Dept_Name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "Dept_No"
     )
);

CREATE TABLE "Department_Employees" (
    "Emp_No" INT(6)   NOT NULL,
    "Dept_No" VARCHAR(4)   NOT NULL,
    CONSTRAINT "pk_Department_Employees" PRIMARY KEY (
        "Emp_No"
     )
);

CREATE TABLE "Department_Managers" (
    "Emp_No" INT(6)   NOT NULL,
    "Dept_No" VARCHAR(4)   NOT NULL,
    CONSTRAINT "pk_Department_Managers" PRIMARY KEY (
        "Emp_No"
     )
);

CREATE TABLE "Employees" (
    "Emp_No" INT(6)   NOT NULL,
    "Emp_Title_ID" VARCHAR(5)   NOT NULL,
    "Birth_Date" DATE   NOT NULL,
    "First_Name" VARCHAR(20)   NOT NULL,
    "Last_Name" VARCHAR(20)   NOT NULL,
    "Sex" VARCHAR(1)   NOT NULL,
    "Hire_Date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Emp_No","Emp_Title_ID"
     )
);

CREATE TABLE "Salaries" (
    "Emp_No" INT(6)   NOT NULL,
    "Salary" INT(6)   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "Emp_No"
     )
);

CREATE TABLE "Titles" (
    "Title_ID" VARCHAR(5)   NOT NULL,
    "Title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "Title_ID"
     )
);

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Departments" ("Dept_No");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_Dept_No" FOREIGN KEY("Dept_No")
REFERENCES "Departments" ("Dept_No");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Department_Employees" ("Emp_No");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Emp_No" FOREIGN KEY("Emp_No")
REFERENCES "Department_Employees" ("Emp_No");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_Title_ID" FOREIGN KEY("Title_ID")
REFERENCES "Employees" ("Emp_Title_ID");


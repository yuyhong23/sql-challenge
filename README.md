# SQL (Postgres) - Employee Database: A Mystery in Two Parts

Data and instructions provided by UC Berkeley Extension Data Analytics Bootcamp.

# Introduction 

The goal of this assignment is to use my newfound PostgreSQL knowledge and skills to do data modeling, engineering and analysis. 

# Technologies/Libraries

  - PostgreSQL
  
  - https://www.quickdatabasediagrams.com/ for data modeling/ERD
  
  - Python Pandas
  
  - Jupyter Notebook
  
  - Conda Environment used: PythonData
  
  - sqlalchemy
  
  - psycopg2
  
  - matplotlib.pyplot

# Detailed Instructions/Assignment Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

###### Part I - Data Modeling:

Inspect the CSVs and sketch out an ERD of the tables.

###### Part II - Data Engineering:

Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

For the primary keys check to see if the column is unique, otherwise create a composite key. Which takes to primary keys in order to uniquely identify a row.
Be sure to create tables in the correct order to handle foreign keys.

Import each CSV file into the corresponding SQL table. Note be sure to import the data in the same order that the tables were created and account for the headers when importing to avoid errors.

###### Part III - Data Analysis:

Once you have a complete database, do the following:

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

2. List first name, last name, and hire date for employees who were hired in 1986.

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

###### Part IV - Bonus (Optional):

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

from sqlalchemy import create_engine
engine = create_engine('postgresql://localhost:5432/<your_db_name>')
connection = engine.connect()

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.

###### Part V - Epilogue (For Fun):

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

# Files

  - EmployeeSQL folder: 
    - ERD.png contains the image of the ERD among tables
    - schema.sql is the schema for setting up the tables
    - query.sql is the queries for data analysis
    - schema&quert.sql is the file that contains both the schema and query (which I used during the process)
    - sql_challenge_bonus.ipynb is the Jupyter Notebook for the Bonus part
  
  - data folder contains the six csv data files

# Process and Credits

My first assignment using PostgreSQL and setting up the connection between PostgreSQL and Jupyter Notebook/Python Language. I used class materials and outside resources for reference. For this assignment, I worked with my classmates more often than any of the previous assignments, and we were able to help each other out whenever we got stuck.

Here are the outside resources that I used for this assignment (as well as attempts):

  - https://www.geeksforgeeks.org/char-vs-varchar-in-sql/
  - https://petri.com/sql-server-string-data-types
  - https://hcmc.uvic.ca/blogs/index.php/how_to_fix_postgresql_error_duplicate_ke?blog=22 (attempted, didn't need it for my problem though)
  - https://dba.stackexchange.com/questions/174231/pgadmin-iii-how-to-merge-output-pane-and-query-pane 
  - https://www.reddit.com/r/PostgreSQL/comments/9ukz4f/cant_get_rid_of_dependents_window_in_pgadmin_4/
  - https://popsql.com/learn-sql/postgresql/how-to-query-date-and-time-in-postgresql
  - https://stackoverflow.com/questions/46452275/postgresql-join-with-multiple-conditions
  - https://blog.panoply.io/connecting-jupyter-notebook-with-postgresql-for-python-data-analysis
  - https://www.psycopg.org/docs/install.html
  - https://pythonspot.com/matplotlib-histogram/
  

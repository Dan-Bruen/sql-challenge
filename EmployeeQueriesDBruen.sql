DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

--Now I need to create tables that will work with the csv files
--Create the 'departments' table
CREATE TABLE departments (
dept_no character varying(45) NOT NULL,
dept_name character varying(45) NOT NULL
);

SELECT * FROM departments;
--import successful

--Create the 'dept_emp' table
CREATE TABLE dept_emp (
emp_no integer NOT NULL,
dept_no VARCHAR NOT NULL,
from_date DATE,
to_date DATE
);

SELECT * FROM dept_emp;
--import successful

--Create the 'dept_manager' table
CREATE TABLE dept_manager (
dept_no VARCHAR NOT NULL,
emp_no integer NOT NULL,
from_date DATE,
to_date DATE
);

SELECT * FROM dept_manager;
--import successful

--Create the 'employees' table
CREATE TABLE employees (
emp_no integer NOT NULL,
birth_date DATE,
first_name character varying(50) NOT NULL,
last_name character varying(50) NOT NULL,
gender character varying(50) NOT NULL,
hire_date DATE
);

SELECT * FROM employees;
--import successful

--Create the 'salaries' table
CREATE TABLE salaries (
emp_no integer NOT NULL,
salary integer NOT NULL,
from_date DATE,
to_date DATE
);

SELECT * FROM salaries;
--import successful

--Create the 'titles' table
CREATE TABLE titles (
emp_no integer NOT NULL,
title character varying(45) NOT NULL,
from_date DATE,
to_date DATE
);

SELECT * FROM titles;
--import successful

-- 1. List employee details: emp #, last name, first name, gender and salary
-- First I need to join salary and employee tables
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
employees.gender,
salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;
--successful

-- 2. List employees who were hired in 1986
SELECT * FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--successful

-- 3. List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, 
--first name, and start and end employment dates.
SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT departments.dept_no,
departments.dept_name,
dept_manager.emp_no,
employees.last_name,
employees.first_name,
dept_manager.from_date,
dept_manager.to_date
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;
--successful

-- 4. List the department of each employee with the following information: employee number, 
--last name, first name, and department name
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no;
--successful

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';
--successful

-- 6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name LIKE 'Sales';
--successful

-- 7. List all employees in the Sales and Development departments, including 
--their employee number, last name, first name, and department name
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name LIKE 'Sales'
OR departments.dept_name LIKE 'Development';
--successful

-- 8. In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name
SELECT last_name, COUNT(last_name) AS "Last Names"
FROM employees
GROUP BY last_name
ORDER BY "Last Names" DESC;
--successful

-- Bonus

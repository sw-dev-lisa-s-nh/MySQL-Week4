
--
-- MySQL Week 4 Coding Assignment
-- Promineo Tech BESD Coding Bootcamp
-- Tests
--
-- Author:  Lisa Maatta Smith

USE employees;


--
-- Test Procedure #1 with 4 Different Department Names (One doesn't exist)
--
--   Procedure:  get_emp_count_by_dept()
--


--  "Marketing", and an output variable var_amount.
SET @var_name = "Marketing";
CALL GetEmpCountByDept(@var_name, @var_amount);
SELECT @var_amount AS "Employees Count in", @var_name AS "Department";


--  "Sales"
SET @var_name = "Sales";
CALL GetEmpCountByDept(@var_name, @var_amount);
SELECT @var_amount AS "Employees Count in",  @var_name AS "Department";


--  "Development"
SET @var_name = "Development";
CALL GetEmpCountByDept(@var_name, @var_amount);
SELECT @var_amount AS "Employees Count in", @var_name AS "Department";
	   
--  "Janitorial"
SET @var_name = "Janitorial";
CALL GetEmpCountByDept(@var_name, @var_amount);
SELECT @var_amount AS "Employees Count in", @var_name AS "Department";
	   
-- 
-- Test Procedure #2:  CalculateRaise();
--  
--  Calculate the New Salary based on a percent and an employee's current max(salary). 
--

SELECT max(salary) FROM salaries 
WHERE emp_no = 10058;

CALL CalculateRaise (10058, 20, @currentSalary);
SELECT @currentSalary AS "New Salary";





-- 
-- Test Procedure #3:  AddNewEmployee() & DeleteEmployee()
--  
--  Add a new employee to the employees database, 
--  	with records in:  employees, salaries, titles, and dept_emp tables
--  NOTE:  to avoid adding the same employee more than once, a check is done
--  to see if the employee already exists... and is not re-added if so.
-- 


SELECT max(emp_no) FROM employees;

--
-- Test AddEmployee(), inserting the following 6 employees!
--

CALL AddNewEmployee("2000-01-01", "Mickey", "Mouse", 'M', "2020-01-01", "d005", 85000, "Engineer",@error);
CALL AddNewEmployee("2000-02-03", "Minnie", "Mouse", 'F', "2020-02-03", "d001", 86000, "Staff",@error);
CALL AddNewEmployee("2000-03-03", "Daffy", "Duck", 'M', "2020-03-03", "d002", 87000, "Staff",@error);
CALL AddNewEmployee("2000-04-03", "Daisy", "Duck", 'F', "2020-04-03", "d003", 88000, "Manager",@error);
CALL AddNewEmployee("2000-04-04", "Pluto", "Dog", 'M', "2020-04-04", "d004", 89000, "Technique Leader",@error);
CALL AddNewEmployee("2000-05-05", "Tinkerbell", "Fairy", 'F', "2020-05-05", "d005", 90000, "Senior Engineer",@error);

SELECT max(emp_no) FROM employees;

SELECT * FROM titles WHERE emp_no > 499999;
SELECT * FROM dept_emp WHERE emp_no > 499999;
SELECT * FROM employees WHERE emp_no > 499999;
SELECT * FROM salaries WHERE emp_no > 499999;

--
-- Test DeleteEmployee() on emp_no = 500005
--

SELECT * FROM employees WHERE emp_no > 499999;
SELECT * FROM employees WHERE emp_no = 500005;
CALL DeleteEmployee(500005,@error);
SELECT * FROM employees WHERE emp_no > 499999;
SELECT @error AS "Delete Successful (1-TRUE, 0-FALSE)";

SELECT * FROM employees WHERE emp_no = 500005;
CALL DeleteEmployee(500005,@error);
SELECT * FROM employees WHERE emp_no > 499999;
SELECT @error AS "Delete Successful (1-TRUE, 0-FALSE)";


-- 
-- Test Procedure #4: SalaryPerCalendarYear();
--  
--  Figure out the salary for a particular calendar year, 
--     pro-rating the salary by the days of the year in that salary.
--


-- 
-- Test Example 1:  Employee Id:  10058, Department:  "Marketing", Year:  1990
--

SET @var_dept_name = "Marketing";
SET @salary_per_year = 00000.00;
SET @emp_no = 10058;
SET @cal_year = 1990;
CALL SalaryPerCalendarYear(@emp_no,@cal_year,@var_dept_name,@salary_per_year);
SELECT  @emp_no AS "Employee Id:", @cal_year AS "For the year:", @var_dept_name AS "Department Name:", FORMAT(@salary_per_year,2) AS "Pro-rated Salary:";


-- 
-- Test Example 2:  Employee Id:  10058, Department:  "Development", Year:  1990
--

SET @var_dept_name = "Development";
CALL SalaryPerCalendarYear(@emp_no,@cal_year,@var_dept_name,@salary_per_year);
SELECT  @emp_no AS "Employee Id:", @cal_year AS "For Calendar Year:", @var_dept_name AS "Department Name:",FORMAT(@salary_per_year,2) AS "Pro-rated Salary:";

--
-- Test Example 3:  Employee Id:  10058, Department:  "Janitorial", Year:  1990
-- Try with a department that DOES NOT exist!
--

SET @var_dept_name = "Janitorial";
CALL SalaryPerCalendarYear(@emp_no,@cal_year,@var_dept_name,@salary_per_year);
SELECT  @emp_no AS "Employee Id:", @cal_year AS "For Calendar Year:", @var_dept_name AS "Department Name:",FORMAT(@salary_per_year,2) AS "Pro-rated Salary:";


-- 
-- Test Procedure #5: UpdateEmploymentRecord();
--  
--  Change an employee from one department to new one, update old & insert new
--
--
-- Change one of these employees to a different department
--
--
-- Test Example #1:   employee #500000 -- Old Dept "d005" to New Dept "d001"
--


CALL UpdateEmploymentRecord(500000,"d005","d001",CURDATE(),@error);
SELECT * FROM dept_emp WHERE emp_no > 499999;
SELECT * FROM employees WHERE emp_no > 499999;

--
-- Test Example #2  emp_no = 500001, Old Dept "d001" to New Dept "d005"
--

CALL UpdateEmploymentRecord(500001,"d001","d005",CURDATE(),@error);
SELECT * FROM dept_emp WHERE emp_no > 499999;
SELECT * FROM employees WHERE emp_no > 499999;


--
-- End of MySQL Week 4 Coding Assignment Tests
--








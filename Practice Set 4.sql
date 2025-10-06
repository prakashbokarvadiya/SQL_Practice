use abc;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Experience INT,
    City VARCHAR(50)
);

INSERT INTO Employee (EmpID, EmpName, Department, Salary, Experience, City) VALUES
(1, 'Rahul', 'IT', 60000, 5, 'Ahmedabad'),
(2, 'Sneha', 'HR', 50000, 3, 'Surat'),
(3, 'Amit', 'IT', 75000, 7, 'Ahmedabad'),
(4, 'Priya', 'Finance', 65000, 6, 'Vadodara'),
(5, 'Kunal', 'IT', 55000, 2, 'Surat'),
(6, 'Rina', 'HR', 48000, 1, 'Ahmedabad'),
(7, 'Mehul', 'Finance', 70000, 4, 'Rajkot'),
(8, 'Nisha', 'IT', 80000, 8, 'Ahmedabad'),
(9, 'Yash', 'Marketing', 45000, 2, 'Vadodara'),
(10, 'Disha', 'Marketing', 47000, 3, 'Surat');


#1 Find employees who earn more than the average salary of all employees.
select  EmpID,EmpName,Salary 
from Employee
where Salary >(select avg(salary) from employee );

#2 Find employees from departments that have more than 2 employees.
select  EmpName,Department
from Employee
where Department IN(select Department from employee group by Department having count(*)>2);

# 3 Find the highest-paid employee from the 'IT' department.
select EmpName,Salary
from employee
where Salary =(select max(Salary) from employee where Department='IT' );

# 4 List employees who work in the same city as 'Sneha'.
select EmpName,City
from employee
where City=(select City from employee where EmpName='Sneha');

# 5 List employees who have more experience than the average experience.
 select EmpName,Experience
 from employee
 where Experience >(select avg(Experience) from employee);
 
 #6  Count the number of employees in each department.
select  Department,count(Department) as Total_Employee
from Employee
group by Department;


# 7 Find the average salary in each department
select Department ,avg(salary) as average_salary
from employee
group by Department;

# 8 Find departments having more than 2 employees. 
select Department, count(Department)
from employee
group by Department
having count(Department)>2;

# 9 Find departments where average salary is more than 60000.
select Department ,avg(Salary) as AVG_salary
from employee
group by Department
having avg(Salary)>60000;

#10 Find city-wise total salary of employees.
select City ,count(City)
from employee
group by City;

#11 Find departments where total salary is more than total salary of 'HR'.
SELECT Department, SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY Department
HAVING SUM(Salary) > (
    SELECT SUM(Salary)
    FROM Employee
    WHERE Department = 'HR'
);

# 12 Find employees whose salary is above the average salary of their own department. 
SELECT EmpName, Salary, Department
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE Department = e.Department
);

# 13 List departments where the maximum salary is above 75000.
select EmpName,Department,Salary
from employee
where Department IN	(select Department
					from employee
					group by Department 
					having max(Salary)>75000)
;

# 14 List cities where more than one department is present.
SELECT city
FROM employee
GROUP BY city
HAVING COUNT(DISTINCT department) > 1;

# 15 Find top 1 highest paid employee in each department.
SELECT EmpName, Department, Salary
FROM employee e
WHERE Salary = (
    SELECT MAX(Salary)
    FROM employee
    WHERE Department = e.Department
);






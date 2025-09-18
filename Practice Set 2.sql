#id name salary date 

create database abc;
use abc;
create table emp (
e_id int  primary key,
e_name varchar(50),
salary int ,
hire_date date,
d_id int
);
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

insert into emp (e_id,e_name,salary,hire_date,d_id) values
(1, 'amit',   60000, '2001-01-15', 101),
(2, 'Ravi',   75000, '2021-03-10', 101),
(3, 'Sita',   50000, '2019-07-23', 102),
(4, 'Meena',  90000, '2022-11-05', 103),
(5, 'Raj',    75000, '2021-06-12', 102),
(6, 'Nitin',  45000, '2020-08-18', 101),
(7, 'Pooja',  60000, '2023-02-01', 103),
(8, 'Arun',   80000, '2021-12-20', 104),
(9, 'Kiran',  90000, '2018-05-15', 103),
(10,'Level',  50000, '2022-09-09', 104);
insert into emp values(11,'Level',  50000, '2022-09-09', 104);

INSERT INTO department (dept_id, dept_name) VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'IT'),
(104, 'Sales');


# 1 Second Highest Salary निकालो employee table से।
# 1 Find the second highest salary from the employee table.
select e_name,salary 
from emp 
where salary=(select max(salary)from emp where salary<(select max(salary) from emp));

# 2 Department-wise average salary निकालो और सिर्फ उन departments को दिखाओ जहाँ avg salary > 50000 है।
# 2 Get the department-wise average salary and show only those departments where avg salary > 50000.
select d_id,avg(salary)
from emp
group by d_id
having avg(salary)>50000;



# 3 Employee table में duplicate records ढूँढो (by e_name and salary)।
# 3 Find duplicate records in the employee table (by e_name and salary).
select e_name,salary ,count(*)
from emp
group by e_name,salary
having  count(*)>1;

# 4          एक query लिखो जिससे पता चले कि किस department में सबसे ज्यादा employees हैं।
# 4 Write a query to find the department with the maximum number of employees.
select d.dept_name,d.dept_id ,count(d.dept_id) as totalemp
from department d
left join emp e
ON d.dept_id=e.d_id
group by d.dept_name,d.dept_id
order by totalemp desc
limit 1 ;

# 5 Get the employees whose salary is greater than their department’s average salary.
# 5 Employees जिनकी salary department average से ज्यादा है, उन्हें निकालो।
select e.e_name,e.salary,e.d_id
from emp e
where e.salary >(
select avg(e2.salary)
from emp e2 
where e2.d_id=e.d_id);

# 6 Write a query to show only the employees whose names are palindromes (e.g., "Nitin", "Level").
# 6 a एक query लिखो जो सिर्फ palindrome employee names (जैसे "Nitin", "Level") दिखाए। 
select e_id,e_name
from emp 
where lower(e_name)=lower(reverse(e_name));

# 7 Orders table से हर customer का second latest order date निकालो।
# 7 From the orders table, get each customer’s second latest order date.
SELECT customer_id, order_date
FROM (
    SELECT customer_id, order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
) t
WHERE rn = 2;


# Find the 3rd highest salary from employee table.

select e_name ,salary
from (select e_name,salary,
		dense_rank() over(order by salary desc) as rnk
        from emp
	)t
where rnk=3;


select e_name,salary
from emp
where salary=(select max(salary) from emp where salary<(select max(salary) from emp where salary<(select max(salary) from emp)));

#Write a query to display employees who joined in the year 2021. 
select e_name ,hire_date
from emp 
where 2022=year(hire_date);

# Write a query to find employees who do not belong to any department.
select e_name,d_id  
from emp
where isnull(d_id);

#Get the highest salary employee from each department.
select e_name ,salary,d_id
from emp
where (d_id,salary) in (select d_id,max(salary)
				from emp
                group by d_id);

#Find the total salary paid department-wise, but only for departments having more than 2 employees.
# x " हर department की कुल salary दिखाओ, लेकिन सिर्फ उन departments के लिए जिनमें 2 से ज्यादा employees हैं।"
select d_id,sum(salary)
from emp
group by d_id
having count(*)>2;

# Write a query to find employees whose name starts and ends with the same letter.
select e_name 
from emp 
where  left(e_name,1)=right(e_name,1);

#From orders table, find each customer’s total number of orders and their latest order date.
select d_id,count(*),max(hire_date)
from emp
group by d_id
;



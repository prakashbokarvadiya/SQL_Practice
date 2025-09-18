create database usb;
use usb;
create table emp (
e_id int primary key ,
e_name varchar(50),
department varchar(20),
salary int);

insert into emp values(1,"abhik","IT",30000);
insert into emp values
(2,'paresh','hr',50000),
(3,'prakash','finance',40000),
(4,'suresh','IT',50000);
select e_name ,department from emp;
select e_name ,department ,salary from emp where salary >40000;
select * from emp order by salary asc;
select * from emp order by salary desc;
select * from emp order by salary desc limit 2;
select count(*) as totalemployees from emp;
select max(salary) as maxsalary from emp;
select e_name ,avg(salary) as avgsalary from emp group by e_name;
select  max(salary) as maxsalary from emp ;
select min(salary) as minsalary from emp ;
select sum(salary) as totalsalary from emp;

select department ,avg(salary) 
from emp
 group by department;
 
 select department, avg(salary)
 from emp 
 group by department
 having avg(salary)>40000;
 
 SET SQL_SAFE_UPDATES=0;
 
UPDATE emp               
SET salary = salary + 1000  
WHERE department = 'IT'; 

DELETE FROM emp
where e_id=4;  
select * from emp;
insert into emp values(4,"hello",'IT',65000);


create table departments (
d_id int Primary key,
d_name varchar(50),
city varchar(50));

insert into departments values
(1,'IT','ahemedabad'),
(2,'hr','surat'),
(3,'finance','palanpur');
select * from departments;

# Inner Join: matching rows
select e.e_name,d.d_name
from emp e
INNER JOIN departments d
ON e.e_id=d.d_id;

select e.e_name,d.d_name,city
from emp e
left join departments d
on e.department =d.d_name;

select e.e_name ,d.d_name 
from emp e
right join departments d
on e.department =d.d_name 
where e.e_name like 'a%';

select * 
from emp 
where salary = (select max(salary) from emp);

select * 
from emp 
where salary > (select avg(salary) from emp);

insert into emp values
(5,"abc",'IT',75000);

select *,
CASE 
	when salary >70000 then "high"
	when salary between 50000 and 70000 then 'midium'
	else 'low'
end as salarycatagary
from emp;

select *,
case
	when salary between 30000 and 40000 then 'low'
    else 'high'
end as salarycatagary
from emp ;

insert into emp values
(6,'xyz','hr',90000),
(7,'suresh','IT',45000);

update departments 
set city ='mumbai'
where d_id=3;
select * from departments;




#####################################################################################################################################################################
select e.e_name ,d.d_name
from emp e
left join departments d
on e.department  = d.d_name;

SELECT 
    e.emp_name AS Employee,
    m.emp_name AS Manager
FROM Employees e
LEFT JOIN Employees m
    ON e.manager_id = m.emp_id;

select e.e_name,d.d_name
from emp e
outer join departments d
on e.department = d.d_name ;

select e_name ,salary
from emp
where salary >(select avg(salary) from emp);

select e_name 
from emp
where salary>(select avg(salary) from departments);

select e.e_name,d.d_name  
from emp e
join departments d
ON e.department =d.d_name
where e.department='IT'
union
select e.e_name,d.d_name 
from emp e
join  departments d
on e.department =d.d_name 
where e.department='hr';

select d.d_name, count(e.department) as totalemp
from departments d
left join emp e
ON d.d_name =e.department
group by d.d_name;

select d.d_name, count(e.department) as totalemp
from departments d
left join emp e
ON d.d_name =e.department
group by d.d_name 
having totalemp>3;

select d.d_name ,sum(salary) as totalsalary
from departments d
left join emp e
on d.d_name =e.department
group by d.d_name with rollup;

create table student(
s_id int primary key,
s_name varchar(50) unique,
age int check(age>=18),
dept_id int ,
foreign key (dept_id)references departments(d_id)
);
create table students(
s_id int primary key,
s_name varchar(50) unique,
age int check(age>=18),
d_id int,
foreign key (d_id) references departments (d_id)
);

create view list1 as
select e_name ,salary from emp;

DELIMITER  $$
create procedure getsalary (IN p_dept_id int)
begin
	select e_name, salary,department from emp
    where department =p_dept_id 
    ;
end $$
DELIMITER ;

call usb.getsalary(1);


select col_name ,count(*) as new_col_name 
from tabel_name 
group by col_name
having count(*)>1;
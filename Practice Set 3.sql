use abc;
show tables;
select * from department ;
select * from emp;
drop database usb;
use usb;
drop table emp;
show tables;
drop table student;
show databases;

select d_id,sum(salary)
from emp
group by d_id
having count(e_id) > 2;

SELECT DISTINCT salary
FROM emp
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

SELECT *
FROM emp
WHERE YEAR(hire_date) = 2021;

ALTER TABLE emp 
CHANGE COLUMN hire_date join_date date;



SELECT customer_id,
       COUNT(order_id) AS total_orders,
       MAX(order_date) AS latest_order_date
FROM orders
GROUP BY customer_id;




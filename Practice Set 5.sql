create database collage;
use collage;
CREATE TABLE Students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
age INT,
class VARCHAR(20),
city VARCHAR(30)
);

create table teachers(
teacher_id int primary key auto_increment,
teacher_name varchar(50),
department varchar(30),
salary decimal(10,2)
);

create table Courses(
course_id int primary key auto_increment,
couser_name varchar(50),
teacher_id int,
foreign key (teacher_id) references teachers(teacher_id)
);

create table enrollments(
enrollment_id int primary key auto_increment,
student_id int,
course_id int,
greade varchar(5),
fees decimal(10,2),
foreign key (student_id) references Students(student_id),
foreign key (course_id) references Courses(course_id)

);
insert into Students (name,age,class,city) values
('Amit Shah',17,'10th','Ahmedabad'),
('Priya Patel', 19, '12th', 'Surat'),
('Ravi Mehta', 18, '11th', 'Baroda'),
('Neha Singh', 20, 'BSc', 'Ahmedabad'),
('Karan Joshi', 16, '9th', 'Delhi'),
('Sneha Rao', 21, 'BCom', 'Surat'),
('Manish Jain', 22, 'BSc', 'Baroda'),
('Alok Verma', 17, '10th', 'Ahmedabad'),
('Divya Desai', 18, '12th', 'Surat'),
('Rahul Shah', 19, 'BSc', 'Ahmedabad')
;
INSERT INTO Teachers (teacher_name, department, salary) VALUES
('Mr. Sharma', 'Mathematics', 45000),
('Mrs. Iyer', 'Science', 48000),
('Mr. Khan', 'Computer Science', 52000),
('Ms. Patel', 'English', 40000),
('Mr. Gupta', 'Commerce', 55000);

INSERT INTO Courses (course_name, teacher_id) VALUES
('Mathematics', 1),
('Physics', 2),
('Chemistry', 2),
('Computer Science', 3),
('English Literature', 4),
('Accounting', 5);

INSERT INTO Enrollments (student_id, course_id, grade, fees) VALUES
(1, 1, 'A', 20000),
(2, 1, 'B', 18000),
(3, 2, 'A', 22000),
(4, 3, 'C', 25000),
(5, 4, 'B', 15000),
(6, 5, 'A', 23000),
(7, 6, 'B', 24000),
(8, 1, 'A', 19000),
(9, 2, 'C', 21000),
(10, 4, 'A', 26000);


-- 1. Display all students from Ahmedabad.
select * 
from Students
where city ='Ahmedabad';


-- 2. Find all courses taught by "Mr. Sharma".
select c.course_name,t.teacher_name
from courses c
join teachers t 
on t.teacher_id=c.teacher_id
where t.teacher_name='Mr. Sharma';

-- 3. Get details of students older than 18.
select * 
from Students
where age<18;
-- 4. Show all teachers in "Computer Science" department.
select teacher_name
from teachers t
join courses c
on c.teacher_id = t.teacher_id
where t.department='Computer Science';
-- 5. List all enrollments where fees > 20000.
select *
from enrollments
where fees>20000;

-- 6. Display students ordered by name ASC.
select *
from students
order by name asc;

-- 7. Display teachers ordered by salary DESC.
select * 
from teachers
order by salary desc;


-- 8. List courses ordered by course_name ASC.
select *
from courses
order by course_name asc;


-- 9. Find students aged between 15 and 20.
select * 
from students
 where age between 15 and 20;

-- 10. Show teachers with salary between 30000 and 50000.
select * 
from teachers 
where salary between 30000 and 50000;


-- 11. List enrollments with fees between 10000 and 25000.
select *
from enrollments 
where fees between 10000 and 25000;


-- 12. Show students from cities ('Ahmedabad','Surat','Baroda').
select * 
from students 
where city in('Ahmedabad','Surat','Baroda');


-- 13. Find students NOT from 'Delhi'.
select * 
from students 
where city not in ('Delhi');


-- 14. List teachers from departments in ('Maths','Science').
 select *
 from teachers
 where department in ('Mathematics','Science');
 
 
-- 15. Count total number of students.
select count(student_id) as total_student
from students;


-- 16. Find average age of students.
select avg(age) as average_age
from students;


-- 17. Find total fees collected from enrollments.
select sum(fees) as total_fees
from enrollments;


-- 18. Count how many courses are offered.
SELECT COUNT(*) AS total_courses
FROM courses;
 
-- 19. Find average salary of teachers.
select avg(salary) as avg_salary
from teachers;


-- 20. Find maximum fees paid by a student.
select max(fees)
from  enrollments ;


-- 21. Count number of students in each city.
select city,count(city)
from students
group by city;


-- 22. Find total fees collected per course.
select c.course_name,sum(e.fees)
from courses c
join enrollments e
on c.course_id=e.course_id
group by c.course_name;


-- 23. Find average salary department-wise.
select department,avg(salary)
from teachers
group by department;

-- 24. Count students per class, only show classes having more than 10 students.
select class
from students 
group by class
having count(class)>10;


-- 25. Find teachers per department, only show departments with more than 5 teachers.
select department
from teachers 
group by department
having count(department) >5;


-- 26. Find courses with average fees > 15000.
SELECT c.course_name,avg(e.fees) as avg_fees
from courses c
join enrollments e
on e.course_id=c.course_id
group by e.course_id
having avg(e.fees)>15000;


-- 27. Find cities having more than 3 students enrolled.
select city
from students
group by city
having count(city)>3;

-- 28. Display student name with their enrolled course name.
select s.name,c.course_name
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;


-- 29. Show course name with teacher name.
select c.course_name ,t.teacher_name
from courses c
join teachers t
on t.teacher_id=c.teacher_id;


-- 30. List student name, course name, and fees.
select s.name,c.course_name,e.fees
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;


-- 31. Find all students with their grades in each course.
select s.name,e.grade,c.course_name
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;


-- 32. Display teacher name with course name they teach.
select t.teacher_name,c.course_name
from teachers t
join courses c on t.teacher_id=c.teacher_id;


-- 33. Show students who have not enrolled in any course (LEFT JOIN).
select s.name 
from students s
left join enrollments  e
on s.student_id=e.student_id
where e.student_id is null;

-- 34. Show courses with no students enrolled (RIGHT JOIN).
select c.course_name
from enrollments e
right join courses c
on c.course_id=e.course_id
where e.course_id is null;

-- 35. Display student-city wise courses.
select s.name,city,c.course_name
from students s
join enrollments e on e.student_id=s.student_id
join courses c on e.course_id =c.course_id 
order by c.course_name asc
;
-- 36. Show course wise student count using join.
select c.course_name,count(e.course_id) as total_students
from courses c
join enrollments e on c.course_id=e.course_id
group by e.course_id,c.course_name;
-- 37. List teachers and students connected through courses.
select t.teacher_name,s.name,c.course_name
from students s
join enrollments e on e.student_id=s.student_id
join courses c on e.course_id=c.course_id
join teachers t on c.teacher_id=t.teacher_id;


-- 38. Find students who enrolled in course 'Mathematics'.
select s.name
from students s
join enrollments e on e.student_id=s.student_id
join courses c on e.course_id=c.course_id
where c.course_name='Mathematics';


-- 39. List teachers who teach at least one course.
select t.teacher_name
from teachers t
join courses c on t.teacher_id=c.teacher_id
group by t.teacher_id,t.teacher_name 
;


-- 40. Find students who paid fees more than average fees.
select s.name
from students s 
join enrollments e on e.student_id=s.student_id
group by s.student_id,s.name
having sum(e.fees)>(select avg(fees) from enrollments)
;

-- 41. Show students who enrolled in more than 2 courses
SELECT 
    s.name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM 
    students s
JOIN 
    enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.student_id, s.name
HAVING 
    COUNT(e.course_id) > 2;

-- 42. Find teachers whose salary is greater than average salary of all teachers.
select teacher_name,salary
from teachers 
where salary>(select avg(salary) from teachers);


-- 43. Create a view StudentFeesView showing student name, course, and fees.
create or replace view StudentFeesView as
select s.name,c.course_name,e.fees
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;
select * from StudentFeesView;

-- 44. Create a view TeacherSalaryView showing teacher_name and salary.
create view TeacherSalaryView as
select teacher_name,salary
from teachers;
select * from TeacherSalaryView;

-- 45. Create a view CourseStatsView with course, total students enrolled.
create or replace view CourseStatsView as
select c.course_name,count(e.course_id)
from courses c
join enrollments e on c.course_id=e.course_id
group by c.course_name,e.course_id
;
select * from CourseStatsView;
-- 46. Create a view CityWiseStudents showing city and count of students.
 Create  view CityWiseStudents as 
 select city,count(city)
 from students
 group by city;
 select * from CityWiseStudents;
 
 
-- 47. Create a view HighFeesStudents for students paying fees > 20000.
create view HighFeesStudents as
select s.name,e.fees
from students s
join enrollments e on s.student_id=e.student_id
where e.fees>20000;
select * from HighFeesStudents;


-- 48. Find course-wise average fees, only show courses having avg fees > 20000.
select c.course_name,avg(e.fees) as avg_fees
from courses c
join enrollments e on c.course_id=e.course_id
group by e.course_id,c.course_name
having avg(e.fees)>20000;

-- 49. Display teacher name and total number of students under them.
select t.teacher_name,count(e.student_id) as total_student
from teachers t
join courses c on c.teacher_id=t.teacher_id
join enrollments e on c.course_id=e.course_id
group by t.teacher_name;

-- 50. Find city-wise total fees collected, order by highest to lowest.
select s.city,sum(e.fees) as total_fees
from students s
join enrollments e
group by s.city
order by total_fees desc;

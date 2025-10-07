create database collage;
use collage;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    class VARCHAR(20),
    city VARCHAR(30)
);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10 , 2 )
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id)
        REFERENCES teachers (teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    greade VARCHAR(5),
    fees DECIMAL(10 , 2 ),
    FOREIGN KEY (student_id)
        REFERENCES Students (student_id),
    FOREIGN KEY (course_id)
        REFERENCES Courses (course_id)
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
SELECT 
    *
FROM
    Students
WHERE
    city = 'Ahmedabad';


-- 2. Find all courses taught by "Mr. Sharma".
SELECT 
    c.course_name, t.teacher_name
FROM
    courses c
        JOIN
    teachers t ON t.teacher_id = c.teacher_id
WHERE
    t.teacher_name = 'Mr. Sharma';

-- 3. Get details of students older than 18.
SELECT 
    *
FROM
    Students
WHERE
    age > 18;
-- 4. Show all teachers in "Computer Science" department.
SELECT 
    teacher_name
FROM
    teachers t
        JOIN
    courses c ON c.teacher_id = t.teacher_id
WHERE
    t.department = 'Computer Science';
-- 5. List all enrollments where fees > 20000.
SELECT 
    *
FROM
    enrollments
WHERE
    fees > 20000;

-- 6. Display students ordered by name ASC.
SELECT 
    *
FROM
    students
ORDER BY name ASC;

-- 7. Display teachers ordered by salary DESC.
SELECT 
    *
FROM
    teachers
ORDER BY salary DESC;


-- 8. List courses ordered by course_name ASC.
SELECT 
    *
FROM
    courses
ORDER BY course_name ASC;


-- 9. Find students aged between 15 and 20.
SELECT 
    *
FROM
    students
WHERE
    age BETWEEN 15 AND 20;

-- 10. Show teachers with salary between 30000 and 50000.
SELECT 
    *
FROM
    teachers
WHERE
    salary BETWEEN 30000 AND 50000;


-- 11. List enrollments with fees between 10000 and 25000.
SELECT 
    *
FROM
    enrollments
WHERE
    fees BETWEEN 10000 AND 25000;


-- 12. Show students from cities ('Ahmedabad','Surat','Baroda').
SELECT 
    *
FROM
    students
WHERE
    city IN ('Ahmedabad' , 'Surat', 'Baroda');


-- 13. Find students NOT from 'Delhi'.
SELECT 
    *
FROM
    students
WHERE
    city NOT IN ('Delhi');


-- 14. List teachers from departments in ('Maths','Science').
SELECT 
    *
FROM
    teachers
WHERE
    department IN ('Mathematics' , 'Science');
 
 
-- 15. Count total number of students.
SELECT 
    COUNT(student_id) AS total_student
FROM
    students;


-- 16. Find average age of students.
SELECT 
    AVG(age) AS average_age
FROM
    students;


-- 17. Find total fees collected from enrollments.
SELECT 
    SUM(fees) AS total_fees
FROM
    enrollments;


-- 18. Count how many courses are offered.
SELECT 
    COUNT(*) AS total_courses
FROM
    courses;
 
-- 19. Find average salary of teachers.
SELECT 
    AVG(salary) AS avg_salary
FROM
    teachers;


-- 20. Find maximum fees paid by a student.

SELECT 
    s.name, e.fees
FROM
    students s
        JOIN
    enrollments e ON e.student_id = s.student_id
WHERE
    e.fees = (SELECT 
            MAX(fees)
        FROM
            enrollments);


-- 21. Count number of students in each city.
SELECT 
    city, COUNT(city)
FROM
    students
GROUP BY city;


-- 22. Find total fees collected per course.
SELECT 
    c.course_name, SUM(e.fees)
FROM
    courses c
        JOIN
    enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;


-- 23. Find average salary department-wise.
SELECT 
    department, AVG(salary)
FROM
    teachers
GROUP BY department;

-- 24. Count students per class, only show classes having more than 10 students.
SELECT 
    class, COUNT(*) AS total_students
FROM
    students
GROUP BY class
HAVING COUNT(*) > 10;



-- 25. Find teachers per department, only show departments with more than 5 teachers.
SELECT 
    department, COUNT(department)
FROM
    teachers
GROUP BY department
HAVING COUNT(department) > 5;


-- 26. Find courses with average fees > 15000.
SELECT 
    c.course_name, AVG(e.fees) AS avg_fees
FROM
    courses c
        JOIN
    enrollments e ON e.course_id = c.course_id
GROUP BY e.course_id
HAVING AVG(e.fees) > 15000;


-- 27. Find cities having more than 3 students enrolled.
SELECT 
    city
FROM
    students
GROUP BY city
HAVING COUNT(city) > 3;

-- 28. Display student name with their enrolled course name.
SELECT 
    s.name, c.course_name
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
        JOIN
    courses c ON c.course_id = e.course_id;


-- 29. Show course name with teacher name.
SELECT 
    c.course_name, t.teacher_name
FROM
    courses c
        JOIN
    teachers t ON t.teacher_id = c.teacher_id;


-- 30. List student name, course name, and fees.
SELECT 
    s.name, c.course_name, e.fees
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
        JOIN
    courses c ON c.course_id = e.course_id;


-- 31. Find all students with their grades in each course.
SELECT 
    s.name, e.grade, c.course_name
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
        JOIN
    courses c ON c.course_id = e.course_id;


-- 32. Display teacher name with course name they teach.
SELECT 
    t.teacher_name, c.course_name
FROM
    teachers t
        JOIN
    courses c ON t.teacher_id = c.teacher_id;


-- 33. Show students who have not enrolled in any course (LEFT JOIN).
SELECT 
    s.name
FROM
    students s
        LEFT JOIN
    enrollments e ON s.student_id = e.student_id
WHERE
    e.student_id IS NULL;

-- 34. Show courses with no students enrolled (RIGHT JOIN).
SELECT 
    c.course_name
FROM
    enrollments e
        RIGHT JOIN
    courses c ON c.course_id = e.course_id
WHERE
    e.course_id IS NULL;

-- 35. Display student-city wise courses.
SELECT 
    s.name, city, c.course_name
FROM
    students s
        JOIN
    enrollments e ON e.student_id = s.student_id
        JOIN
    courses c ON e.course_id = c.course_id
ORDER BY c.course_name ASC
;
-- 36. Show course wise student count using join.
SELECT 
    c.course_name, COUNT(e.course_id) AS total_students
FROM
    courses c
        JOIN
    enrollments e ON c.course_id = e.course_id
GROUP BY e.course_id , c.course_name;
-- 37. List teachers and students connected through courses.
SELECT 
    t.teacher_name, s.name, c.course_name
FROM
    students s
        JOIN
    enrollments e ON e.student_id = s.student_id
        JOIN
    courses c ON e.course_id = c.course_id
        JOIN
    teachers t ON c.teacher_id = t.teacher_id;


-- 38. Find students who enrolled in course 'Mathematics'.
SELECT 
    s.name
FROM
    students s
        JOIN
    enrollments e ON e.student_id = s.student_id
        JOIN
    courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'Mathematics';


-- 39. List teachers who teach at least one course.
SELECT 
    t.teacher_name
FROM
    teachers t
        JOIN
    courses c ON t.teacher_id = c.teacher_id
GROUP BY t.teacher_id , t.teacher_name
;


-- 40. Find students who paid fees more than average fees.
SELECT 
    s.name
FROM
    students s
        JOIN
    enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id , s.name
HAVING SUM(e.fees) > (SELECT 
        AVG(fees)
    FROM
        enrollments)
;

-- 41. Show students who enrolled in more than 2 courses
SELECT 
    s.name AS student_name, COUNT(e.course_id) AS total_courses
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id , s.name
HAVING COUNT(e.course_id) > 2;

-- 42. Find teachers whose salary is greater than average salary of all teachers.
SELECT 
    teacher_name, salary
FROM
    teachers
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            teachers);


-- 43. Create a view StudentFeesView showing student name, course, and fees.
CREATE OR REPLACE VIEW StudentFeesView AS
    SELECT 
        s.name, c.course_name, e.fees
    FROM
        students s
            JOIN
        enrollments e ON s.student_id = e.student_id
            JOIN
        courses c ON c.course_id = e.course_id;
SELECT 
    *
FROM
    StudentFeesView;

-- 44. Create a view TeacherSalaryView showing teacher_name and salary.
CREATE VIEW TeacherSalaryView AS
    SELECT 
        teacher_name, salary
    FROM
        teachers;
SELECT 
    *
FROM
    TeacherSalaryView;

-- 45. Create a view CourseStatsView with course, total students enrolled.
CREATE OR REPLACE VIEW CourseStatsView AS
    SELECT 
        c.course_name, COUNT(e.course_id) AS total_student
    FROM
        courses c
            JOIN
        enrollments e ON c.course_id = e.course_id
    GROUP BY c.course_name
;
SELECT 
    *
FROM
    CourseStatsView;


-- 46. Create a view CityWiseStudents showing city and count of students.
CREATE VIEW CityWiseStudents AS
    SELECT 
        city, COUNT(city)
    FROM
        students
    GROUP BY city;
SELECT 
    *
FROM
    CityWiseStudents;
 
 
-- 47. Create a view HighFeesStudents for students paying fees > 20000.
CREATE VIEW HighFeesStudents AS
    SELECT 
        s.name, e.fees
    FROM
        students s
            JOIN
        enrollments e ON s.student_id = e.student_id
    WHERE
        e.fees > 20000;
SELECT 
    *
FROM
    HighFeesStudents;


-- 48. Find course-wise average fees, only show courses having avg fees > 20000.
SELECT 
    c.course_name, AVG(e.fees) AS avg_fees
FROM
    courses c
        JOIN
    enrollments e ON c.course_id = e.course_id
GROUP BY e.course_id , c.course_name
HAVING AVG(e.fees) > 20000;

-- 49. Display teacher name and total number of students under them.
SELECT 
    t.teacher_name, COUNT(e.student_id) AS total_student
FROM
    teachers t
        JOIN
    courses c ON c.teacher_id = t.teacher_id
        JOIN
    enrollments e ON c.course_id = e.course_id
GROUP BY t.teacher_name;

-- 50. Find city-wise total fees collected, order by highest to lowest.
SELECT 
    s.city, SUM(e.fees) AS total_fees
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
GROUP BY s.city
ORDER BY total_fees DESC;
SELECT 
    s.city, SUM(e.fees) AS total_fees
FROM
    students s
        JOIN
    enrollments e ON s.student_id = e.student_id
GROUP BY s.city
ORDER BY total_fees DESC;


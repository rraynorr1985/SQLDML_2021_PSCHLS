SELECT d.name AS `Department Name`, COUNT(c.id) as `Number of Courses`
FROM department d
INNER JOIN course c ON c.deptid = d.id
GROUP BY d.name
ORDER BY `Number of Courses` ASC, `Department Name` ASC;



SELECT c.name AS `Course Name`, COUNT(sc.studentId) AS `Number of Students`
FROM course c
JOIN studentcourse sc ON sc.courseId=c.id
GROUP BY c.name
ORDER BY `Number of Students` DESC,`Course Name` ASC;



SELECT c.name AS `Course Name`
FROM course c
LEFT JOIN facultycourse fc ON fc.courseId=c.id
GROUP BY `Course Name`
HAVING COUNT(fc.courseId)=0 
ORDER BY `Course Name`;


SELECT c.name AS `Course Name`, COUNT(sc.studentId) AS `Number of Students`
FROM course c
LEFT JOIN facultycourse fc ON fc.courseId=c.id
LEFT JOIN studentcourse sc ON sc.courseId=c.id
GROUP BY `Course Name`
HAVING COUNT(fc.courseId) = 0 
ORDER BY `Number of Students` DESC,`Course Name`;


SELECT COUNT(DISTINCT(s.studentId)) AS `Students`, DATE_FORMAT(startDate,'%Y') AS `Year`
FROM studentcourse s
GROUP BY `Year`
ORDER BY `Year` ASC,`Students` DESC;


SELECT  s.startDate,COUNT(DISTINCT(s.studentId)) AS `Students`
FROM studentcourse s
GROUP BY s.startDate
HAVING DATE_FORMAT(s.startDate, '%m') = 08
ORDER BY s.startDate ASC,`Students` DESC;

#COUNT(DISTINCT(sc.courseId)) AS `Number of Courses`

SELECT s.firstname AS `First Name`,s.lastname AS `Last Name`, COUNT(c.id) AS `Number of Courses`
FROM student s
INNER JOIN studentcourse sc ON sc.studentId = s.id
LEFT JOIN course c ON c.id = sc.courseId
LEFT JOIN department d ON d.id=c.deptId
WHERE s.majorId=c.deptId 
GROUP BY sc.studentId
ORDER BY `Number of Courses` DESC,`First Name`,`Last Name`;




SELECT s.firstname AS `First Name`, s.lastname AS `Last Name`, (SELECT ROUND(AVG(sc.progress), 1)
FROM studentcourse sc
WHERE s.id=sc.studentId) `Average Progress`
FROM student s
INNER JOIN studentcourse sc ON sc.studentId= s.id
GROUP BY s.id
HAVING `Average Progress`>50
ORDER BY `Average Progress` DESC,`First Name`,`Last Name`;


SELECT courseId, AVG(progress)
FROM studentcourse sc
GROUP BY courseId
HAVING AVG(progress) = (SELECT MAX(SELECT AVG(progress)) FROM studentcourse GROUP BY courseId) GROUP BY courseID);


SELECT MAX(AVG(progress)) FROM studentcourse GROUP BY courseId

SELECT courseId, AVG(progress) AS avgone
FROM studentcourse
GROUP BY courseId
FROM course c


SELECT c.name AS `Course name`, ROUND(AVG(progress),1) AS `Average Student Progress`
	FROM studentcourse sc
	INNER JOIN course c ON sc.courseId=c.id
	GROUP BY courseId 
HAVING AVG(progress) = (SELECT MAX(avgone) FROM (SELECT courseId, AVG(progress) AS avgone
FROM studentcourse sc 
GROUP BY courseId) AS m);


SELECT c.name AS `Course name`, ROUND(AVG(progress),1) AS `Average Student Progress`
FROM studentcourse sc
INNER JOIN course c ON sc.courseId=c.id
GROUP BY sc.courseId
ORDER BY `Average Student Progress` DESC
LIMIT 1;

      

SELECT c.name AS `Course name`, ROUND(AVG(progress),1) AS `Average Student Progress`
FROM studentcourse sc
INNER JOIN course c ON sc.courseId=c.id
GROUP BY sc.courseId
ORDER BY `Average Student Progress` DESC
LIMIT 1;



SELECT f.firstname AS `First Name`,f.lastname AS `Last Name`, ROUND(AVG(sc.progress),1) AS `Average Progress`
FROM studentcourse sc
INNER JOIN facultycourse fc ON fc.courseId=sc.courseId
INNER JOIN faculty f ON fc.facultyId=f.id
GROUP BY fc.facultyId
HAVING AVG(sc.progress)>=((SELECT  max(avg_prg)*0.9
FROM (select courseId, avg(progress) AS avg_prg
   from studentcourse sc
   group by courseId) As maxprg))
ORDER BY `Average progress` DESC,`First Name` ASC,`Last Name` ASC;




SELECT sc.courseId, AVG(sc.progress) AS a
FROM studentcourse sc
WHERE a=(SELECT MAX(SELECT AVG(progress) FROM studentcourse GROUP BY courseID) FROM studentcourse sc)
GROUP BY sc.courseId


SELECT MAX(SELECT AVG(progress) FROM studentcourse GROUP BY courseId) FROM studentcourse

SELECT  max(avg_salary)
from (select courseId, avg(progress) AS avg_salary
      from studentcourse sc
      group by courseId) As maxSalary;

select courseId, avg(progress) AS avg_salary
      from studentcourse sc
      group by courseId;



SELECT AVG(progress) FROM studentcourse GROUP BY courseID

SELECT AVG(sc.progress)
FROM studentcourse sc
GROUP BY sc.courseId


SELECT sc.courseId,AVG(sc.progress) 
FROM studentcourse sc
GROUP BY sc.studentId


SELECT sc.courseId ,AVG()
FROM studentcourse sc
WHERE (SELECT MAX(sc.progress) FROM studentcourse sc)
GROUP BY sc.courseId


SELECT sc.studentId, MAX((SELECT AVG(sc.progress) FROM studentcourse sc GROUP BY sc.studentId))
FROM studentcourse sc
GROUP BY sc.studentId


SELECT sc.studentId, AVG(sc.progress) AS `AV`
FROM studentcourse sc
 GROUP BY sc.studentId


SELECT s.firstname AS `First Name`,s.lastname AS `Last Name`,
CASE 
WHEN MIN(sc.progress)<40 THEN 'F'
WHEN MIN(sc.progress)<50 THEN 'D'
WHEN MIN(sc.progress)<60 THEN 'C'
WHEN MIN(sc.progress)<70 THEN 'B'
WHEN MIN(sc.progress)>=70 THEN 'A'END AS `Minimum Grade`, 
CASE 
WHEN MAX(sc.progress)<40 THEN 'F'
WHEN MAX(sc.progress)<50 THEN 'D'
WHEN MAX(sc.progress)<60 THEN 'C'
WHEN MAX(sc.progress)<70 THEN 'B'
WHEN MAX(sc.progress)>=70 THEN 'A'  END AS `Maximum Grade`
FROM studentcourse sc
INNER JOIN student s ON s.id=sc.studentId
GROUP BY sc.studentId
ORDER BY `Minimum Grade` DESC,`Maximum Grade` DESC,`First Name`,`Last Name`;

SELECT sc.courseId, AVG(sc.progress)
FROM studentcourse sc
GROUP BY sc.courseId;

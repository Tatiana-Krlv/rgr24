-- Проектирование и работа с базой данных
-- Задание 1
-- Спроектировать схему базы данных отражающую следующую информацию о студентах
-- факультета:
-- • ФИО студента
-- • Дата рождения
-- • Адрес проживания (Город, улица, номер дома)
-- • Доступные телефоны для связи (неограниченное количество)
-- • Адрес электронной почты
-- • Группа
-- • Направление обучения
-- • Признак бюджетного/внебюджетного обучения
-- Структура базы данных должна соответствовать третьей нормальной форме и содержать внешние
-- ключи в таблицах.

-- Ответ: create_tables.sql


-- Задание 2
-- Внести информацию о трех направлениях обучения, по каждому направлению внести не менее
-- трех учебных групп, в каждую группу внести не менее 7 студентов (в разные группы разное
-- количество.

-- Ответ: insert_values.sql


-- Задание 3
-- На основании внесенных данных создать следующие запросы:
-- • Вывести списки групп по заданному направлению с указание номера группы в формате 
-- ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.

SELECT Student.full_name AS Full_name, 
		Groups.group_name AS Group_name, 
		CASE
			WHEN Student.budget = TRUE THEN 'Бюджет'
			ELSE 'Внебюджет'
		END AS Budget
FROM Student
JOIN Groups ON Groups.id = Student.group_id
ORDER BY Student.full_name;
 
-- • Вывести студентов с фамилией, начинающейся с первой буквы вашей фамилии, с 
-- указанием ФИО, номера группы и направления обучения. 
SELECT Student.full_name as Full name,
		Groups.group_name as Group name,
        Directions_of_study.direction_name as Direction name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
WHERE Student.full_name LIKE 'К%';

-- • Вывести список студентов для поздравления по месяцам в формате Фамилия И.О., день и 
-- название месяца рождения, номером группы и направлением обучения.
SELECT CONCAT(LEFT(full_name, POSITION(' ' IN full_name)),
       	CONCAT(LEFT(RIGHT(full_name, (CHAR_LENGTH(full_name) - POSITION(' ' IN full_name))), 1), '. '),
		CONCAT(LEFT(RIGHT(full_name, (CHAR_LENGTH(full_name) - POSITION(' ' IN substr(full_name, (POSITION(' ' IN full_name) + 1))))), 1), '.'))
as name,
EXTRACT(DAY FROM Student.date_of_birth) as day,
CASE
	WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 1
    	THEN 'Январь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 2
    	THEN 'Февраль'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 3 
    	THEN 'Март'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 4 
    	THEN 'Апрель'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 5
    	THEN 'Май'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 6
    	THEN 'Июнь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 7 
    	THEN 'Июль'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 8 
    	THEN 'Август'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 9
    	THEN 'Сентябрь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 10
    	THEN 'Октябрь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 11
    	THEN 'Ноябрь'
    ELSE 'Декабрь'
 END AS Month,
Groups.group_name as Group_name,
Directions_of_study.direction_name as Direction_name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
ORDER BY EXTRACT(MONTH FROM Student.date_of_birth); 

-- • Вывести студентов с указанием возраста в годах.
SELECT full_name, (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth)) as Age
FROM student;

-- • Вывести студентов, у которых день рождения в текущем месяце.
SELECT full_name as Name, date_of_birth as Birthday
FROM Student
WHERE EXTRACT(MONTH FROM Student.date_of_birth) = EXTRACT(MONTH FROM CURRENT_DATE);

-- • Вывести количество студентов по каждому направлению.
SELECT COUNT(Student.id) as Students_number, Directions_of_study.direction_name as Direction_name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Directions_of_study.direction_name;

-- • Вывести количество бюджетных и внебюджетных мест по группам. Для каждой группы
-- вывести номер и название направления.
SELECT 
	Groups.group_name, 
    Directions_of_study.direction_name, 
	COUNT(CASE WHEN budget = true THEN 1 ELSE 0 END) as number_of_buget 
FROM Student
	JOIN Groups ON Groups.id = Student.group_id
    JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Groups.id, directions_of_study.id


-- Задание 4
-- Добавить в созданную ранее базу данных информацию о преподавателе, предметах и оценках
-- студентов по этим предметам. Для каждого направления регистрируется свой набор учебных
-- предметов и на каждый назначается преподаватель.
-- По каждому предмету студент может получить одну из оценок: 2,3,4,5 и может не иметь оценки
-- Структура базы данных должна соответствовать третьей нормальной форме и содержать внешние
-- ключи в таблицах.
-- Необходимо внести информацию о 7 различных предметах, которые ведут 5 преподавателей.
-- Каждый преподаватель может вести несколько дисциплин.
-- Для каждого направления необходимо внести информацию минимум о трех предметах. Внести
-- оценки минимум 80% студентов по необходимым предметам.

-- Ответ: create_tables.sql; insert_values.sql 


-- Задание 5
-- • Вывести списки групп по каждому предмету с указанием преподавателя.
SELECT Disciplines.name, Groups.group_name,Teachers.name
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Directions_of_study ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
JOIN Groups ON Groups.direction_id = Directions_of_study.id
JOIN Teachers ON Teachers.id = DirectionDisciplineTeacher.teacher_id

-- • Определить, какую дисциплину изучает максимальное количество студентов.
SELECT Disciplines.name as disc_name, COUNT(Student.full_name) as s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC 
LIMIT 1

-- • Определить сколько студентов обучатся у каждого их преподавателей.
SELECT Teachers.name, COUNT(Student.id) as s_num
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIn Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Student.id = Marks.student_id
GROUP BY Teachers.name

-- • Определить долю ставших студентов по каждой дисциплине (не оценки или 2 считать не
-- сдавшими).
SELECT Disciplines.name as disc_name, COUNT (
    CASE WHEN Marks.mark > 2 THEN 1 ELSE 0 END
) as s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC

-- • Определить среднюю оценку по предметам (для сдавших студентов)
-- • Определить группу с максимальной средней оценкой (включая не сдавших)
SELECT Groups.group_name, AVG(Marks.mark) as average_mark
FROM Groups
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.direction_id = Directions_of_study.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
GROUP BY Groups.group_name
LIMIT 1

-- • Вывести студентов со всем оценками отлично и не имеющих несданный экзамен
SELECT Student.full_name, AVG(Marks.mark)
FROM Student
JOIN Marks ON Marks.student_id = Student.id
GROUP BY Student.full_name
HAVING AVG(Marks.mark) = 5.0;

-- • Вывести кандидатов на отчисление (не сдан не менее двух предметов)
SELECT Student.full_name
FROM Student
JOIN Marks ON Marks.student_id = Student.id
WHERE Marks.mark = 2
GROUP BY Student.full_name
HAVING COUNT(*)>1


-- Задание 6
-- Добавить в созданную ранее базу данных информацию
-- • о времени проведения пар (1 пара с 8:00 до 9:30, 2 пара с 9:40 до 11:10 и т.д.),
-- • посещенных студентом занятиях (с привязкой к дате, номеру пары, назначенному
-- предмету и преподавателю.
-- Необходимо внести информацию о посещении для трех групп из разных направлений.

-- Ответ: create_tables.sql; insert_values.sql


-- Задание 7
-- На основании внесенных данных создать следующие запросы:
-- • Вывести по заданному предмету количество посещенных занятий.
SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = 'Программирование дискретных структур' AND Attendance.presense = true
GROUP BY Attendance.presense;

-- • Вывести по заданному предмету количество пропущенных занятий.
SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = 'Программирование дискретных структур' AND Attendance.presense = false
GROUP BY Attendance.presense;

-- • Вывести по заданному преподавателю количество студентов на каждом занятии.
SELECT COUNT(Attendance.id) as num_presense, DirectionDisciplineTeacher.id
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Teachers.name = 'Шиловский Дмитрий Михайлович' AND Attendance.presense = true
GROUP BY Lessons_shedule.sub_disc_teach_id;
-- • Для каждого студента вывести общее время, потраченное на изучение каждого предмета.

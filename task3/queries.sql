-- Напишите INSERT для заполнения таблиц
INSERT INTO groups (group_id, group_name)
VALUES (1, 'CS-101'),
       (2, 'CS-102'),
       (3, 'MATH-201');

INSERT INTO students (student_id, full_name, age, group_id)
VALUES (1, 'Иванов Иван', 19, 1),
       (2, 'Петрова Мария', 20, 1),
       (3, 'Сидоров Алексей', 21, 2),
       (4, 'Козлова Анна', 19, 2),
       (5, 'Смирнов Дмитрий', 22, 3),
       (6, 'Новикова Елена', 20, 3),
       (7, 'Морозов Сергей Викторович', 21, 3);

INSERT INTO subjects (subject_id, subject_name)
VALUES (1, 'Математика'),
       (2, 'Физика'),
       (3, 'Программирование');

INSERT INTO grades (grade_id, student_id, subject_id, grade)
VALUES (1, 1, 1, 8.2),
       (2, 1, 2, 7.4),
       (3, 2, 1, null),
       (4, 2, 3, 9.5),
       (5, 3, 1, 7.5),
       (6, 3, 3, 8.2),
       (7, 4, 2, null),
       (8, 4, 3, 9.1),
       (9, 5, 1, 9.5),
       (10, 5, 2, 9),
       (11, 6, 1, 8.2),
       (12, 6, 3, null),
       (13, 7, 3, 8.5),
       (14, 1, 3, 9),
       (15, 3, 2, 7.5),
       (16, 5, 3, 10);


-- Подсчитайте количество студентов в университете.
select count(*) as students_amount
from students;


-- Найдите средний возраст студентов.
select cast(avg(age) as decimal(18, 2)) as average_age_of_students
from students;


-- Определите минимальный и максимальный возраст студентов.
select min(age) as minimum_age, max(age) as maximum_age
from students;


-- Подсчитайте, сколько всего оценок выставлено.
select count(*)
from grades
where grade is not null;


-- Подсчитайте, сколько студентов учится в каждой группе.
select g.group_name, count(st.full_name) as total_students
from groups g
         left join students st on st.group_id = g.group_id
group by g.group_name;


-- Найдите средний возраст студентов по каждой группе.
-- select g.group_name, st.full_name
select g.group_name, avg(st.age)
from groups g
         left join students st on st.group_id = g.group_id
group by g.group_name;


-- Определите средний балл по каждому предмету.
select sb.subject_name, cast(avg(gr.grade) as decimal(18, 2))
from grades gr
         left join subjects sb on sb.subject_id = gr.subject_id
-- where gr.grade is not null
group by sb.subject_name;


-- Найдите количество студентов, у которых есть оценки по каждому предмету.
select count(*)
from (select student_id, count(distinct subject_id)
      from grades
      where grade is not null
      group by student_id
      having count(subject_id) = (select count(*) from subjects)) as students_with_grades_from_all_subjects


-- Выведите только те группы, где учится больше 1 студента.
select group_name, count(st.student_id)
from groups gr
         left join students st on gr.group_id = st.group_id
group by group_name
having count(st.student_id) > 1;


-- Покажите предметы, где средний балл выше 8.
select sb.subject_name, cast(avg(gr.grade) as decimal(18, 2))
from subjects sb
         left join grades gr on gr.subject_id = sb.subject_id
group by sb.subject_name
having cast
       (avg(gr.grade) as decimal(18, 2)) > 8;


-- Найдите студентов, у которых средний балл по всем предметам выше 8.5
select st.full_name, cast(avg(gr.grade) as decimal(18, 2))
from grades gr
         left join students st on gr.student_id = st.student_id
where grade is not null
group by st.full_name
having count(distinct gr.subject_id) = (select count(*) from subjects)
   and avg(gr.grade) > 8.5





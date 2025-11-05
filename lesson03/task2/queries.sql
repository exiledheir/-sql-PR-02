-- Напишите INSERT для заполнения таблицы
insert into students(first_name, last_name, birth_date, email, group_id)
values ('Mukhammadjon', 'Kholmukhamedov', '2002-12-30', 'test@gmail.com', 1),
       ('Eshmat', 'Toshmatov', '2012-01-23', 'eshmat@gmail.com', 2),
       ('Mukhammadjon', 'Kholmukhamedov', '2002-12-30', 'test@mail.com', 1),
       ('Eshmat', 'Toshmatov', '2012-01-23', 'toshmat@gmail.com', 2),
       ('Sarvar', 'Tohirov', '2002-01-23', 'sarvar@gmail.com', 1),
       ('Eshmat', 'Sodiqov', '2001-01-23', 'sodiq@gmail.com', 2);


-- Найти дубликаты по имени и фамилии студента
select first_name, last_name
from students
group by first_name, last_name
having count(*) > 1;

-- Удалить дубликаты, оставить только первую запись
delete
from students s
where s.student_id in (select s1.student_id
                       from students s1,
                            students s2
                       where s1.last_name = s2.last_name
                         and s1.first_name = s2.first_name
                         and s1.student_id > s2.student_id)

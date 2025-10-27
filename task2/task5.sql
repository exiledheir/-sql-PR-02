-- Создай таблицы:
-- students (id, name, group_id)
-- groups (id, name, faculty_id)
-- faculties (id, name)
-- courses (id, name, teacher_id)
-- teachers (id, name)
-- student_courses (student_id, course_id, grade)
--
-- Требования:
-- Один студент может учиться на нескольких курсах.
-- Каждому курсу назначен преподаватель.
-- Оценка (grade) — от 1 до 5.

create table faculties
(
    id   serial primary key,
    name text not null
);

create table groups
(
    id         serial primary key,
    name       text   not null,
    faculty_id bigint not null,
    foreign key (faculty_id) references faculties (id)
);

create table students
(
    id       serial primary key,
    name     text   not null,
    group_id bigint not null,
    foreign key (group_id) references groups (id)
);

create table teachers
(
    id   serial primary key,
    name text not null
);

create table courses
(
    id         serial primary key,
    name       text   not null,
    teacher_id bigint not null,
    foreign key (teacher_id) references teachers (id)
);

create table student_courses
(
    student_id bigint not null,
    course_id  bigint not null,
    grade      int check (grade between 1 and 5),
    primary key (student_id, course_id),
    foreign key (student_id) references students (id) on delete cascade,
    foreign key (course_id) references courses (id) on delete cascade
);
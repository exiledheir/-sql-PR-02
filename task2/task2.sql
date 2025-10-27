-- Создай две таблицы:
-- departments (id, название)
-- employees (id, имя, должность, отдел)
--
-- Требования:
-- Один отдел может иметь много сотрудников.
-- Если отдел удаляется — сотрудники должны остаться, но без отдела (NULL).

create table departments
(
    id   serial primary key,
    name text not null
);

create table employees
(
    id            serial primary key ,
    name          text not null,
    position      text not null,
    department_id bigint,
    foreign key (department_id) references departments (id) on delete set null
);

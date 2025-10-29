CREATE TABLE students
(
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    birth_date DATE        NOT NULL,
    email      VARCHAR(100) UNIQUE,
    group_id   INT         NOT NULL
);

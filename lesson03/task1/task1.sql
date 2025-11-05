CREATE TABLE sales
(
    id        SERIAL PRIMARY KEY,
    region    VARCHAR(20),
    amount    BIGINT,
    sale_date DATE
);

INSERT INTO sales (region, amount, sale_date)
VALUES ('North', 1000, '2024-01-01'),
       ('South', 700, '2024-01-02'),
       ('North', 500, '2024-01-03'),
       ('West', NULL, '2024-01-04'),
       ('South', 900, '2024-01-05'),
       ('North', 1500, '2024-01-06');

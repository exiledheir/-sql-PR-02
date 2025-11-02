CREATE TABLE departments
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE employees
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    position      VARCHAR(50),
    salary        NUMERIC(10, 2),
    department_id INTEGER REFERENCES departments (id) ON DELETE SET NULL,
    manager_id    INTEGER REFERENCES employees (id) ON DELETE SET NULL
);

CREATE TABLE customers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE orders
(
    id          SERIAL PRIMARY KEY,
    order_date  DATE NOT NULL,
    amount      NUMERIC(10, 2),
    employee_id INTEGER REFERENCES employees (id) ON DELETE SET NULL,
    customer_id INTEGER REFERENCES customers (id) ON DELETE SET NULL
);

CREATE TABLE products
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2)
);

CREATE TABLE order_items
(
    id         SERIAL PRIMARY KEY,
    order_id   INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products (id) ON DELETE SET NULL,
    quantity   INTEGER NOT NULL
);

INSERT INTO departments (name, location)
VALUES ('Sales', 'Tashkent'),
       ('IT', 'Samarkand'),
       ('HR', 'Bukhara'),
       ('Logistics', 'Namangan'),
       ('Marketing', 'Fergana'),
       ('Finance', 'Andijan');

INSERT INTO employees (name, position, salary, department_id, manager_id)
VALUES ('Ali Karimov', 'Sales Manager', 2500.00, 1, NULL),
       ('Laylo Usmonova', 'Sales Representative', 1500.00, 1, 1),
       ('Jasur Abdullaev', 'Software Engineer', 3000.00, 2, NULL),
       ('Malika Rakhimova', 'HR Specialist', 1800.00, 3, NULL),
       ('Diyor Khasanov', 'Driver', 1200.00, 4, NULL),
       ('Azizbek Tursunov', 'IT Support', 2000.00, 2, 3),
       ('Sardor Nazarov', 'IT Support', 2200.00, NULL, 3),
       ('Nodira Sultonova', 'Sales Representative', 1600.00, 1, 1),
       ('Kamol Yusupov', 'Marketing Specialist', 1900.00, NULL, NULL),
       ('Zilola Ibragimova', 'Accountant', NULL, 6, NULL),
       ('Rustam Sharipov', 'Finance Manager', 2800.00, 6, NULL);

INSERT INTO customers (name, city)
VALUES ('Oasis Supermarket', 'Tashkent'),
       ('Green Market', 'Samarkand'),
       ('Family Shop', 'Bukhara'),
       ('Fresh Foods', 'Namangan'),
       ('Daily Mart', 'Tashkent'),
       ('Tech Store', 'Tashkent'),
       ('Office Plus', 'Samarkand');

INSERT INTO products (name, price)
VALUES ('Laptop', 800.00),
       ('Mouse', 25.00),
       ('Keyboard', 40.00),
       ('Office Chair', 120.00),
       ('Monitor', 200.00),
       ('Printer', 150.00),
       ('Webcam', 80.00),
       ('Headphones', 60.00);

INSERT INTO orders (order_date, amount, employee_id, customer_id)
VALUES ('2025-01-10', 865.00, 2, 1),
       ('2025-02-14', 240.00, 1, 2),
       ('2025-03-02', 150.00, 3, 3),
       ('2025-03-15', 360.00, 2, 4),
       ('2025-04-20', 920.00, 1, 5),
       ('2025-05-10', 800.00, NULL, 5),
       ('2025-06-30', 540.00, 1, NULL),
       ('2025-07-05', 1200.00, 8, 1),
       ('2025-07-15', 300.00, 8, 2),
       ('2025-08-01', 450.00, 2, 1),
       ('2025-09-10', 0.00, 1, 4),
       ('2024-10-15', 600.00, 1, 3),
       ('2025-10-25', 180.00, 2, 5);

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 1),
       (1, 2, 2),
       (1, 3, 1),
       (2, 3, 3),
       (2, 2, 6),
       (3, 6, 1),
       (4, 5, 2),
       (5, 1, 1),
       (5, 4, 1),
       (6, 5, 4),
       (7, 3, 5),
       (7, 4, 3),
       (8, 1, 1),
       (8, 5, 2),
       (9, 2, 5),
       (10, 6, 3),
       (12, 4, 5);
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
    department_id INTEGER     REFERENCES departments (id) ON DELETE SET NULL,
    manager_id    INTEGER     REFERENCES employees (id) ON DELETE SET NULL
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
    order_date  DATE    NOT NULL,
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
       ('IT', 'Tashkent'),
       ('HR', 'Samarkand'),
       ('Finance', 'Tashkent'),
       ('Marketing', 'Bukhara'),
       ('Logistics', 'Tashkent');

INSERT INTO employees (name, position, salary, department_id, manager_id)
VALUES ('Ali Karimov', 'Sales Director', 15000.00, 1, NULL),
       ('Jasur Abdullaev', 'IT Director', 18000.00, 2, NULL),
       ('Malika Rakhimova', 'HR Director', 12000.00, 3, NULL),
       ('Rustam Sharipov', 'Finance Director', 16000.00, 4, NULL),
       ('Kamol Yusupov', 'Marketing Director', 13000.00, 5, NULL),
       ('Diyor Khasanov', 'Logistics Manager', 10000.00, 6, NULL),
       ('Laylo Usmonova', 'Sales Manager', 8000.00, 1, 1),
       ('Nodira Sultonova', 'Sales Representative', 6000.00, 1, 1),
       ('Aziz Tursunov', 'Sales Representative', 6500.00, 1, 1),
       ('Sardor Nazarov', 'Senior Developer', 12000.00, 2, 2),
       ('Azizbek Tursunov', 'Developer', 7000.00, 2, 2),
       ('Madina Sharipova', 'Junior Developer', 4500.00, 2, 2),
       ('Sherzod Alimov', 'DevOps Engineer', 9000.00, 2, 2),
       ('Dilnoza Karimova', 'HR Specialist', 5500.00, 3, 3),
       ('Jahongir Usmanov', 'Recruiter', 5000.00, 3, 3),
       ('Zilola Ibragimova', 'Senior Accountant', 8500.00, 4, 4),
       ('Otabek Rahimov', 'Accountant', 6500.00, 4, 4),
       ('Feruza Nazarova', 'Financial Analyst', 7500.00, 4, 4),
       ('Sanjar Yuldashev', 'Marketing Specialist', 4800.00, 5, 5),
       ('Nigora Mirzaeva', 'Content Manager', 4200.00, 5, 5),
       ('Botir Saidov', 'Logistics Coordinator', 5200.00, 6, 6),
       ('Gulnora Ahmadova', 'Warehouse Manager', 5800.00, 6, 6);

INSERT INTO customers (name, city)
VALUES ('Tech Solutions LLC', 'Tashkent'),
       ('Green Market', 'Tashkent'),
       ('Family Shop', 'Samarkand'),
       ('Fresh Foods', 'Bukhara'),
       ('Daily Mart', 'Tashkent'),
       ('Oasis Supermarket', 'Samarkand'),
       ('City Electronics', 'Tashkent'),
       ('Book World', 'Bukhara'),
       ('Fashion Store', 'Tashkent'),
       ('Sports Arena', 'Samarkand'),
       ('Happy Home', 'Tashkent'),
       ('Dream Decor', 'Bukhara');

INSERT INTO products (name, price)
VALUES ('Laptop', 1200.00),
       ('Mouse', 25.00),
       ('Keyboard', 45.00),
       ('Monitor', 300.00),
       ('Office Chair', 150.00),
       ('Desk', 250.00),
       ('Printer', 180.00),
       ('Webcam', 80.00),
       ('Headphones', 60.00),
       ('USB Cable', 10.00),
       ('Phone Stand', 15.00),
       ('Notebook', 5.00),
       ('Pen Set', 8.00),
       ('Stapler', 12.00),
       ('Calculator', 20.00);

INSERT INTO orders (order_date, amount, employee_id, customer_id)
VALUES ('2025-01-10', 1500.00, 7, 1),
       ('2025-02-15', 800.00, 7, 1),
       ('2025-03-20', 1200.00, 7, 1),
       ('2025-04-25', 950.00, 7, 1),
       ('2025-05-30', 1100.00, 7, 1),
       ('2025-01-15', 600.00, 8, 2),
       ('2025-03-10', 450.00, 8, 2),
       ('2025-06-05', 720.00, 8, 2),
       ('2025-02-01', 850.00, 1, 3),
       ('2025-04-15', 920.00, 1, 3),
       ('2025-01-20', 1500.00, 10, 4),
       ('2025-03-25', 1800.00, 10, 4),
       ('2025-05-10', 1350.00, 10, 4),
       ('2025-02-10', 540.00, 9, 5),
       ('2025-04-05', 680.00, 9, 5),
       ('2025-01-25', 1200.00, 3, 6),
       ('2025-03-15', 980.00, 3, 6),
       ('2025-05-20', 1450.00, 3, 6),
       ('2025-02-20', 2200.00, 11, 7),
       ('2025-04-10', 1900.00, 11, 7),
       ('2025-03-05', 380.00, 13, 8),
       ('2025-05-15', 420.00, 13, 8),
       ('2025-01-30', 1150.00, 14, 9),
       ('2025-03-30', 890.00, 14, 9),
       ('2025-06-01', 1020.00, 14, 9),
       ('2025-02-25', 760.00, 15, 10),
       ('2025-04-20', 640.00, 15, 10);

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 1),
       (1, 4, 1),
       (1, 10, 2),
       (2, 2, 5),
       (2, 3, 5),
       (2, 10, 3),
       (3, 1, 1),
       (3, 10, 2),
       (4, 4, 2),
       (4, 9, 3),
       (4, 10, 2),
       (5, 5, 2),
       (5, 10, 3),
       (6, 2, 10),
       (6, 3, 8),
       (6, 10, 2),
       (7, 7, 2),
       (7, 10, 1),
       (8, 6, 1),
       (8, 5, 2),
       (8, 10, 2),
       (9, 9, 5),
       (9, 8, 3),
       (9, 10, 2),
       (10, 1, 1),
       (10, 4, 1),
       (10, 10, 3),
       (11, 1, 1),
       (11, 10, 2),
       (12, 3, 10),
       (12, 2, 15),
       (12, 10, 5),
       (13, 7, 1),
       (13, 8, 2),
       (13, 10, 1),
       (14, 6, 2),
       (14, 10, 2),
       (15, 4, 3),
       (15, 10, 3),
       (16, 1, 2),
       (16, 10, 2),
       (17, 9, 4),
       (17, 10, 2),
       (18, 11, 10),
       (18, 12, 20),
       (18, 10, 3),
       (19, 13, 15),
       (19, 10, 2),
       (20, 5, 3),
       (20, 10, 2),
       (21, 4, 2),
       (21, 10, 2),
       (22, 9, 5),
       (22, 10, 3),
       (23, 8, 3),
       (23, 10, 2),
       (24, 6, 1),
       (24, 10, 1),
       (25, 7, 2),
       (25, 10, 2),
       (26, 3, 8),
       (26, 2, 12),
       (26, 10, 4);
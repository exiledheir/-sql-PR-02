CREATE TABLE orders
(
    id             SERIAL PRIMARY KEY,
--     need to remove
    customer_name  TEXT,
 --     need to remove
    customer_email TEXT,
--     need to remove
    product_name   TEXT,
--     need to remove also
    product_price  NUMERIC(10, 2)
);

CREATE TABLE order_items
(
    order_id     INT,
--     should set to foreign key
    product_id   INT,
    quantity     INT,
--     should be removed
    product_name TEXT,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE customers
(
    id     SERIAL PRIMARY KEY,
    name   TEXT,
--     extract to new table
    city   TEXT,
    region TEXT
);

-- Создай 3 таблицы:
-- customers — покупатели
-- products — товары
-- orders — заказы
--
-- Связи:
-- Один клиент → много заказов
-- Один заказ → много товаров (через таблицу связей order_items)

create table customers
(
    id    serial primary key,
    name  text not null,
    email text not null unique
);

create table products
(
    id    serial primary key,
    name  text not null,
    price numeric(10, 2)
);

create table orders
(
    id          serial primary key,
    order_date  date   not null,
    customer_id bigint not null,
    foreign key (customer_id) references customers (id)
);

create table order_items
(
    order_id   bigint not null,
    product_id bigint not null,
    quantity   int    not null,
    primary key (order_id, product_id),
    foreign key (order_id) references orders (id) on delete cascade,
    foreign key (product_id) references products (id)
);
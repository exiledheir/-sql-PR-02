-- Создай две таблицы:
-- categories (id, name)
-- products (id, name, price, category_id)
--
-- Требования:
-- Цена не может быть отрицательной (CHECK).
-- Названия категорий и товаров — обязательные поля.

create table category
(
    id   serial primary key,
    name text not null
)

create table products
(
    id          serial primary key,
    name        text           not null,
    price       numeric(10, 2) not null check (price >= 0),
    category_id bigint,
    foreign key (category_id) references categories (id)
);



-- Создай две таблицы:
-- customers — клиенты (id, имя, email)
-- orders — заказы (id, сумма, дата, клиент)
--
-- Требования:
-- id — первичный ключ (PK)
-- email — уникальный
-- связь между orders и customers — внешним ключом (FK)

create table customers
(
    id    serial primary key,
    name  text not null,
    email text not null unique
);

create table orders
(
    id        serial primary key,
    amount    numeric(10, 2),
    date      DATE not null,
    client_id bigint,
    foreign key (client_id) references customers (id)
)
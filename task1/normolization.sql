create table product
(
    id    serial primary key,
    name  text           not null,
    price numeric(10, 2) not null
);

create table region
(
    id   serial primary key,
    name text not null
);

create table city
(

    id        serial primary key,
    name      text   not null,
    region_id bigint not null,
    foreign key (region_id) references region (id)
);

alter table orders
    drop column customer_name,
    drop column customer_email,
    drop column product_name,
    drop column product_price,
    add column customer_id bigint,
    add column  product_id bigint,
    add constraint fk_orders_customer foreign key(customer_id ) references customers(id),
    add constraint fk_orders_product foreign key(product_id ) references product(id);

alter table order_items
    drop column product_name,
    add constraint fk_order_item foreign key (product_id) references product(id);

alter table customers
    drop column city,
    drop column region,
    add column city_id bigint,
    add constraint fk_city foreign key (city_id) references city(id)

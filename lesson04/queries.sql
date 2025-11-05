-- Вывести employee.id, employee.name, department.name — сотрудники без отдела должны показать No Department.
select e.id, e.name, coalesce(d.name, 'No Department') as department_name
from employees e
         left join departments d on e.department_id = d.id;

-- Сотрудники, у которых есть менеджер (показать имя сотрудника и имя менеджера).
select e1.name as employee_name, e2.name as manager_name
from employees e1
         left join employees e2 on e2.id = e1.manager_id
where e1.manager_id is not null;

-- Отделы без сотрудников.
select d.name
from departments d
where d.id not in (select e.department_id
                   from employees e
                   where e.department_id is not null);


-- Все заказы с именем сотрудника и именем клиента — если employee или customer отсутствует, показывать No Employee / No Customer.
SELECT coalesce(e.name, 'No employee') AS employee_name,
       coalesce(c.name, 'No customer') AS customer_name
FROM orders o
         LEFT JOIN employees e ON e.id = o.employee_id
         LEFT JOIN customers c ON c.id = o.customer_id;

-- Список заказов с товарами: для каждого заказа вывести order_id, product_name, quantity.
-- Показать также заказы без позиций.
select o.id as order_id, p.name as product_name, ot.quantity
from orders o
         left join order_items ot on o.id = ot.order_id
         left join products p on p.id = ot.product_id;


-- Для каждого отдела — все заказы (через сотрудников этого отдела); включать отделы с нулём заказов.
select d.name as department_name, coalesce(sum(o.amount), 0) as amount_of_orders
from departments d
         left join employees e on d.id = e.department_id
         left join orders o on o.employee_id = e.id
group by d.name;


-- Найти пары клиентов и продуктов, которые этот клиент никогда не покупал
-- (т.е. построить Cartesian клиент×продукт и исключить реальные покупки).
select c.name, p.name
from customers c
         cross join products p
where not exists(select *
                 from orders o
                          left join order_items ot on ot.order_id = o.id
                 where c.id = o.customer_id
                   and ot.product_id = p.id)
group by c.name, p.name;


-- Показать, какие продукты никогда не продавались.
select p.name
from products p
where p.id not in (select distinct ot.product_id from order_items ot)


-- Для каждого менеджера — показать суммарную сумму заказов, оформленных его подчинёнными.
select man.name as manager_name, coalesce(sum(amount), 0) as total_amount_of_sales
from employees emp
         left join employees man on man.id = emp.manager_id
         left join orders o on emp.id = o.employee_id
where man.name is not null
group by manager_name;

-- Общее количество заказов и суммарная выручка (amount).
select count(id) as total_orders, sum(amount) as total_amount
from orders;

-- Средняя и максимальная зарплата по отделам.
select d.name                                           as department_name,
       cast(coalesce(avg(salary), 0) as numeric(18, 2)) as average,
       coalesce(max(salary), 0)                         as max
from departments d
         left join employees e on d.id = e.department_id
group by d.name;


-- Для каждого заказа — общее количество товаров (sum quantity)
-- и уникальных позиций (count distinct product_id).
select ot.order_id, count(distinct ot.product_id) as unique_product, sum(quantity)
from order_items ot
group by order_id;


-- Топ-3 продукта по суммарной выручке (price*quantity).
select p.name, sum(ot.quantity * p.price) as total_income
from order_items ot
         left join products p on p.id = ot.product_id
group by p.id
order by total_income desc
limit 3;

-- Количество клиентов, у которых есть хотя бы один заказ.
select count(*) as customers_ordered
from (select customer_id
      from orders
      group by customer_id
      having count(*) > 1) as sub;


-- Для каждого отдела — количество сотрудников, средняя зарплата,
-- суммарная сумма заказов (через сотрудников этого отдела).
-- employee<--order<--order_items
select d.name                                                      as department_name,
       count(distinct e.id)                                        as employee_amount,
       coalesce(cast(avg(distinct e.salary) as numeric(18, 2)), 0) as avg_salary,
       coalesce(sum(o.amount), 0)                                  as order_amount
from departments d
         left join employees e on e.department_id = d.id
         left join orders o on e.id = o.employee_id
group by d.name;

-- Найти клиентов, чья средняя сумма заказа выше средней по всем заказам.
select c.name, cast(avg(o.amount) as numeric(18, 2)) as average_amount
from customers c
         left join orders o on o.customer_id = c.id
group by c.name
having avg(o.amount) > (select avg(o.amount)
                        from orders o);

-- Сформировать полное имя сотрудника
select e.id,
       split_part(e.name, ' ', 1) AS first_name,
       split_part(e.name, ' ', 2) AS last_name,
       name                       AS full_name
FROM employees e;

-- Вывести дату заказа в формате DD.MM.YYYY HH24:MI.
select to_char(o.order_date, 'd.MM.yyyy hh24:mi')
from orders o

-- Найти заказы старше N дней (параметр)
select *
from orders
where order_date < current_date - interval '120 days';

-- Для таблицы employees:
-- заменить NULL в salary на 0 в вычислениях и вывести salary + bonus (bonus = 10% для определённой позиции).
select name, coalesce(salary, 0), coalesce(salary + salary * 0.10, 0) as salary_with_bonus
from employees

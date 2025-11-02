-- Вывести сотрудников с зарплатой выше средней по компании

-- Вывести продукты дороже среднего
select p.name, p.price
from products p
where p.price > (select avg(price) from products);

-- Вывести отделы, где есть хотя бы один сотрудник с зарплатой > 10 000
select distinct d.name
from departments d
where exists (select *
              from employees e
              where e.department_id = d.id
                and salary > 10000)
group by d.name;

-- Вывести продукты, которые чаще всего встречаются в заказах
select p.name as products_name, count(ot.product_id) as product_occurencse
from order_items ot
         left join products p on p.id = ot.product_id
group by products_name
having count(ot.product_id) > (select avg(ocur)
                               from (select count(product_id) as ocur
                                     from order_items
                                     group by product_id) as avg_ocur)
order by products_name asc;

-- Вывести для каждого клиента количество его заказов
select c.name, coalesce(o.order_amount, 0) as order_amount
from customers c
         left join (select o.customer_id, count(o.id) as order_amount
                    from orders o
                    group by o.customer_id) o on c.id = o.customer_id;

-- Вывести топ 3 отдела по средней зарплате
select d.name, cast(avg(e.salary) as numeric(18, 2)) as avg_salary
from departments d
         join employees e on d.id = e.department_id
group by d.name
order by avg_salary desc
limit 3;

-- Вывести клиентов без заказов
select c.name
from customers c
where c.id not in (select customer_id from orders);


-- Вывести сотрудников, зарабатывающих больше, чем любой из менеджеров.
select e.name, e.salary
from employees e
where e.salary > (select min(salary) from employees where manager_id is null)
  and manager_id is not null;


-- Вывести отделы, где все сотрудники зарабатывают выше 5000.
select d.name, min(e.salary) as min_salary
from departments d
         join employees e on e.department_id = d.id
group by d.id
having min(e.salary) > 5000

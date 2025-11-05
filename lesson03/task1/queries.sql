-- Найди сумму продаж по каждому региону.
select region, sum(amount) as total_sales
from sales
-- where amount is not null
group by region;


-- Покажи среднюю сумму продаж по регионам, где больше одной продажи.
select region, avg(amount) as avg_sales
from sales
where amount > 1
group by region;


-- Найди регион с максимальной суммой продаж.
select s.region, sum(amount) as max_sale_amount
from sales s
where amount is not null
group by s.region
order by max_sale_amount desc
limit 1;


-- Выведи общее количество продаж и сколько из них имеют ненулевую сумму.
select sum(amount) as total_amount
from sales
where amount > 0;


-- Покажи регионы, где продажи превышают среднюю по всем регионам.
select s.region
from sales s
group by s.region
having sum(s.amount) > (select avg(total_sales)
                        from (select sum(subs.amount) as total_sales
                              from sales subs
                              group by subs.region) as avg_per_region)

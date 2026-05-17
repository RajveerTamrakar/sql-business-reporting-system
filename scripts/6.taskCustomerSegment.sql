/*SQL TASK 
group customers into 3 segments based on their spending behaviours 

vip - at least 12 months of history and spends more than 5000
regular - at least 12 months of history but spending less than 5000
new - lifespan less than 12 months

find the total nos of customers by each group*/

with customer_spending as (
select 
c.customer_key,
sum(f.sales_amount) as total_sales,
min(f.order_date) as first_date,
max(f.order_date) as last_date,
DATEDIFF(month,min(f.order_date),max(f.order_date)) as lifespan
from [gold].[fact_sales] f
left join [gold].[dim_customers] c 
on f.customer_key = c.customer_key
group by c.customer_key
)

select 
customer_segment,
count(customer_key) as total_customers
from (
select 
customer_key,
case when total_sales > 5000 and lifespan > 12 then 'VIP'
when total_sales <= 5000 and lifespan <= 12 then 'regular'
else 'new'
end as customer_segment
from customer_spending ) t
group by customer_segment
order by total_customers desc

/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

CREATE VIEW gold.report_customers AS

--1) Base Query: Retrieves core columns from tables

with base_query as (
select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name,' ',c.last_name) as customer_name,
datediff(year,c.birthdate,getdate()) as age
from [gold].[fact_sales] f
left join [gold].[dim_customers] c
on f.customer_key = c.customer_key
where order_date is not null
)


--2) Customer Aggregations: Summarizes key metrics at the customer level

,customer_aggregation as (
select 
customer_key,
customer_number,
customer_name,
age,
count(order_number) as total_orders,
sum(distinct product_key) as total_products,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
MAX(order_date) AS last_order_date,
datediff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by 
customer_key,
customer_number,
customer_name,
age 
)

select 
customer_key,
customer_number,
customer_name,
age,
case
when age <20 then 'under 20'
when age between 20 and 29 then '20-29' 
when age between 30 and 39 then '30-39' 
when age between 40 and 49 then '40-49' 
else '50 and above'
end as age_group,
case 
	when total_sales > 5000 and lifespan > 12 then 'VIP'
	when total_sales <= 5000 and lifespan <= 12 then 'regular'
	else 'new'
end as customer_segment,
last_order_date,
datediff(month,last_order_date,getdate()) as recency,
total_orders,
total_products,
total_sales,
total_quantity,
lifespan,

-- Compuate average order value (AVO)
case when total_orders = 0 then 0
else total_sales / total_orders 
end as avg_order_value,

-- Compuate average monthly spend
CASE WHEN lifespan = 0 THEN total_sales
     ELSE total_sales / lifespan
END AS avg_monthly_spend
from customer_aggregation

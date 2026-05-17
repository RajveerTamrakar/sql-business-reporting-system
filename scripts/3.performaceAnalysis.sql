/*3.Performance Analysis
Compare the current value to a target value, helps measure success and compare performance
Analyze the yearly performance of products by comparing each product's sales to both its avg and prev
year sales performance */


with yearly_product_sales as (
select 
year(f.order_date) as order_year,
p.product_name,
sum(f.sales_amount) as current_sales
from [gold].[fact_sales] f left join
[gold].[dim_products] p on 
f.product_key = p.product_key
where year(f.order_date) is not null
group by year(f.order_date),p.product_name
)

select 
order_year,
product_name,
current_sales,
avg(current_sales) over(partition by product_name) as average_sales,
current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
case when current_sales - avg(current_sales) over(partition by product_name) >0 then 'above avg' 
when current_sales - avg(current_sales) over(partition by product_name) <0 then 'below avg' 
else 'avg' 
end as avg_change,
--year over year analysis 
lag(current_sales) over(partition by product_name order by order_year) as yoy_change, 
current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_py, 
case when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase' 
when current_sales - lag(current_sales) over(partition by product_name order by order_year) <0 then 'Decrease' 
else 'No change' 
end as py_change
from yearly_product_sales
order by product_name,order_year


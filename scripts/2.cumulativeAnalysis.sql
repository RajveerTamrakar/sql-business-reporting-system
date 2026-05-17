/*2.Cumulative Analysis
aggregate the data progressively over time helps understand whether our buisness is growing or declining 
Calculate the total sales per month and the running total of sales over time*/

select 
order_date, 
total_sales, 
sum(total_sales) over(partition by order_date order by order_date) as running_total_sales 
from ( 
select datetrunc(month,order_date) as order_date, 
sum(sales_amount) as total_sales 
from [gold].[fact_sales] 
where order_date is not null 
group by datetrunc(month,order_date) 
--order by datetrunc(month,order_date) 
)t
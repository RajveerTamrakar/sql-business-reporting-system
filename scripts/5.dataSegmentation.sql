/*5.Data Segmentation
Group the data based on specific range, Helps understand the coordn bw 2 measures

Segment products into cost range and
count how many products fall into each category */

with product_segment as (
select 
product_key,
product_name,
cost,
case when cost<100 then 'below 100'
when cost between 100 and 500 then '100-500'
when cost between 500 and 1000 then '500-1000'
else 'above 1000'
end as cost_range
from [gold].[dim_products]
)

select 
cost_range,
count(product_key) as total_products
from product_segment
group by cost_range
order by total_products desc

/*4.Part to whole analysis
Analyzing how an individual part is performing compared to overall.Allowing us to understand which
category has highest impact

which category contributes most to overall sales*/

with category_sales as (
select 
p.category,
sum(f.sales_amount) as total_sales
from [gold].[fact_sales] f 
left join [gold].[dim_products] p
on f.product_key = p.product_key
group by p.category
)

select 
category,
total_sales,
sum(total_sales) over() as overall_sales,
concat(round((cast(total_sales as float)/sum(total_sales) over()) * 100,2),'%') as percentage_total_of_all_sales
from category_sales
order by total_sales desc


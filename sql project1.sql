SELECT * FROM public.retails_sales
ORDER BY transactions_id ASC 


select * 
from public.retails_sales
limit 10;

select count (*)
from public.retails_sales;

select * from public.retails_sales
where transactions_id is null

select * from public.retails_sales
where sale_date is null

select * from public.retails_sales
where sale_time is null

--Data Cleaning
select * from public.retails_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or 
	category is null
	or
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null
	 
--
delete from public.retails_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or 
	category is null
	or
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;
	
select 
count(*)
from  public.retails_sales

-- Data exploration
-- how many sales we have?
select count(*) as total_sale from  public.retails_sales

--how many unique customers we have?

select count(Distinct category) as total_sale from  public.retails_sales

select distinct category  from  C
-- Data analysis and Business key problems and answers
Q1. write a SQL query to retrieve all columns for sales made on 2022-11-05\

select *
from public.retails_sales
where sale_date = '2022-11-05';


select *
from public.retails_sales
where 
	category = 'clothing'
	and 
	to_char(sale_date, 'YYYY-MM')='2022-11'
	and quantity >= 4 ;

--Q3. Write a SQL query to calculate the total sales(total_sale) for each category

select  
	category,
	sum(total_sale)as net_sale,
	count(*)as total_orders
from public.retails_sales
group by 1;

--Q4 write a sql query to find the average age of customers who purchased items from the 'beauty'category

select 
	round (avg(age),2) as avg_age 
from public.retails_sales
where category ='Beauty'

--Q5 write a sql query to find all transactions where total_sale is greater than 1000

select * from public.retails_sales
where total_sale > 1000

--Q6 write sql query to find the total number of transactions(transactions_id) made by each gender in each category

Select 
	category,
	gender,
	count(*) as total_trans
from public.retails_sales
group 
	by 
	category, 
	gender
order by 1

--Q7 write a sql query to calculate the average sale for each month. find out the best selling month in each year

select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg (total_sale) as avg_sale
 from public.retails_sales
 Group by 1, 2
 order by 1, 3 desc


--Q8 write a sql query to find the top 5 customers based on the highest total sales 
	
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM public.retails_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

--Q9 write a sql query to find the number of unique customers who purchased items from each category

SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM public.retails_sales
GROUP BY category
ORDER BY unique_customers DESC;



--Q10 write a sql query to create each shift and number of orders (example morning <=12, afternon between 12 & 17 , evening >17) 
with hourly_sale
as
(
select *,
	case 
		when extract(hour from sale_time) <12 then 'morning'
		when extract(hour from sale_time) between 12 and 17 then 'afternoon'
		else 'evening'
	end as shift 

from public.retails_sales
)
select
	count (*) as total_orders
from hourly_sale
group by shift


--end of prject 












	
	
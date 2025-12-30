use sales_vehicle;

select * from vehicle_sales;

-- Total number of vehicle sales.
select count(*) as total_vehicle_sales
from vehicle_sales;

-- Year-wise total sales amount.
select year, round(sum(total_sale_amount),2) as total_sale_amount
from vehicle_sales
group by year
order by year;

-- Month-wise total units sold.
select month, sum(units_sold) as total_units_sold
from vehicle_sales
group by month
order by str_to_date (month, '%M');

-- City-wise total revenue.
select dealer_city, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by dealer_city
order by dealer_city desc;

-- Vehicle type-wise total sales.
select vehicle_type, sum(total_sale_amount) as total_sales
from vehicle_sales 
group by vehicle_type
order by total_sales desc;

-- Brand-wise total revenue.
select brand, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by brand
order by total_revenue desc;

-- Fuel type-wise sales count.
select fuel_type, count(*) as sales_count
from vehicle_sales
group by fuel_type
order by sales_count desc;

-- Transmission-wise average sale price.
select transmission, avg(total_sale_amount) as avg_sales_price
from vehicle_sales
group by transmission
order by avg_sales_price desc;

-- Gender-wise average purchase value.
select customer_gender, avg(total_sale_amount) as avg_purchase_value
from vehicle_sales
group by customer_gender
order by avg_purchase_value desc;

-- Top 5 highest value sales.
select *
from vehicle_sales
order by total_sale_amount desc
limit 5;

-- City-wise highest single sale amount.
select dealer_city, max(total_sale_amount) as highest_sale_amount
from vehicle_sales
group by dealer_city
order by highest_sale_amount desc;

-- Year-wise growth in sales revenue
select year, sum(total_sale_amount) as sales_revenue
from vehicle_sales
group by year
order by year;

-- Brand and year wise total revenue
select brand, year, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by brand, year
order by brand, year;

-- Vehicle type and fuel type wise sales-
select vehicle_type, fuel_type, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by vehicle_type, fuel_type
order by total_revenue desc ;

-- Payment mode-wise total revenue.
select payment_mode, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by payment_mode
order by total_revenue desc;

-- Discount-wise impact on total sales.
select 
	case
		when discount = 0 then 'No Discount'
        when discount between 1 and 50000 then 'Low Discount'
        when discount between 50001 and 150000 then 'Medium Discount'
        else 'High Discount'
	end as discount_range,
    count(*) as total_sales,
    sum(total_sale_amount) as total_revenue,
    round(avg(total_sale_amount),2) as avg_sale_value
from vehicle_sales
group by discount_range
order by total_revenue desc;

-- Average discount per brand.
select brand, round(avg(discount),2) as avg_discount
from vehicle_sales
group by brand
order by avg_discount desc;

-- Salesperson-wise total sales amount.
select salesperson_id, sum(total_sale_amount) as total_sales
from vehicle_sales 
group by salesperson_id
order by total_sales desc;

-- Top 3 brands by revenue
select brand, sum(total_sale_amount) as total_revenue
from vehicle_sales
group by brand
order by total_revenue desc
limit 3;

-- Repeat customers (multiple units purchased)
select count(*) as repeat_sales_count
from vehicle_sales
where units_sold > 1;

-- City and vehicle type wise revenue
select dealer_city, vehicle_type, sum(total_sale_amount) as revenue 
from vehicle_sales
group by dealer_city, vehicle_type
order by dealer_city, revenue desc;

-- Electric vehicle sales trend year-wise.
select year, sum(units_sold) as ev_units_sold
from vehicle_sales
where fuel_type = 'Electric'
group by year
order by year;

-- Highest selling month each year.
select year, month, total_units_sold
from (
	select
		year,
			month,
				sum(units_sold) as total_units_sold,
                row_number() over (partition by year order by sum(units_sold) desc) as rn
                from vehicle_sales
	group by year, month) t
    where rn = 1
	order by year;
    
-- Fuel type wise average unit price.    
select fuel_type, round(sum(unit_price),2) as avg_unit_price
from vehicle_sales
group by fuel_type
order by avg_unit_price desc;

-- Year-wise total units sold.
select year, sum(units_sold) as total_units_sold 
from vehicle_sales
group by year
order by year;

select * from vehicle_sales;

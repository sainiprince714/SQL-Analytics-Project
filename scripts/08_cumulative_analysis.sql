/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
 Select
	 orderMonth, totalSales,
	 SUM(totalSales) OVER(order by orderMonth) AS running_total,
	 AVG(totalSales) OVER(order by orderMonth) AS running_avg
	 from (
		 Select 
		 DATETRUNC(MONTH,order_date) AS orderMonth,
		 SUM(sales_amount) AS totalSales,
		 AVG(sales_amount) as avg_price
		 from gold.fact_sales
		 where order_date IS NOT NULL
		 group by DATETRUNC(MONTH,order_date)
		 )t;
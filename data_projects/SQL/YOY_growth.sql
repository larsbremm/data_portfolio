--Assume you're given a table containing information about Wayfair user transactions 
--for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.
--The output should include the year in ascending order, product ID, current year's spend, 
--previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.

WITH yearly_spend_cte AS (
  SELECT EXTRACT(YEAR FROM transaction_date) AS year
        ,product_id
        ,spend AS curr_year_spend
        ,LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id,
        EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
  FROM user_transactions
)

SELECT year
      ,product_id
      ,curr_year_spend
      ,prev_year_spend
      ,ROUND(100*(curr_year_spend - prev_year_spend)
      /prev_year_spend,2) AS yoy_rate
FROM  yearly_spend_cte

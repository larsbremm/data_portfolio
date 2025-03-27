-- Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product 
-- from every product category listed in the products table.

--  Write a query that identifies the customer IDs of these Supercloud customers.

with customer_prod_count AS(
  SELECT c.customer_id, COUNT(DISTINCT p.product_category)
  FROM customer_contracts c 
  JOIN products p ON c.product_id = p.product_id
  GROUP BY 1
)

SELECT customer_id
FROM customer_prod_count
WHERE count = 3

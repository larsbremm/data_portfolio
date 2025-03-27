--Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, 
--write a query that retrieve the users along with the number of products they bought.

--Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

with latest_transactions AS ( 
  SELECT transaction_date, user_id, product_id,
  RANK() OVER (
  PARTITION BY user_id
  ORDER BY transaction_date DESC) AS transaction_rank
  FROM user_transactions
)

SELECT transaction_date, user_id, COUNT(product_id)
FROM latest_transactions
WHERE transaction_rank = 1
GROUP BY 1,2

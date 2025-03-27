-- Assume you're given tables with information on Snapchat users, 
-- including their ages and time spent sending and opening snaps.

-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a 
-- percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

SELECT ab.age_bucket,
ROUND(SUM(a.time_spent) FILTER (where a.activity_type = 'send') / SUM(a.time_spent)*100.0 ,2) AS send_perc,
ROUND(SUM(a.time_spent) FILTER (where a.activity_type = 'open') / SUM(a.time_spent)*100.0 ,2) AS open_perc
FROM activities a
JOIN age_breakdown ab ON a.user_id = ab.user_id
WHERE activity_type IN ('open','send')
GROUP BY 1

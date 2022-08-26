- Data Lemur Questions--
Select u.city, 
count(t.order_id) as total_orders
from users u join trades t
On t.user_id=u.user_id
where t.status='Completed'
Group by u.city
Order by total_orders desc
Limit 3;

Select page_id
from pages
Except
Select page_id
from page_likes


SELECT 
  SUM(
    CASE WHEN device_type = 'laptop' 
    	THEN 1 ELSE 0 END
  ) AS laptop_views, 
  SUM(
    CASE WHEN device_type IN ('tablet', 'phone') 
    	THEN 1 ELSE 0 END
  ) AS mobile_views 
FROM 
  viewership;

Select sender_id, count(*) as count_messages
from messages
where sent_date between '08/01/2022 00:00:00' and '08/31/2022 23:59:59' 
group by sender_id
Order by count_messages desc
Limit 2

SELECT user_id, COUNT(product_id) AS product_num 
FROM user_transactions 
GROUP BY user_id 
having sum(spend) >=1000
ORDER BY product_num DESC, SUM(spend) DESC
limit 3

Select td.datacenter_id,
d.monthly_capacity - td.total_demand AS spare_capacity

from
(Select datacenter_id, sum(monthly_demand) as total_demand
from forecasted_demand
group by datacenter_id)
as td
join
  datacenters d
ON d.datacenter_id=td.datacenter_id
ORDER BY 
  d.datacenter_id;

   WITH cte AS
 (SELECT DISTINCT u.user_id,(SELECT COUNT(u1.user_id) FROM user_transactions u1
WHERE u1.user_id=u.user_id AND u1.transaction_date=(SELECT MIN(u2.transaction_date) FROM user_transactions u2
WHERE u2.user_id=u.user_id) AND u1.spend>50) AS first_count
FROM user_transactions u)

SELECT COUNT(user_id) AS users FROM cte
WHERE first_count>0
Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

product_spend Table:
Column Name	Type
category	string
product	string
user_id	integer
spend	decimal
transaction_date	timestamp
product_spend Example Input:
category	product	user_id	spend	transaction_date
appliance	refrigerator	165	246.00	12/26/2021 12:00:00
appliance	refrigerator	123	299.99	03/02/2022 12:00:00
appliance	washing machine	123	219.80	03/02/2022 12:00:00
electronics	vacuum	178	152.00	04/05/2022 12:00:00
electronics	wireless headset	156	249.90	07/08/2022 12:00:00
electronics	vacuum	145	189.00	07/15/2022 12:00:00

  
Example Output:
category	product	total_spend
appliance	refrigerator	299.99
appliance	washing machine	219.80
electronics	vacuum	341.00
electronics	wireless headset	249.90

  
Explanation:
Within the "appliance" category, the top two highest-grossing products are "refrigerator" and "washing machine."
In the "electronics" category, the top two highest-grossing products are "vacuum" and "wireless headset."
************************************************************************************************************************************

Query:

select category, product,total_spend
from
(select category, product,SUM(spend) AS total_spend,
rank() over (partition by category order by SUM(spend) desc) as spends_rank
FROM product_spend
where extract(year from transaction_date)=2022
group by category,product)A
where spends_rank in (1,2);

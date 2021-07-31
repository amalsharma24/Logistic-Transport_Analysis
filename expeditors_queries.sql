-- 1. How much revenue is generated on how many shipments (shipment_id) and weights moved in each quarter 
-- (just call them Q1, Q2, Q3, and Q4, don't worry about year)?
-- Output columns: quarter, shipment_count, weight_sum, revenue
use expeditors;

with cte as (
Select file_number,  case 
when month(date) between 1 and 3 then 'Q1'
when month(date) between 4 and 6 then 'Q2'
when month(date) between 7 and 9 then 'Q3'
else 'Q4'
end as Quarter, sum(revenue_usd) as revenue from revenue group by 1 ,2),

cte2 as (Select f.file_number, case 
when s.month_number between 1 and 3 then 'Q1'
when s.month_number between 4 and 6 then 'Q2'
when s.month_number between 7 and 9 then 'Q3'
else 'Q4'
end as Quarter, sum(s.weight_kg) as weight_sum, count(s.shipment_id) as shipment_count
from shipment s join file_dim f
on s.shipment_id = f.shipment_id
group by 1,2)

Select c2.Quarter, sum(c2.weight_sum) as weight_sum , sum(c2.shipment_count) as shipment_count, 
sum(c1.revenue) as revenue
from cte c1 join cte2 c2
on c1.file_number = c2.file_number and
c1.Quarter = c2.Quarter group by 1

Assumption : 
1. There exist multiple to multiple relation between Shipment_id and file_number
2. revenue.file_number can be same in multiple month. therefore, it need to be linked to file_dim.file_number 
and exact month to know its revenue in Quarter where as month is not present in file_dim. so we have to first 
calculate the revenue for quarter and weight & count quarter wise through shipment table and then it should be 
join for right result


-- 2. How much revenue each client generated at the origin branch and level 1 region respectively?
-- Output columns: client_name, origin_branch, origin_region_level1, sum_revenue_branch, sum_revenue_region_level1

Select Distinct b.branch, b.region_level1, sum(revenue_usd) over(partition by b.branch) as sum_revenue_branch , 
sum(r.revenue_usd) over(partition by b.region_level1) as sum_revenue_region_level1 from branch_dim b
join revenue r on b.branch = r.revenue_branch

Assumption : 
1. As region_level1 is higher hierachy therefor same sum will be reflected in multiple column as we are showing its 
lower hierarchy i.e. region as well

-- 3. How much revenue is generated, and how many shipments are on each file with 
-- type B or C whose weight is below 1000kg?
-- Output columns: file_number, weight, shipment_count, revenue

with cte1 as (
Select f.file_number, sum(s.weight_kg) as weight , count(s.shipment_id) as shipment_count
from shipment s
join file_dim f on s.shipment_id = f.shipment_id
where f.file_type = 'B' or f.file_type = 'C' and s.weight_kg < 1000
group by 1),

 cte2 as (
Select file_number, file_type from file_dim where file_type = 'B' or file_type = 'C' group by 1, 2),

cte3 as (
Select r.file_number, sum(r.revenue_usd) as revenue from revenue r
join cte2 c on c.file_number = r.file_number
group by 1 )

Select c1.file_number, c1.weight, c1.shipment_count, c3.revenue
from cte1 c1 join cte3 c3 on c1.file_number = c3.file_number



Assumption : 
1. There exist multiple to multiple relation between Shipment_id and file_number
2. Because of multiple to multiple between Shipment_id and file_number. Also multiple
 to one relationship between Invoice and file_number we need to first calculate shipment count, weight, 
 secondly calculate revenue for file number and then join them





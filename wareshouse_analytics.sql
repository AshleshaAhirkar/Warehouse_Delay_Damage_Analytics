create database warehouse_analytics;

show databases;

use warehouse_analytics;

SELECT DATABASE();

CREATE TABLE warehouse_operations (

delivery_id INT PRIMARY KEY,

delivery_partner VARCHAR(50),

package_type VARCHAR(30),

vehicle_type VARCHAR(30),

delivery_mode VARCHAR(30),

region VARCHAR(30),

weather_condition VARCHAR(30),

distance_km DECIMAL(8,2),

package_weight_kg DECIMAL(8,2),

delivery_time_hours INT,

expected_time_hours INT,

`delayed` VARCHAR(10),

delivery_status VARCHAR(20),

delivery_rating INT,

delivery_cost DECIMAL(10,2),

warehouse_id VARCHAR(20),

warehouse_name VARCHAR(100),

shift VARCHAR(20),

damage_status VARCHAR(20),

delay_reason VARCHAR(100),

damage_cost DECIMAL(10,2),

sla_status VARCHAR(20)

);

TRUNCATE TABLE warehouse_operations;


SELECT COUNT(*) 
FROM warehouse_operations;
--
SELECT *
FROM warehouse_operations
ORDER BY delivery_id DESC
LIMIT 5;

SELECT MAX(delivery_id)
FROM warehouse_operations;

TRUNCATE TABLE warehouse_operations;

SELECT COUNT(*) 
FROM warehouse_operations;

--
select *
from warehouse_operations;

--
-- 1. Delay Analysis 
--  Q1. Which warehouse has maximum delays? 
select warehouse_name,count(*) as total_delays
from warehouse_operations
where delivery_status='Delayed'
group by warehouse_name
order by total_delays desc
limit 1;

select t.warehouse_name,t.total_delays
from(
select  warehouse_name,count(delivery_status) as total_delays,
dense_rank() over(order by count(delivery_status) desc) as rnk
from warehouse_operations
where delivery_status='Delayed'
group by warehouse_name
) t
where rnk=1;

-- Q2. Which region has highest delays? 
select region, total_delays
from(
select region, count(delivery_status) as total_delays,
dense_rank() over(order by count(delivery_status) desc) as rnk
from warehouse_operations
where delivery_status='Delayed'
group by region
) t
where rnk=1;

-- Q3. Which delivery partner has highest delayed deliveries? 
select delivery_partner,count(*) as total_delays
from warehouse_operations
where delivery_status='Delayed'
group by delivery_partner
order by total_delays desc
limit 1;

--
select delivery_partner, total_delays
from(
select delivery_partner, count(delivery_status) as total_delays,
dense_rank() over(order by count(delivery_status) desc) as rnk
from warehouse_operations
where delivery_status='Delayed'
group by delivery_partner
) t
where rnk=1;


-- Q4. Delay percentage by warehouse 
with cte as(
select warehouse_name,count(*) as cnt
from warehouse_operations 
group by warehouse_name
)
, cte1 as(
select warehouse_name, count(*) as cnt1
from warehouse_operations 
where delivery_status='Delayed'
group by warehouse_name
)
select c.warehouse_name, round(c1.cnt1*100/c.cnt,2)  as delay_percentage
from cte c
join cte1 c1
on c.warehouse_name=c1.warehouse_name
order by delay_percentage desc


-- Q5. Average delivery delay (hours) 
select round(avg(delivery_time_hours-expected_time_hours),2) as avg_delay_hours
from warehouse_operations 
where delivery_status='Delayed';

---------------
select *
from warehouse_operations;
---------------

-- 2. Damage Analysis
-- Q1. Damage percentage 
select round(count(*)*100/(select count(*) from warehouse_operations),2) as damage_percentage
from warehouse_operations 
where damage_status='Damaged';

-- Q2. Total damage cost 
select sum(damage_cost) as total_damage_cost
from warehouse_operations
where damage_status = 'Damaged';

-- Q3. High-risk warehouses 
with cte as(
select warehouse_name,count(*) as total_deliveries
from warehouse_operations
group by warehouse_name
)
, cte1 as(
select warehouse_name, count(*) as damaged_count
from warehouse_operations
where damage_status = 'Damaged'
group by warehouse_name
)
select c.warehouse_name, c.total_deliveries, c1.damaged_count, round((c1.damaged_count*100.0/c.total_deliveries),2) as damage_percentage
from cte c 
join cte1 c1
on c.warehouse_name=c1.warehouse_name
order by damage_percentage desc;


-- Q4. Shift-wise damages 
select shift, count(*) as shift_damages
from warehouse_operations
where damage_status='Damaged'
group by shift
order by shift_damages desc;

-- Q5. Region-wise damage rate 
with cte as(
select region,count(*) as total_deliveries
from warehouse_operations
group by region
)
, cte1 as(
select region, count(*) as damaged_count
from warehouse_operations
where damage_status = 'Damaged'
group by region
)
select c.region, c.total_deliveries, c1.damaged_count, round((c1.damaged_count*100.0/c.total_deliveries),2) as damage_percentage
from cte c 
join cte1 c1
on c.region=c1.region
order by damage_percentage desc;


----------------
select *
from warehouse_operations;

----
-- 3. SLA Analysis 
-- Q1. SLA Compliance % --> Total deliveries me se kitni deliveries promise ke andar complete hui?
select round(count(*)*100.0/(select count(*) from warehouse_operations),2) as SLA_Compliance_Percentage
from warehouse_operations
where sla_status='Within SLA'

-- Q2.SLA Breach % 
select round(count(*)*100.0/(select count(*) from warehouse_operations),2) as SLA_Breach_Percentage
from warehouse_operations
where sla_status='Breached SLA';

-- Q3.Warehouse SLA Performance -->Har warehouse apna delivery promise kitna achhe se fulfill kar raha hai.
with cte as(
select warehouse_name, count(*) as count_within_SLA
from warehouse_operations
where sla_status='Within SLA'
group by warehouse_name
),
cte1 as(
select warehouse_name, count(*) as total_shipments
from warehouse_operations
group by warehouse_name
)
select c.warehouse_name, c1.total_shipments, c.count_within_SLA, round(c.count_within_SLA*100.0/c1.total_shipments,2) as SLA_Compliance_Percentage
from cte c
join cte1 c1
on c.warehouse_name=c1.warehouse_name
order by SLA_Compliance_Percentage desc

-- Q4. Delivery Partner SLA Performance 
with cte as(
select delivery_partner, count(*) as count_within_SLA
from warehouse_operations
where sla_status='Within SLA'
group by delivery_partner
),
cte1 as(
select delivery_partner, count(*) as total_shipments
from warehouse_operations
group by delivery_partner
)
select c.delivery_partner, c1.total_shipments, c.count_within_SLA, round(c.count_within_SLA*100.0/c1.total_shipments,2) as SLA_Compliance_Percentage
from cte c
join cte1 c1
on c.delivery_partner=c1.delivery_partner
order by SLA_Compliance_Percentage desc

-- Q5. Region-wise SLA Compliance 
with cte as(
select region, count(*) as count_within_SLA
from warehouse_operations
where sla_status='Within SLA'
group by region
),
cte1 as(
select region, count(*) as total_shipments
from warehouse_operations
group by region
)
select c.region, c1.total_shipments, c.count_within_SLA, round(c.count_within_SLA*100.0/c1.total_shipments,2) as SLA_Compliance_Percentage
from cte c
join cte1 c1
on c.region=c1.region
order by SLA_Compliance_Percentage desc

------
select *
from warehouse_operations;
-----

-- 4. Operational Analysis 
-- Q1. Weather impact on deliveries 
select weather_condition, count(*) as delayed_deliveries
from warehouse_operations
where delivery_status='Delayed'
group by weather_condition
order by delayed_deliveries desc;

-- Q2. Vehicle performance 
select vehicle_type, count(*) as delayed_deliveries
from warehouse_operations
where delivery_status='Delayed'
group by vehicle_type
order by delayed_deliveries desc;

-- Q3. Average Delivery Time by Delivery Mode
Select delivery_mode,
       round(avg(delivery_time_hours), 2) as avg_delivery_time_hours
from warehouse_operations
group by delivery_mode
order by avg_delivery_time_hours desc;

-- Q4.Regional performance -->Average Delivery Time by Region
select region, round(avg(delivery_time_hours),2) as avg_delivery_time_hours
from warehouse_operations
group by region
order by avg_delivery_time_hours desc;

-- Q5. Shift-wise Delivery Performance → Avg delivery time by shift
select shift, round(avg(delivery_time_hours),2) as avg_delivery_time_hours
from warehouse_operations
group by shift
order by avg_delivery_time_hours desc; 

-- Q6. Package Type Performance → Average Delivery Time by Package Type
select package_type, round(avg(delivery_time_hours),2) as avg_delivery_time_hours
from warehouse_operations
group by package_type
order by avg_delivery_time_hours desc; 

----------
select *
from warehouse_operations;
-----------

-- 5. Cost Analysis 
-- Q1. Average delivery cost by region 
select region, round(avg(delivery_cost),2) as avg_delivery_cost
from warehouse_operations
group by region
order by avg_delivery_cost desc

-- Q2. Avg Delivery cost by vehicle 
select vehicle_type, round(avg(delivery_cost),2) as avg_delivery_cost
from warehouse_operations
group by vehicle_type
order by avg_delivery_cost desc

-- Q3.Cost vs Distance -->Jaise-jaise distance badhta hai, delivery cost kaise change hoti hai?
with cte as(
select 
case 
when distance_km<=50 then 'Short Distance'
when distance_km<=150 then 'Medium Distance'
when distance_km<=250 then 'Long Distance'
else 'Very Long Distance'
end as distance_bucket
, delivery_cost
from warehouse_operations
)

select distance_bucket, round(avg(delivery_cost),2) as avg_delivery_cost
from cte 
group by distance_bucket
order by avg_delivery_cost desc

-- Q4.Cost vs Package Weight 
with cte as(
select 
case 
when package_weight_kg<=10 then 'Light Weight'
when package_weight_kg<=20 then 'Medium Weight'
when package_weight_kg<=35 then 'Heavy Weight'
else 'Very Heavy Weight'
end as weight_bucket
, delivery_cost
from warehouse_operations
)

select weight_bucket, round(avg(delivery_cost),2) as avg_delivery_cost
from cte 
group by weight_bucket
order by avg_delivery_cost desc

-- Q5. Average Delivery Cost Across Delivery Modes
select delivery_mode,round(avg(delivery_cost),2) as Avg_Delivery_Cost
from warehouse_operations
group by delivery_mode
order by Avg_Delivery_Cost desc;

-----
select *
from warehouse_operations;
------

-- 6. Warehouse Performance Analysis 
-- Q1. Total deliveries by warehouse 
select warehouse_name, count(*) as total_deliveries
from warehouse_operations
where delivery_status='Delivered'
group by warehouse_name
order by total_deliveries desc

-- Q2. Warehouse rating comparison -->avg
select warehouse_name, round(avg(delivery_rating),2) as avg_rating
from warehouse_operations
where delivery_status='Delivered'
group by warehouse_name
order by avg_rating desc;

-- Q3. Warehouse with highest failed deliveries 
select t.warehouse_name, t.failed_delivery_count
from (
select warehouse_name, count(*) as failed_delivery_count,
dense_rank() over(order by count(*) desc) as rnk
from warehouse_operations
where delivery_status='Failed'
group by warehouse_name
)t
where t.rnk=1

-- Q4. Top performing warehouse  -->Warehouse with Highest Delivery Success Rate (%)
with cte as(
select warehouse_name, count(*) as total_shipments
from warehouse_operations
group by warehouse_name
),
cte1 as(
select warehouse_name,  count(*) as delivered_count
from warehouse_operations
where delivery_status='Delivered'
group by warehouse_name
)
,cte2 as(
select c.warehouse_name,c.total_shipments, c1.delivered_count, round(delivered_count*100.0/total_shipments,2) as success_percentage
from cte c
join cte1 c1
on c.warehouse_name=c1.warehouse_name
)
select t.warehouse_name,t.total_shipments, t.delivered_count, t.success_percentage
from(
select warehouse_name, total_shipments, delivered_count, success_percentage,
dense_rank() over(order by success_percentage desc) rnk
from cte2
)t
where t.rnk=1

----
select *
from warehouse_operations;
-----

-- 7. Delivery Partner Analysis 
-- Q1. Total deliveries by partner 
select delivery_partner, count(*) as total_delivery_count
from warehouse_operations
where delivery_status='Delivered'
group by delivery_partner
order by total_delivery_count desc;

-- Q2. Average rating by partner 
select delivery_partner, round(avg(delivery_rating),2) as avg_rating
from warehouse_operations
where delivery_status='Delivered'
group by delivery_partner
order by avg_rating desc;

-- Q3. Failed deliveries by partner 
select delivery_partner, count(*) as failed_delivery_count
from warehouse_operations
where delivery_status='Failed'
group by delivery_partner
order by failed_delivery_count desc;

-- Q4. Damaged deliveries by partner 
select delivery_partner, count(*) as damaged_delivery_count
from warehouse_operations
where damage_status='Damaged'
group by delivery_partner
order by damaged_delivery_count desc;

-- Q5. On-time delivery percentage by partner
with cte as(
select delivery_partner, count(*) as total_delivery_count
from warehouse_operations
group by delivery_partner
),
cte1 as(
select delivery_partner, count(*) as delayed_count
from warehouse_operations
where `delayed`='No'
group by delivery_partner
)
select c.delivery_partner, round(c1.delayed_count*100.0/c.total_delivery_count,2) as on_time_delivery_percentage
from cte c
join cte1 c1
on c.delivery_partner=c1.delivery_partner
order by on_time_delivery_percentage desc;

----
select *
from warehouse_operations;
----

-- 8. Customer Experience Analysis 
-- Q1. Average delivery rating 
select round(avg(delivery_rating),2) as avg_delivery_rating
from warehouse_operations
where delivery_status = 'Delivered';

-- Q2. Rating by region 
select region,round(avg(delivery_rating),2) as avg_rating
from warehouse_operations
where delivery_status = 'Delivered'
group by region
order by avg_rating desc;

-- Q3. Rating by delivery partner 
select delivery_partner, round(avg(delivery_rating),2) as avg_rating
from warehouse_operations
where delivery_status = 'Delivered'
group by delivery_partner
order by avg_rating desc;

-----
select *
from warehouse_operations;
-----

-- 9. Failure & Root Cause Analysis 
-- Q1. Delivery status distribution 
select delivery_status, count(*) as shipment_count, round(count(*)*100.0/(select count(*) from warehouse_operations),2) as shipment_percentage
from warehouse_operations
group by delivery_status
order by shipment_percentage desc;

-- Q2. Reasons Behind Unsuccessful Deliveries
select delay_reason, count(*) as delay_reason_count
from warehouse_operations
-- where delay_reason<>'No Major Issue'
where delivery_status<>'Delivered'
group by delay_reason
order by delay_reason_count desc;

-- Q3. Weather vs Failed Deliveries
select weather_condition, count(*) as failed_delivery_count
from warehouse_operations
where delivery_status='Failed'
group by weather_condition
order by failed_delivery_count desc;






























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































# Database Individual Project
# GH1027535
# ABC Company Database

# QUERIES

use database_individual_project;

# 1) Detail of suppliers and the number of products that they supply:

create view suppliers_products_info as
select s.id as supplier_id, s.name as supplier_name, s.address, s.email, s.tel_number, count(pc.id) as number_of_products_supplied
from suppliers s 
left join product_catalog pc on s.id = pc.supplier_id 
group by supplier_id

# 2) 10 best-selling products with supplier and total amount

create view best_selling_products as
select pc.id as product_id, pc.name as product_name, s.id as supplier_id, s.name as supplier_name, sum(oi.quantity) as total_quantity_ordered, sum(pc.price*oi.quantity) as total_amount_paid 
from ordered_items oi 
join product_catalog pc on oi.product_id = pc.id  
join suppliers s on pc.supplier_id = s.id
group by pc.id
order by total_quantity_ordered desc
limit 10

# 3) List of Customers and Purchases

create view customer_purchases as
select cm.id as customer_id, cm.full_name as customer_name, sum(pc.price*oi.quantity) as purchase_total
from ordered_items oi 
join order_management om on oi.order_id = om.id 
join customer_management cm on om.customer_id = cm.id 
join product_catalog pc on oi.product_id = pc.id 
group by cm.id
order by cm.id asc

# 4) List of Returend Items

create view returned_items_list as
select pc.id as product_id, pc.name as product_name, sum(ri.quantity_returned) as number_returned
from returned_items ri 
join ordered_items oi on ri.ordered_items_id = oi.id 
join product_catalog pc on oi.product_id = pc.id
group by pc.id 

# 5) List of Fashion Products Sold in Last Month

create view fashion_products_last_month as
select pc.id as product_id, pc.name as product_name, om.`date` as order_date
from ordered_items oi 
join product_catalog pc on oi.product_id = pc.id 
join order_management om on oi.order_id = om.id 
where pc.category = 'fashion' and om.`date`>=date_sub(current_date(), interval 1 month)
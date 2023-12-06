SELECT 'countries' AS answer_table, COUNT(1) FROM sh.countries UNION ALL
SELECT 'customers', COUNT(1) FROM sh.customers UNION ALL
SELECT 'channels', COUNT(1) FROM sh.channels UNION ALL
SELECT 'times', COUNT(1) FROM sh.times UNION ALL
SELECT 'products', COUNT(1) FROM sh.products UNION ALL
SELECT 'promotions', COUNT(1) FROM sh.promotions UNION ALL
SELECT 'costs', COUNT(1) FROM sh.costs UNION ALL
SELECT 'sales', COUNT(1) FROM sh.sales UNION ALL
SELECT 'supplementary_demographics', COUNT(1) FROM sh.supplementary_demographics
UNION ALL
SELECT 'profits', COUNT(1) FROM sh.profits;

SELECT p.prod_category, SUM(s.amount_sold) AS total_sales_amount
FROM sh.sales s
JOIN sh.products p ON s.prod_id = p.prod_id
JOIN sh.times t ON s.time_id = t.time_id
WHERE t.time_id  BETWEEN '2000-12-30' AND '2001-12-31' 
GROUP BY p.prod_category;

SELECT co.country_region, AVG(s.quantity_sold) AS avg_sales_quantity
FROM sh.sales s
JOIN sh.customers c ON s.cust_id = c.cust_id
JOIN sh.countries co ON c.country_id = co.country_id
WHERE s.prod_id = 14
GROUP BY co.country_region;

SELECT c.cust_id, c.cust_first_name AS first_name, c.cust_last_name AS last_name, SUM(s.amount_sold) AS total_sales_amount
FROM sh.sales s
JOIN sh.customers c ON s.cust_id = c.cust_id
GROUP BY c.cust_id, c.cust_first_name, c.cust_last_name
ORDER BY total_sales_amount DESC
LIMIT 5;






/*
    views
*/


CREATE VIEW time_sale AS
SELECT s.amount_sold, s.quantity_sold, t.*
FROM sh.sales s
JOIN sh.times t ON s.time_id = t.time_id;

SELECT * FROM sales_by_time;


CREATE VIEW product_sale AS
SELECT s.amount_sold, s.quantity_sold, p.prod_name, p.prod_category, p.prod_desc
FROM sh.sales s
JOIN sh.products p ON s.prod_id = p.prod_id;

SELECT * FROM sales_by_product;


CREATE VIEW customer_sale AS
SELECT s.amount_sold, s.quantity_sold, c.cust_first_name, c.cust_last_name, c.cust_gender, co.country_name_hist
FROM sh.sales s
JOIN sh.customers c ON s.cust_id = c.cust_id
JOIN sh.countries co ON c.country_id = co.country_id;

SELECT * FROM sales_by_customer;


CREATE VIEW channel_sale AS
SELECT s.amount_sold, s.quantity_sold, ch.channel_desc
FROM sh.sales s
JOIN sh.channels ch ON s.channel_id = ch.channel_id;




CREATE VIEW promotion_sale AS
SELECT s.amount_sold, s.quantity_sold, p.promo_name, p.promo_category
FROM sh.sales s
JOIN sh.promotions p ON s.promo_id = p.promo_id;


CREATE VIEW product_cost AS
SELECT p.prod_name, p.prod_category, p.prod_desc, 
	SUM(c.unit_cost) AS total_unit_cost,
    SUM(c.unit_price) AS total_unit_price
FROM sh.costs c
JOIN sh.products p ON c.prod_id = p.prod_id
GROUP BY p.prod_name, p.prod_category, p.prod_desc;


CREATE VIEW promotion_cost AS
SELECT 
    pr.promo_name,
    pr.promo_category,
    SUM(c.unit_cost) AS total_unit_cost,
    SUM(c.unit_price) AS total_unit_price
FROM sh.costs c
JOIN sh.promotions pr ON c.promo_id = pr.promo_id
GROUP BY pr.promo_name, pr.promo_category;



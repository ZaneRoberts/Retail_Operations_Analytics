SELECT
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / SUM(sales) AS profit_margin,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(quantity) AS units_sold,
    SUM(sales)
        / COUNT(DISTINCT order_id)
        AS average_order_value
FROM fact_orders;

SELECT
    strftime('%Y-%m', order_date) AS month,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / SUM(sales) AS profit_margin,
    COUNT(DISTINCT order_id) AS orders
FROM fact_orders
GROUP BY month
ORDER BY month;

SELECT
    c.region,
    SUM(f.sales) AS revenue,
    SUM(f.profit) AS profit,
    SUM(f.profit) / SUM(f.sales) AS profit_margin,
    COUNT(DISTINCT f.order_id) AS orders
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY profit DESC;

SELECT
    p.category,
    p.sub_category,
    SUM(f.sales) AS revenue,
    SUM(f.profit) AS profit,
    SUM(f.profit) / SUM(f.sales) AS profit_margin
FROM fact_orders f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY
    p.category,
    p.sub_category
ORDER BY profit_margin ASC;

SELECT
    p.product_name,
    SUM(f.sales) AS revenue,
    SUM(f.profit) AS profit,
    SUM(f.profit) / SUM(f.sales) AS profit_margin
FROM fact_orders f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(f.sales) > 1000
ORDER BY profit_margin ASC;

SELECT
    CASE
        WHEN discount = 0 THEN '0%'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        WHEN discount <= 0.30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_band,
    COUNT(*) AS order_lines,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    SUM(profit) / SUM(sales) AS profit_margin
FROM fact_orders
GROUP BY discount_band
ORDER BY discount_band;

SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    COUNT(DISTINCT f.order_id) AS orders,
    SUM(f.sales) AS revenue,
    SUM(f.profit) AS profit,
    SUM(f.profit) / SUM(f.sales)
        AS profit_margin
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.segment
ORDER BY profit DESC;

SELECT
    c.region,
    AVG(f.shipping_days)
        AS avg_shipping_days,
    SUM(f.sales)
        AS revenue,
    SUM(f.profit)
        AS profit
FROM fact_orders f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY avg_shipping_days DESC;

SELECT
    f.shipping_days,
    COUNT(DISTINCT f.order_id) AS orders,
    SUM(f.sales) AS revenue,
    SUM(f.profit) AS profit
FROM fact_orders f
GROUP BY f.shipping_days
ORDER BY f.shipping_days;
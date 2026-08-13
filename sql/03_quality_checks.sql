SELECT
    order_id,
    COUNT(*) AS row_count
FROM fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    order_id,
    product_id,
    COUNT(*) AS row_count
FROM fact_orders
GROUP BY
    order_id,
    product_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS orphaned_customers
FROM fact_orders f
LEFT JOIN dim_customer c
    ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orphaned_products
FROM fact_orders f
LEFT JOIN dim_product p
    ON f.product_id = p.product_id
WHERE p.product_id IS NULL;
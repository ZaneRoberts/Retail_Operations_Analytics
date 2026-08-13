DROP TABLE IF EXISTS fact_orders;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_customer (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT,
    segment TEXT,
    city TEXT,
    state TEXT,
    region TEXT
);

CREATE TABLE dim_product (
    product_id TEXT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    sub_category TEXT
);

CREATE TABLE dim_date (
    date TEXT PRIMARY KEY,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name TEXT
);

CREATE TABLE fact_orders (
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    customer_id TEXT,
    product_id TEXT,
    quantity INTEGER,
    sales REAL,
    discount REAL,
    profit REAL,
    shipping_days INTEGER,

    FOREIGN KEY(customer_id)
        REFERENCES dim_customer(customer_id),

    FOREIGN KEY(product_id)
        REFERENCES dim_product(product_id),

    FOREIGN KEY(order_date)
        REFERENCES dim_date(date)
);
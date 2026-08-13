import pandas as pd
from sqlalchemy import create_engine


DB_PATH = "sqlite:///database/retail_analytics.db"


def load_database():

    engine = create_engine(DB_PATH)

    df = pd.read_csv(
        "data/processed/clean_orders.csv"
    )

    customers = (
        df[
            [
                "customer_id",
                "customer_name",
                "segment",
                "city",
                "state",
                "region"
            ]
        ]
        .drop_duplicates(
            subset=["customer_id"]
        )
    )

    products = (
        df[
            [
                "product_id",
                "product_name",
                "category",
                "sub_category"
            ]
        ]
        .drop_duplicates(
            subset=["product_id"]
        )
    )

    orders = df[
        [
            "order_id",
            "order_date",
            "ship_date",
            "customer_id",
            "product_id",
            "quantity",
            "sales",
            "discount",
            "profit",
            "shipping_days"
        ]
    ]

    customers.to_sql(
        "dim_customer",
        engine,
        if_exists="replace",
        index=False
    )

    products.to_sql(
        "dim_product",
        engine,
        if_exists="replace",
        index=False
    )

    orders.to_sql(
        "fact_orders",
        engine,
        if_exists="replace",
        index=False
    )

    print("Database loaded successfully.")


if __name__ == "__main__":
    load_database()
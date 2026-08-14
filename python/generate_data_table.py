import pandas as pd

orders = pd.read_csv(
    "data/processed/clean_orders.csv"
)

dates = pd.DataFrame({
    "date": pd.date_range(
        orders["order_date"].min(),
        orders["order_date"].max(),
        freq="D"
    )
})

dates["year"] = dates["date"].dt.year
dates["quarter"] = dates["date"].dt.quarter
dates["month"] = dates["date"].dt.month
dates["month_name"] = dates["date"].dt.month_name()
dates["day_of_week"] = dates["date"].dt.day_name()

dates.to_csv(
    "data/processed/dim_date.csv",
    index=False
)
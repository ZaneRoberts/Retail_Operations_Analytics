from pathlib import Path
import pandas as pd
import numpy as np


RAW_FILE = Path("data/raw/sample_-_superstore.xls")
OUTPUT_DIR = Path("data/processed")


def clean_data():

    df = pd.read_excel(RAW_FILE, engine="xlrd")

    # Standardize column names
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
        .str.replace("-", "_")
    )

    # Convert dates
    df["order_date"] = pd.to_datetime(df["order_date"])
    df["ship_date"] = pd.to_datetime(df["ship_date"])

    # Numeric columns
    numeric_columns = [
        "sales",
        "quantity",
        "discount",
        "profit"
    ]

    for column in numeric_columns:
        df[column] = pd.to_numeric(
            df[column],
            errors="coerce"
        )

    # Remove exact duplicates
    df = df.drop_duplicates()

    # Create shipping duration
    df["shipping_days"] = (
        df["ship_date"] - df["order_date"]
    ).dt.days

    return df


if __name__ == "__main__":

    OUTPUT_DIR.mkdir(
        parents=True,
        exist_ok=True
    )

    df = clean_data()

    output_file = OUTPUT_DIR / "clean_orders.csv"

    df.to_csv(
        output_file,
        index=False
    )

    print(f"Saved {len(df):,} rows")
    print(f"Output: {output_file}")
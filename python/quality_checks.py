import pandas as pd


def run_quality_checks(df):

    checks = {}

    checks["duplicate_rows"] = df.duplicated().sum()

    checks["missing_order_id"] = df["order_id"].isna().sum()

    checks["missing_customer_id"] = df["customer_id"].isna().sum()

    checks["negative_sales"] = (
        df["sales"] < 0
    ).sum()

    checks["invalid_quantity"] = (
        df["quantity"] <= 0
    ).sum()

    checks["invalid_discount"] = (
        (df["discount"] < 0) |
        (df["discount"] > 1)
    ).sum()

    checks["invalid_shipping_days"] = (
        df["shipping_days"] < 0
    ).sum()

    return checks


if __name__ == "__main__":

    df = pd.read_csv(
        "data/processed/clean_orders.csv"
    )

    results = run_quality_checks(df)

    for check, value in results.items():
        status = "PASS" if value == 0 else "FAIL"

        print(
            f"{status}: {check} = {value}"
        )
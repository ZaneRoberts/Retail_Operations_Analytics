from pathlib import Path
import pandas as pd

RAW_DIR = Path("data/raw")


def load_superstore():
    # 1. Look for .xls files instead of .csv
    files = list(RAW_DIR.glob("*.xls"))

    if not files:
        raise FileNotFoundError("No Excel 97 (.xls) file found in data/raw/")

    file_path = files[0]

    print(f"Loading: {file_path}")

    # 2. Use read_excel with the 'xlrd' engine needed for legacy .xls files
    df = pd.read_excel(file_path, engine="xlrd")

    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")

    return df


if __name__ == "__main__":
    df = load_superstore()
    print(df.head())
from dotenv import load_dotenv
import os
import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas

load_dotenv()

source_path = "/Users/viveksuresh/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/northstar-data-platform/data/raw/olist"

conn = snowflake.connector.connect(
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database="NORTHSTAR",
    schema="RAW"
)

def load_raw_data(source_path, conn):
    for file_name in sorted(os.listdir(source_path)):
        if not file_name.endswith(".csv"):
            continue

        table_name = file_name.replace("_dataset.csv", "").replace(".csv", "")
        file_path = os.path.join(source_path, file_name)

        print(f"Loading {table_name}...")

        df = pd.read_csv(file_path)
        df.columns = [col.upper() for col in df.columns]
        df["_LOADED_AT"] = pd.Timestamp.now()

        success, nchunks, nrows, _ = write_pandas(
            conn,
            df,
            table_name.upper(),
            database="NORTHSTAR",
            schema="RAW",
            auto_create_table=False
        )

        if not success:
            raise RuntimeError(f"Failed to load {table_name}")

        print(f"Loaded {nrows} rows into {table_name}")

    print("RAW data load complete.")

load_raw_data(source_path, conn)
conn.close()

import os
import snowflake.connector

source_path = "/Users/viveksuresh/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/northstar-data-platform/sql/ddl"

#Snowflake connection
conn = snowflake.connector.connect(
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database="NORTHSTAR",
    schema="RAW"
)

#Read sql files
def read_sql(source_path):
    sql_file = {}

    for file_name in os.listdir(source_path):
        if file_name.endswith(".sql"):
            tab_name = file_name.replace(".sql","")
            file_path = os.path.join(source_path, file_name)

            with open(file_path, "r") as file:
                sql = file.read()

        sql_file[tab_name] = sql
    return sql_file

sql_file = read_sql(source_path)

#Run sql
def execute_sql(sql_file, conn):
    cursor = conn.cursor()

    for table, sql in sql_file.items():
        print(f"Executing {table}")
        cursor.execute(sql)
    
execute_sql(sql_file, conn)



#libraries
import pandas as pd
import os

#configuration
source_path = "/Users/viveksuresh/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/northstar-data-platform/data/raw/olist"
target_path = "/Users/viveksuresh/Library/Mobile Documents/com~apple~CloudDocs/Development/Projects/northstar-data-platform/sql/ddl"

#Read CSV headers
def read_csv_header(source_path):
    csv_headers ={}
    for file_name in os.listdir(source_path):
        if file_name.endswith(".csv"):
            df = pd.read_csv(os.path.join(source_path, file_name), nrows=0)
            table_name = file_name.replace("_dataset.csv","").replace(".csv","")
            csv_headers[table_name] = list(df.columns)
    return csv_headers

csv_headers = read_csv_header(source_path)

#Determine data type
def infer_data_type(csv_headers):
    data_types = {}
    for table_name, col in csv_headers.items():
        col_types = {}
        for column in col:
            if column.lower().endswith("_id"):
                col_types[column] = "VARCHAR(255)"
            elif "timestamp" in column.lower():
                col_types[column] = "TIMESTAMP_NTZ"
            elif column.lower().endswith("date"):
                col_types[column] = "DATE"
            elif "zip" in column.lower():
                col_types[column] = "VARCHAR(255)"
            else:
                col_types[column] = "VARCHAR(255)"

        data_types[table_name] = col_types

    return data_types

data_types = infer_data_type(csv_headers)

#print(data_types)

#Generate sql string
def generate_sql_string(data_types):
    ddl_statements = {}
    for tab_name, col_dict in data_types.items():
        sql = f"create or replace table {tab_name} ("

        for col_name, dt in col_dict.items():
            sql += f"{col_name} {dt}, "

       # sql = sql.rstrip(", ")
        sql += "_loaded_at TIMESTAMP_NTZ);"
        ddl_statements[tab_name] = sql
    return ddl_statements
            

ddl_statements = generate_sql_string(data_types)
#print(ddl_statements)
#print(ddl_statements["olist_customers"])

#write sql files
def write_sql_files(ddl_statements, target_path):
    for table, ddl in ddl_statements.items():
        file_path = os.path.join(target_path, f"{table}.sql")

        with open(file_path, "w") as file:            
            file.write(ddl)

write_sql_files(ddl_statements, target_path)
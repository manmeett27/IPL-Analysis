import pandas as pd
import os
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql+psycopg2://postgres:010203@localhost:010203/ipl"
)

folder_path = r"D:\IPL Analysis\datasets\cleaned_datasets"

for file in os.listdir(folder_path):
    if file.endswith(".csv"):
        table_name = file.replace(".csv", "").lower()

        df = pd.read_csv(os.path.join(folder_path, file))

        df.to_sql(
            table_name,
            engine,
            if_exists="replace",
            index=False
        )

        print(f"Loaded {table_name}")

print("All tables loaded successfully!")
import os
import pandas as pd
from supabase import create_client
from dotenv import load_dotenv

load_dotenv()
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

if not SUPABASE_URL or not SUPABASE_KEY:
    raise ValueError("Missing SUPABASE_URL or SUPABASE_KEY in .env file")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)


def fetch_sales(start_date=None, end_date=None):
    try:
        query = supabase.table("sales").select("*")
        if start_date:
            query = query.gte("date", start_date)      # adjust column name
        if end_date:
            query = query.lte("date", end_date)

        all_data = []
        offset = 0
        limit = 1000
        while True:
            response = query.limit(limit).offset(offset).execute()
            data = response.data
            if not data:
                break
            all_data.extend(data)
            if len(data) < limit:
                break
            offset += limit

        return pd.DataFrame(all_data)

    except Exception as e:
        print(f"Error fetching sales from Supabase: {e}")
        print("Falling back to local CSV file 'Data/sales.csv'")
        csv_path = os.path.join("Data", "sales.csv")
        return pd.read_csv(csv_path)


def fetch_customers():
    try:
        query = supabase.table("customers").select("*")
        all_data = []
        offset = 0
        limit = 1000
        while True:
            response = query.limit(limit).offset(offset).execute()
            data = response.data
            if not data:
                break
            all_data.extend(data)
            if len(data) < limit:
                break
            offset += limit
        return pd.DataFrame(all_data)

    except Exception as e:
        print(f"Error fetching customers from Supabase: {e}")
        print("Falling back to local CSV file 'Data/customers.csv'")
        csv_path = os.path.join("Data", "customers.csv")
        return pd.read_csv(csv_path)


def fetch_products():
    try:
        query = supabase.table("products").select("*")
        all_data = []
        offset = 0
        limit = 1000
        while True:
            response = query.limit(limit).offset(offset).execute()
            data = response.data
            if not data:
                break
            all_data.extend(data)
            if len(data) < limit:
                break
            offset += limit
        return pd.DataFrame(all_data)

    except Exception as e:
        print(f"Error fetching products from Supabase: {e}")
        print("Falling back to local CSV file 'Data/products.csv'")
        csv_path = os.path.join("Data", "products.csv")
        return pd.read_csv(csv_path)
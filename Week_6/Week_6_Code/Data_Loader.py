"""
UrbanStyle Dashboard — Andmelaadimine Supabase'ist
===================================================
See moodul laadib UrbanStyle andmed Supabase'ist
ja tagastab need pandas DataFrame'idena.
"""

import os
from dotenv import load_dotenv
from supabase import create_client
import pandas as pd

# ------------------------------------------------------------
# 1. LAADI KESKKONNAMUUTUJAD JA LOOD ÜHENDUS
# ------------------------------------------------------------
load_dotenv()

supabase = create_client(
    os.getenv("SUPABASE_URL"),
    os.getenv("SUPABASE_SECRET_KEY")  # Kindlasti õige võtme nimi!
)


# ------------------------------------------------------------
# 2. FUNKTSIOONID ANDMETE LAADIMISEKS
# ------------------------------------------------------------

def load_sales():
    """
    Laadi müügitabel (Testing_Sales_Cleaned) Supabase'ist.
    Kasutab pagination'i, et kõik read kätte saada.
    """
    all_data = []
    start = 0
    page_size = 1000  # Size of each page

    while True:
        # Request a specific range of rows
        response = supabase.table("Testing_Sales_Cleaned") \
            .select("*") \
            .range(start, start + page_size - 1) \
            .execute()

        # If no data is returned, we've reached the end
        if not response.data:
            break

        # Add the fetched page of data to our list
        all_data.extend(response.data)

        # If we got fewer rows than the page size, this is the last page
        if len(response.data) < page_size:
            break

        # Move to the next page
        start += page_size

    # Convert the combined list of all rows into a DataFrame
    if all_data:
        ds = pd.DataFrame(all_data)
        if "sale_date" in ds.columns:
            ds["sale_date"] = pd.to_datetime(ds["sale_date"])
        return ds

    return pd.DataFrame()


def load_customers():
    """
    Laadi klienditabel (Testing_Customers_Cleaned) Supabase'ist.
    Tagastab: pandas DataFrame kliendiandmetega.
    """
    all_data = []
    start = 0
    page_size = 1000  # Size of each page

    while True:
        # Request a specific range of rows
        response = supabase.table("Testing_Customers_Cleaned") \
            .select("*") \
            .range(start, start + page_size - 1) \
            .execute()

        # If no data is returned, we've reached the end
        if not response.data:
            break

        # Add the fetched page of data to our list
        all_data.extend(response.data)

        # If we got fewer rows than the page size, this is the last page
        if len(response.data) < page_size:
            break

        # Move to the next page
        start += page_size

    # Convert the combined list of all rows into a DataFrame
    if all_data:
        dc = pd.DataFrame(all_data)  # dc = DataFrame Customers

        # Teisenda kuupäev õigesse formaati (kui veerg on olemas)
        if "registration_date" in dc.columns:
            dc["registration_date"] = pd.to_datetime(dc["registration_date"])
        
        return dc
    
    return pd.DataFrame()

def load_products():
    """
    Laadi tootetabel (Testing_Products_Cleaned) Supabase'ist.
    Tagastab: pandas DataFrame tooteteandmetega.
    """
    all_data = []
    start = 0
    page_size = 1000  # Size of each page

    while True:
        # Request a specific range of rows
        response = supabase.table("Testing_Products_Cleaned") \
            .select("*") \
            .range(start, start + page_size - 1) \
            .execute()

        # If no data is returned, we've reached the end
        if not response.data:
            break

        # Add the fetched page of data to our list
        all_data.extend(response.data)

        # If we got fewer rows than the page size, this is the last page
        if len(response.data) < page_size:
            break

        # Move to the next page
        start += page_size

    # Convert the combined list of all rows into a DataFrame
    if all_data:
        dp = pd.DataFrame(all_data)  # dp = DataFrame Products

        # Teisenda kuupäev õigesse formaati (kui veerg on olemas)
        if "created_at" in dp.columns:
            dp["created_at"] = pd.to_datetime(dp["created_at"])

        return dp

    return pd.DataFrame()
    print(f"🔍 load_products() returned: {len(response.data)} rows")  # ⭐ ADD THIS LINE
    if response.data:  # ✅ Parandatud: oli "iif", nüüd "if"
        dp = pd.DataFrame(response.data)  # dp = DataFrame Products
        
        # Teisenda kuupäev õigesse formaati (kui veerg on olemas)
        if "created_at" in dp.columns:
            dp["created_at"] = pd.to_datetime(dp["created_at"])
        
        return dp
    
    return pd.DataFrame()


# ------------------------------------------------------------
# 3. FUNKTSIOON ANDMETE ÜHENDAMISEKS (JOIN)
# ------------------------------------------------------------

def load_sales_with_details():
    """
    Laadi müügiandmed koos toote- ja kliendiinfoga.
    Ühendab kõik kolm tabelit (Sales, Products, Customers) üheks DataFrame'iks.
    """
    # Laadi kõik kolm tabelit
    df_sales = load_sales()
    df_products = load_products()
    df_customers = load_customers()

    # 1) JOIN: lisa toote nimi ja kategooria
    df = df_sales.merge(
        df_products[["product_id", "product_name", "category"]],
        on="product_id",
        how="left"
    )

    # 2) JOIN: lisa kliendi nimi ja linn
    df = df.merge(
        df_customers[["customer_id", "city", "first_name", "last_name"]],
        on="customer_id",
        how="left"
    )

    return df


# ------------------------------------------------------------
# 4. TESTBLOKK (käivitub ainult siis, kui jooksutad faili otse)
# ------------------------------------------------------------

if __name__ == "__main__":
    print("📡 Laen andmeid Supabase'ist...")
    
    # Laadi kõik andmed
    df = load_sales_with_details()
    
    # Kuva tulemused
    print(f"✅ Laetud {len(df)} rida andmeid.\n")
    print("📊 Esimene 5 rida:")
    print(df.head())
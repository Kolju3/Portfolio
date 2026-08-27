"""
KPI-de arvutamine koos protsendimuutusega võrreldes eelmise perioodiga.
"""

import pandas as pd
from datetime import timedelta

def compute_kpis(df_full, df_filtered, selected_cities, selected_locations, date_range):
    """
    Arvuta KPI-d ja nende muutus võrreldes sama pikkuse eelmise perioodiga.
    
    Args:
        df_full (pd.DataFrame): täielik andmestik (kõik andmed)
        df_filtered (pd.DataFrame): juba filtreeritud andmestik (praegune periood)
        selected_cities (list): valitud linnad (kasutatakse ka eelmise perioodi filtreerimiseks)
        selected_locations (list): valitud asukohad
        date_range (tuple): (algus, lõpp) datetime.date
    
    Returns:
        dict: võtmed 'current' ja 'previous' ning 'delta' iga KPI jaoks
              Näiteks:
              {
                'revenue': {'current': 1000, 'previous': 900, 'delta': 11.1},
                'orders': {'current': 50, 'previous': 45, 'delta': 11.1},
                ...
              }
    """
    # Praegused väärtused
    current_revenue = df_filtered["total_price"].sum()
    current_orders = len(df_filtered)
    current_customers = df_filtered["customer_id"].nunique()
    current_avg_order = df_filtered["total_price"].mean() if current_orders > 0 else 0

    # Eelmise perioodi arvutus (sama pikkusega)
    cur_start, cur_end = date_range
    length_days = (cur_end - cur_start).days

    prev_end = cur_start - timedelta(days=1)
    prev_start = cur_start - timedelta(days=length_days)

    # Kui eelmine algus jääb andmestikust varasemaks, võta kogu saadaolev aeg enne praegust algust
    min_date_available = df_full["sale_date"].min().date()
    if prev_start < min_date_available:
        prev_start = min_date_available

    # Kui prev_start <= prev_end, siis on eelmine periood olemas
    if prev_start <= prev_end:
        df_prev = df_full[
            (df_full["city"].isin(selected_cities)) &
            (df_full["location"].isin(selected_locations)) &
            (df_full["sale_date"].dt.date >= prev_start) &
            (df_full["sale_date"].dt.date <= prev_end)
        ].copy()
    else:
        df_prev = pd.DataFrame()

    if not df_prev.empty:
        prev_revenue = df_prev["total_price"].sum()
        prev_orders = len(df_prev)
        prev_customers = df_prev["customer_id"].nunique()
        prev_avg_order = df_prev["total_price"].mean() if prev_orders > 0 else 0
    else:
        prev_revenue = prev_orders = prev_customers = prev_avg_order = None

    # Abifunktsioon delta arvutamiseks
    def calc_delta(current, previous):
        if previous is None or previous == 0:
            return None
        return (current - previous) / previous * 100

    # Koosta tulemuste sõnastik
    result = {
        'revenue': {
            'current': current_revenue,
            'previous': prev_revenue,
            'delta': calc_delta(current_revenue, prev_revenue)
        },
        'orders': {
            'current': current_orders,
            'previous': prev_orders,
            'delta': calc_delta(current_orders, prev_orders)
        },
        'customers': {
            'current': current_customers,
            'previous': prev_customers,
            'delta': calc_delta(current_customers, prev_customers)
        },
        'avg_order': {
            'current': current_avg_order,
            'previous': prev_avg_order,
            'delta': calc_delta(current_avg_order, prev_avg_order)
        }
    }
    return result
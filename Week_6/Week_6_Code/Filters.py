"""
Filtreerimise loogika
---------------------
Funktsioon filter_data rakendab valitud filtreid andmestikule.
"""

import pandas as pd

def filter_data(df, selected_cities, date_range, selected_locations):
    """
    Rakenda filtreid andmestikule.
    
    Args:
        df (pd.DataFrame): täielik andmestik
        selected_cities (list): valitud linnad
        date_range (tuple): (alguskuupäev, lõppkuupäev) datetime.date
        selected_locations (list): valitud kohad/kanalid
    
    Returns:
        pd.DataFrame: filtreeritud andmestik
    """
    filtered = df[
        (df["city"].isin(selected_cities)) &
        (df["sale_date"].dt.date >= date_range[0]) &
        (df["sale_date"].dt.date <= date_range[1]) &
        (df["location"].isin(selected_locations))
    ].copy()
    return filtered
"""
Filtreerimise loogika
---------------------
Funktsioon filter_data rakendab valitud filtreid andmestikule.
Toetab "Unknown" väärtust, mis tähistab müüke ilma kliendi ID-ta.
"""

import pandas as pd

def filter_data(df, selected_cities, date_range, selected_locations):
    """
    Rakenda filtreid andmestikule.
    
    Args:
        df (pd.DataFrame): täielik andmestik
        selected_cities (list): valitud linnad (võib sisaldada "Unknown")
        date_range (tuple): (alguskuupäev, lõppkuupäev) datetime.date
        selected_locations (list): valitud kohad/kanalid
    
    Returns:
        pd.DataFrame: filtreeritud andmestik
    """
    filtered = df.copy()
    
    # Filter by cities: handle "Unknown" as NULL city
    if selected_cities:
        # If "Unknown" is selected, include rows where city is NULL
        if "Unknown" in selected_cities:
            # Keep rows where city is in selected_cities OR city is NULL
            city_mask = (filtered["city"].isin(selected_cities)) | (filtered["city"].isna())
        else:
            # Only keep rows where city is in selected_cities
            city_mask = filtered["city"].isin(selected_cities)
        
        filtered = filtered[city_mask]
    
    # Filter by date
    filtered = filtered[
        (filtered["sale_date"].dt.date >= date_range[0]) &
        (filtered["sale_date"].dt.date <= date_range[1])
    ]
    
    # Filter by location
    if selected_locations:
        filtered = filtered[filtered["location"].isin(selected_locations)]
    
    return filtered
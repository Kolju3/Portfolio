import pandas as pd

def filter_data(df, selected_cities, date_range, selected_locations):
    filtered = df.copy()
    
    if selected_cities:
        if "Teadmata" in selected_cities:
            city_mask = (filtered["city"].isin(selected_cities)) | (filtered["city"].isna())
        else:
            city_mask = filtered["city"].isin(selected_cities)
        filtered = filtered[city_mask]
    
    filtered = filtered[
        (filtered["sale_date"].dt.date >= date_range[0]) &
        (filtered["sale_date"].dt.date <= date_range[1])
    ]
    
    if selected_locations:
        filtered = filtered[filtered["location"].isin(selected_locations)]
    
    return filtered
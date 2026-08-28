"""
UrbanStyle Investor Dashboard — põhirakendus
Kasutab eraldi mooduleid:
- Data_Loader: andmete laadimine
- Filters: filtreerimise loogika
- Kpi: KPI-de arvutamine
- Charts: diagrammide loomine
"""

import streamlit as st
import pandas as pd
from Data_Loader import load_sales_with_details
from Filters import filter_data
from KPI import compute_kpis
from Charts import create_revenue_trend, create_top_products, create_sales_by_city

# ------------------------------------------------------------
# LEHE SEADISTAMINE
# ------------------------------------------------------------
st.set_page_config(
    page_title="UrbanStyle Dashboard",
    page_icon="📊",
    layout="wide"
)

# ------------------------------------------------------------
# ANDMETE LAADIMINE (CACHE)
# ------------------------------------------------------------
@st.cache_data(ttl=300)
def get_data():
    return load_sales_with_details()

df = get_data()
if df.empty:
    st.error("❌ Andmeid ei õnnestunud laadida. Kontrolli ühendust ja Supabase'i võtmeid.")
    st.stop()

# Teisenda kuupäev
df["sale_date"] = pd.to_datetime(df["sale_date"])

# ------------------------------------------------------------
# KÜLGPANEEL – FILTRITE HANKIMINE
# ------------------------------------------------------------
st.sidebar.header("🔍 Filtrid")

# Get all unique cities (excluding NULL)
all_cities = sorted(df["city"].dropna().unique())

# Add "Teadmata" as an option for sales without customer ID
all_cities_with_teadmata = ["Teadmata"] + all_cities

# City filter with "Teadmata" option
selected_cities = st.sidebar.multiselect(
    "Linnad (vali 'Teadmata' et näidata kliendita müüke)",
    options=all_cities_with_teadmata,
    default=all_cities_with_teadmata    
)

# Date filter
min_date = df["sale_date"].min().date()
max_date = df["sale_date"].max().date()
date_range = st.sidebar.date_input(
    "Ajavahemik",
    value=(min_date, max_date),
    min_value=min_date,
    max_value=max_date
)

# Location filter
all_locations = sorted(df["location"].dropna().unique())
selected_locations = st.sidebar.multiselect(
    "Müügikanalid / Asukohad",
    options=all_locations,
    default=all_locations
)

# ------------------------------------------------------------
# ANDMETE FILTREERIMINE
# ------------------------------------------------------------
df_filtered = filter_data(df, selected_cities, date_range, selected_locations)

if df_filtered.empty:
    st.warning("⚠️ Valitud filtritega andmeid ei leitud. Palun muuda filtreid.")
    st.stop()

# ------------------------------------------------------------
# KPI-D
# ------------------------------------------------------------
kpis = compute_kpis(df, df_filtered, selected_cities, selected_locations, date_range)

# ------------------------------------------------------------
# KUVAMINE
# ------------------------------------------------------------
st.title("📊 UrbanStyle Investor Dashboard")
st.markdown("*Reaalajas müügiandmed investorkoosoleku ettevalmistuseks*")
st.divider()

# KPI kaardid
col1, col2, col3, col4, col5 = st.columns(5)

# Abifunktsioon delta stringi vormindamiseks
def format_delta(delta):
    if delta is None:
        return None
    return f"{delta:+.1f}%"

col1.metric(
    label="Kogumüügitulu",
    value=f"€{kpis['revenue']['current']:,.0f}",
    delta=format_delta(kpis['revenue']['delta'])
)

col2.metric(
    label="Tellimusi",
    value=f"{kpis['orders']['current']:,}",
    delta=format_delta(kpis['orders']['delta'])
)

col3.metric(
    label="Unikaalseid kliente",
    value=f"{kpis['customers']['current']:,}",
    delta=format_delta(kpis['customers']['delta'])
)

col4.metric(
    label="Keskmine tellimus",
    value=f"€{kpis['avg_order']['current']:,.2f}",
    delta=format_delta(kpis['avg_order']['delta'])
)

col5.metric(
    label="❓ Tundmatud kliendid",
    value=f"{kpis['missing_customer']['current']:,}",
    delta=format_delta(kpis['missing_customer']['delta'])
)

st.divider()

# ------------------------------------------------------------
# DIAGRAMMID
# ------------------------------------------------------------
st.header("📈 Müügitrendid")
fig_trend = create_revenue_trend(df_filtered)
st.plotly_chart(fig_trend, use_container_width=True)

col_left, col_right = st.columns(2)

with col_left:
    st.header("🏆 Top Tooted")
    fig_products = create_top_products(df_filtered)
    st.plotly_chart(fig_products, use_container_width=True)

with col_right:
    st.header("🏙️ Kliendid asukoha järgi")
    fig_cities = create_sales_by_city(df_filtered)
    st.plotly_chart(fig_cities, use_container_width=True)

st.divider()
st.caption(
    f"UrbanStyle.ltd — Investor Dashboard | "
    f"DACA Programm, Nädal 5 | "
    f"Andmeid: {len(df_filtered):,} rida"
)
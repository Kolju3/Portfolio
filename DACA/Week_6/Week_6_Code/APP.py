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

all_cities = sorted(df["city"].dropna().unique())
selected_cities = st.sidebar.multiselect(
    "Linnad", options=all_cities, default=all_cities
)

min_date = df["sale_date"].min().date()
max_date = df["sale_date"].max().date()
date_range = st.sidebar.date_input(
    "Ajavahemik",
    value=(min_date, max_date),
    min_value=min_date,
    max_value=max_date
)

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
col1, col2, col3, col4 = st.columns(4)

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
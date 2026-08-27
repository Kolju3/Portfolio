"""
UrbanStyle Dashboard — Diagrammide Loomine
============================================
Kolm põhidiagrammi: müügitrend, top tooted, müük linnade kaupa.
"""

import pandas as pd
import plotly.express as px


def create_revenue_trend(df):
    """
    Joondiagramm: igakuine müügitulu.
    Lisatud: kolme suurima kuu tähised (punased tärnid ja väärtused).
    """
    if df.empty:
        return px.line(title="Andmed puuduvad")

    monthly = (
        df.groupby(df["sale_date"].dt.to_period("M"))["total_price"]
        .sum()
        .reset_index()
    )
    monthly["sale_date"] = monthly["sale_date"].dt.to_timestamp()

    fig = px.line(
        monthly,
        x="sale_date",
        y="total_price",
        title="UrbanStyle igakuine müügitulu",
        labels={"sale_date": "Kuu", "total_price": "Müügitulu (EUR)"}
    )

    fig.update_layout(
        font_family="Arial",
        title_font_size=20,
        hovermode="x unified",
        yaxis_tickformat=",.0f",
        yaxis_tickprefix="€",
    )

    # Keskmine joon
    avg_revenue = monthly["total_price"].mean()
    fig.add_hline(
        y=avg_revenue,
        line_dash="dash",
        line_color="gray",
        annotation_text=f"Keskmine: €{avg_revenue:,.0f}",
        annotation_position="top right"
    )

    # Kolm suurimat kuud
    top_months = monthly.nlargest(3, "total_price")
    if not top_months.empty:
        fig.add_scatter(
            x=top_months["sale_date"],
            y=top_months["total_price"],
            mode="markers+text",
            marker=dict(size=14, color="red", symbol="star"),
            text=top_months["total_price"].apply(lambda v: f"€{v/1000:.1f}k"),
            textposition="top center",
            name="Top kuud",
            showlegend=True
        )

    return fig


def create_top_products(df, top_n=10):
    """
    Horisontaalne tulpdiagramm: top N toodet müügitulu järgi.
    Tulbadel kuvatakse pidevalt ligikaudne väärtus (nt 3.0k).
    """
    if df.empty:
        return px.bar(title="Andmed puuduvad")

    product_revenue = (
        df.groupby("product_name")["total_price"]
        .sum()
        .reset_index()
        .sort_values("total_price", ascending=False)
        .head(top_n)
        .sort_values("total_price", ascending=True)   # parem visuaal
    )

    # Tekstisildid (3.0k, 3.1k jne)
    product_revenue["label"] = product_revenue["total_price"].apply(
        lambda x: f"{x/1000:.1f}k"
    )

    fig = px.bar(
        product_revenue,
        x="total_price",
        y="product_name",
        orientation="h",
        title=f"Top {top_n} toodet müügitulu järgi",
        labels={"total_price": "Müügitulu (EUR)", "product_name": "Toode"},
        color="total_price",
        color_continuous_scale="Teal",
        text="label"
    )

    fig.update_layout(
        font_family="Arial",
        title_font_size=20,
        showlegend=False,
        xaxis_tickformat=",.0f",
        xaxis_tickprefix="€",
        coloraxis_showscale=False
    )

    fig.update_traces(
        textposition="outside",
        textfont_size=12
    )

    return fig


def create_sales_by_city(df):
    """Sektordiagramm: müügitulu jaotus linnade kaupa."""
    if df.empty:
        return px.pie(title="Andmed puuduvad")

    city_revenue = (
        df.groupby("city")["total_price"]
        .sum()
        .reset_index()
        .sort_values("total_price", ascending=False)
    )

    # Väikesed linnad (>5%) koondame "Muud"
    total = city_revenue["total_price"].sum()
    city_revenue["osakaal"] = city_revenue["total_price"] / total
    main_cities = city_revenue[city_revenue["osakaal"] >= 0.05].copy()
    other_total = city_revenue[city_revenue["osakaal"] < 0.05]["total_price"].sum()
    if other_total > 0:
        other_row = pd.DataFrame({
            "city": ["Muud linnad"],
            "total_price": [other_total],
            "osakaal": [other_total / total]
        })
        main_cities = pd.concat([main_cities, other_row], ignore_index=True)

    fig = px.pie(
        main_cities,
        values="total_price",
        names="city",
        title="Müügitulu jaotus linnade kaupa",
        color_discrete_sequence=px.colors.qualitative.Set2
    )

    fig.update_traces(
        textposition="inside",
        textinfo="percent+label",
        hovertemplate="<b>%{label}</b><br>Tulu: €%{value:,.0f}<br>Osakaal: %{percent}<extra></extra>"
    )

    fig.update_layout(
        font_family="Arial",
        title_font_size=20
    )

    return fig
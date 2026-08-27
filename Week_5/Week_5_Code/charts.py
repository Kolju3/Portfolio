"""
UrbanStyle Dashboard — Diagrammide Loomine
============================================
Kolm põhidiagrammi: müügitrend, top tooted, müük linnade kaupa.
"""

import pandas as pd
import plotly.express as px
from data_loader import load_sales_with_details


def prepare_data():
    """Laadi ja ettevalmista andmed diagrammide jaoks."""
    df = load_sales_with_details()
    return df


def create_revenue_trend(df):
    """
    Joondiagramm: igakuine müügitulu.
    Näitab UrbanStyle müügitrendi ajas.
    """
    # Samm 1: Grupeeri müügid kuu kaupa (nagu SQL GROUP BY)
    monthly = (
        df.groupby(df["sale_date"].dt.to_period("M"))["total_price"]
        .sum()
        .reset_index()
    )

    # Samm 2: Teisenda periood tagasi kuupäevaks (Plotly vajab)
    monthly["sale_date"] = monthly["sale_date"].dt.to_timestamp()

    # ⭐ DEBUG: Trüki konsooli, et näha, mida grupeeriti
    print("🛠️ Grupeeritud kuuandmed:")
    print(monthly)
    print(f"📅 Kuupäevade vahemik: {df['sale_date'].min()} kuni {df['sale_date'].max()}")

    # Samm 3: Loo joondiagramm
    fig = px.line(
        monthly,
        x="sale_date",
        y="total_price",
        title="UrbanStyle igakuine müügitulu",
        labels={
            "sale_date": "Kuu",
            "total_price": "Müügitulu (EUR)"
        }
    )

    # Samm 4: Kohanda välimust
    fig.update_layout(
        font_family="Arial",
        title_font_size=20,
        hovermode="x unified",
        yaxis_tickformat=",.0f",
        yaxis_tickprefix="€",
    )

    # Samm 5: Lisa keskmine joon
    avg_revenue = monthly["total_price"].mean()
    fig.add_hline(
        y=avg_revenue,
        line_dash="dash",
        line_color="gray",
        annotation_text=f"Keskmine: €{avg_revenue:,.0f}",
        annotation_position="top right"
    )

    return fig


def create_top_products(df, top_n=10):
    """
    Vertikaalne tulpdiagramm: top N toodet müügitulu järgi.
    """
    # Samm 1: Grupeeri toote nime järgi ja summeeri
    product_revenue = (
        df.groupby("product_name")["total_price"]
        .sum()
        .reset_index()
        .sort_values("total_price", ascending=False)  # Sorteeri langev
        .head(top_n)                                    # Võta top N
    )
      # Samm 2: Sorteeri tagasi kasvavasse järjekorda (visuaaliks parem)
    product_revenue = product_revenue.sort_values("total_price", ascending=True)
 
    # # Samm 3: Loo vertikaalne tulpdiagramm
    # fig = px.bar(
    #     product_revenue,
    #     y="total_price",                              # tulba pikkus
    #     x="product_name",                              # tootenimi
    #     orientation="v",                               # vertikaalne
    #     title=f"Top {top_n} toodet müügitulu järgi",
    #     labels={
    #         "product_name": "Toode",
    #         "total_price": "Müügitulu (EUR)"
    #     },
    #     color="total_price",                           # värvi tulbad väärtuse järgi
    #     color_continuous_scale="Greens",                  # värviskeem
    #     range_color=[product_revenue["total_price"].min() * 0.1, product_revenue["total_price"].max()]
    # )

  # Samm 3: Loo horisontaalne tulpdiagramm
    fig = px.bar(
        product_revenue,
        x="total_price",                              # tulba pikkus
        y="product_name",                              # tootenimi
        orientation="h",                               # horisontaalne
        title=f"Top {top_n} toodet müügitulu järgi",
        labels={
            "total_price": "Müügitulu (EUR)",
            "product_name": "Toode"
        },
        color="total_price",                           # värvi tulbad väärtuse järgi
        color_continuous_scale="Teal"                  # värviskeem
    )

 
    # Samm 4: Kohanda välimust
    fig.update_layout(
        font_family="Arial",
        title_font_size=20,
        showlegend=False,                              # peida legend (pole vajalik)
        yaxis_tickformat=",.0f",
        yaxis_tickprefix="€",
        coloraxis_showscale=False                      # peida värviskala
    )
 
    return fig

def create_sales_by_city(df):
    """
    Sektordiagramm: müügitulu jaotus linnade kaupa.
    Näitab, milline linn genereerib kõige rohkem tulu.
    """
    # Samm 1: Grupeeri linna järgi
    city_revenue = (
        df.groupby("city")["total_price"]
        .sum()
        .reset_index()
        .sort_values("total_price", ascending=False)
    )
 
    # Samm 2: Grupeeri väiksemad linnad kokku ("Muud")
    # Linnad, mis annavad alla 5% kogutulust, koondatakse
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
 
    # Samm 3: Loo sektordiagramm
    fig = px.pie(
        main_cities,
        values="total_price",                          # sektori suurus
        names="city",                                  # sektori nimi
        title="Müügitulu jaotus linnade kaupa",
        color_discrete_sequence=px.colors.qualitative.Set2  # värviskeem
    )
 
    # Samm 4: Kohanda välimust
    fig.update_traces(
        textposition="inside",                         # tekst sektori sees
        textinfo="percent+label",                      # näita protsenti ja nime
        hovertemplate="<b>%{label}</b><br>"
                      "Tulu: €%{value:,.0f}<br>"
                      "Osakaal: %{percent}<extra></extra>"
    )
 
    fig.update_layout(
        font_family="Arial",
                title_font_size=20
    )
 
    return fig

# ------------------------------------------------------------
# KUI JOKSUTAD SEDA FAILI OTSE, SIIS KUVA DIAGRAMM
# ------------------------------------------------------------
if __name__ == "__main__":
    df = prepare_data()
    
    # 1. Kuva müügitrend
    fig1 = create_revenue_trend(df)
    fig1.show()
    
    # 2. Kuva top tooted
    fig2 = create_top_products(df, top_n=10)
    fig2.show()

    # 3. Kuva müük linnade kaupa
    fig3 = create_sales_by_city(df)
    fig3.show()
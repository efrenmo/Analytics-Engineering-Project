{{
    config(
        materialized = 'incremental',        
        incremental_strategy = 'merge',
        unique_key = ['WAREHOUSE_SK', 'ITEM_SK', 'yr_wk_num',],
        schema = 'BI_ANALYTICS'
    )
}}



{% if is_incremental() %}
    -- Defining the LAST_SOLD_YR_WK_QUERY function
    {% set LAST_SOLD_YR_WK_QUERY %}
        SELECT IFNULL(max(yr_wk_num), 0) from {{this}} as LAST_SOLD_YR_WK
    {% endset %}
    -- When executing the function
    {% if execute %}
        {% set LAST_SOLD_YR_WK = run_query(LAST_SOLD_YR_WK_QUERY).columns[0][0] %} -- [('DATE')]
    {% endif %}

{% endif %}


-- Set LATEST_SOLD_DATE_SK to filter sales table
    -- Defining the get_date_sk_query function
    {% set get_date_sk_query %}
        SELECT min(D_DATE_SK) from {{ source('airbyte_raw', 'DATE_DIM') }}
            {% if is_incremental() %}
                where yr_wk_num = '{{LAST_SOLD_YR_WK}}'
            {% endif %}
    {% endset %}

    -- When executing the function
    {% if execute %}
        {% set LATEST_DATE_SK = run_query(get_date_sk_query).columns[0][0] %} -- [('DATE')]
    {% endif %}


WITH 
    ALL_SALES as(
        SELECT 
            CS_SOLD_DATE_SK AS SOLD_DATE_SK,
            CS_WAREHOUSE_SK AS WAREHOUSE_SK,
            CS_ITEM_SK AS ITEM_SK,
            CS_QUANTITY AS QUANTITY,
            CS_NET_PROFIT AS NET_PROFIT, 
            CS_SALES_PRICE * CS_QUANTITY AS SALES_AMT
        FROM {{ source('airbyte_raw', 'CATALOG_SALES') }}
        WHERE SOLD_DATE_SK >= '{{LATEST_DATE_SK}}'

        UNION

        SELECT
            WS_SOLD_DATE_SK AS SOLD_DATE_SK,
            WS_WAREHOUSE_SK AS WAREHOUSE_SK,
            WS_ITEM_SK AS ITEM_SK,
            WS_QUANTITY AS QUANTITY,
            WS_NET_PROFIT AS NET_PROFIT, 
            WS_SALES_PRICE * WS_QUANTITY AS SALES_AMT
        FROM {{ source('airbyte_raw', 'WEB_SALES') }}
        WHERE SOLD_DATE_SK >= '{{LATEST_DATE_SK}}'
),
    DAILY_SALES as (
        SELECT             
            SOLD_DATE_SK, 
            WAREHOUSE_SK, 
            ITEM_SK, 
            MNTH_NUM, 
            YR_NUM, 
            YR_WK_NUM, 
            SUM(QUANTITY) AS DAILY_QTY, 
            SUM(NET_PROFIT) AS DAILY_PROFIT,
            SUM(sales_amt) AS DAILY_SALES_AMT
        FROM ALL_SALES
        LEFT JOIN {{ source('airbyte_raw', 'DATE_DIM') }} ON SOLD_DATE_SK = D_DATE_SK        
        GROUP BY 1,2,3,4,5,6
    )


SELECT  
    WAREHOUSE_SK,
    ITEM_SK,
    YR_NUM,
    MNTH_NUM,
    YR_WK_NUM,        
    MIN(SOLD_DATE_SK) AS WK_DT_SK,
    SUM(DAILY_QTY) AS SUM_QTY_WK,
    SUM(DAILY_SALES_AMT) AS SUM_AMT_WK,
    SUM(DAILY_PROFIT) AS SUM_PROFIT_WK,
    SUM(DAILY_QTY)/7 AS AVG_QTY_DY,
    SUM(COALESCE(INV_QUANTITY_ON_HAND, 0)) AS INV_ON_HAND_QTY_WK,
    SUM(COALESCE(INV_QUANTITY_ON_HAND, 0))/SUM(DAILY_QTY) AS WKS_SPLY,
    IFF(AVG_QTY_DY>0 AND AVG_QTY_DY>INV_ON_HAND_QTY_WK, TRUE, FALSE) AS LOW_STOCK_FLG_WK
FROM DAILY_SALES
JOIN {{ source('airbyte_raw', 'INVENTORY') }} ON SOLD_DATE_SK = INV_DATE_SK AND ITEM_SK = INV_ITEM_SK AND WAREHOUSE_SK = INV_WAREHOUSE_SK
GROUP BY 1,2,3,4,5



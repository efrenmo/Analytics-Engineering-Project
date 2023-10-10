-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
                
                
            
        
    

    

    merge into TPCDS.BI_ANALYTICS.weekly_sales_inventory as DBT_INTERNAL_DEST
        using TPCDS.BI_ANALYTICS.weekly_sales_inventory__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.WAREHOUSE_SK = DBT_INTERNAL_DEST.WAREHOUSE_SK
                ) and (
                    DBT_INTERNAL_SOURCE.ITEM_SK = DBT_INTERNAL_DEST.ITEM_SK
                ) and (
                    DBT_INTERNAL_SOURCE.yr_wk_num = DBT_INTERNAL_DEST.yr_wk_num
                )

    
    when matched then update set
        "WAREHOUSE_SK" = DBT_INTERNAL_SOURCE."WAREHOUSE_SK","ITEM_SK" = DBT_INTERNAL_SOURCE."ITEM_SK","YR_NUM" = DBT_INTERNAL_SOURCE."YR_NUM","MNTH_NUM" = DBT_INTERNAL_SOURCE."MNTH_NUM","YR_WK_NUM" = DBT_INTERNAL_SOURCE."YR_WK_NUM","SUM_QTY_WK" = DBT_INTERNAL_SOURCE."SUM_QTY_WK","SUM_AMT_WK" = DBT_INTERNAL_SOURCE."SUM_AMT_WK","SUM_PROFIT_WK" = DBT_INTERNAL_SOURCE."SUM_PROFIT_WK","AVG_QTY_DY" = DBT_INTERNAL_SOURCE."AVG_QTY_DY","INV_ON_HAND_QTY_WK" = DBT_INTERNAL_SOURCE."INV_ON_HAND_QTY_WK","WKS_SPLY" = DBT_INTERNAL_SOURCE."WKS_SPLY","LOW_STOCK_FLG_WK" = DBT_INTERNAL_SOURCE."LOW_STOCK_FLG_WK"
    

    when not matched then insert
        ("WAREHOUSE_SK", "ITEM_SK", "YR_NUM", "MNTH_NUM", "YR_WK_NUM", "SUM_QTY_WK", "SUM_AMT_WK", "SUM_PROFIT_WK", "AVG_QTY_DY", "INV_ON_HAND_QTY_WK", "WKS_SPLY", "LOW_STOCK_FLG_WK")
    values
        ("WAREHOUSE_SK", "ITEM_SK", "YR_NUM", "MNTH_NUM", "YR_WK_NUM", "SUM_QTY_WK", "SUM_AMT_WK", "SUM_PROFIT_WK", "AVG_QTY_DY", "INV_ON_HAND_QTY_WK", "WKS_SPLY", "LOW_STOCK_FLG_WK")

;
    commit;
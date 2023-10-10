select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select WAREHOUSE_SK
from TPCDS.BI_ANALYTICS.v2_weekly_sales_inventory
where WAREHOUSE_SK is null



      
    ) dbt_internal_test
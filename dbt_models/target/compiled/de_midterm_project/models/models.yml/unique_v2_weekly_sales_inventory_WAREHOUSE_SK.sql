
    
    

select
    WAREHOUSE_SK as unique_field,
    count(*) as n_records

from TPCDS.BI_ANALYTICS.v2_weekly_sales_inventory
where WAREHOUSE_SK is not null
group by WAREHOUSE_SK
having count(*) > 1



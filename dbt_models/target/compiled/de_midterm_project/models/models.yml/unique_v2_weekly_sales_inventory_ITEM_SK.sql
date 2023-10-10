
    
    

select
    ITEM_SK as unique_field,
    count(*) as n_records

from TPCDS.BI_ANALYTICS.v2_weekly_sales_inventory
where ITEM_SK is not null
group by ITEM_SK
having count(*) > 1



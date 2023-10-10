select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select i_item_sk
from TPCDS.RAW.ITEM
where i_item_sk is null



      
    ) dbt_internal_test
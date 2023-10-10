select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select p_item_sk
from TPCDS.RAW.PROMOTION
where p_item_sk is null



      
    ) dbt_internal_test
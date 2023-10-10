-- Use the `ref` function to select from other models

select *
from TPCDS.RAW.my_first_dbt_model
where id = 1
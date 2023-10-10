select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select WS_SHIP_DATE_SK as from_field
    from TPCDS.RAW.WEB_SALES
    where WS_SHIP_DATE_SK is not null
),

parent as (
    select D_DATE_SK as to_field
    from DATE_DIM
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test
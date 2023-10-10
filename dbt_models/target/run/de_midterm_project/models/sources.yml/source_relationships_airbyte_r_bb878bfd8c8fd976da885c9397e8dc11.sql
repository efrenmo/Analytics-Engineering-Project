select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select P_ITEM_SK as from_field
    from TPCDS.RAW.PROMOTION
    where P_ITEM_SK is not null
),

parent as (
    select I_ITEM_SK as to_field
    from ITEM
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test
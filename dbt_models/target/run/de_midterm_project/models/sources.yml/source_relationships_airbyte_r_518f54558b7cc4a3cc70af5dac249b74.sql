select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select CS_PROMO_SK as from_field
    from TPCDS.RAW.CATALOG_SALES
    where CS_PROMO_SK is not null
),

parent as (
    select P_PROMO_SK as to_field
    from PROMOTION
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test
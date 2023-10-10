
    
    

with child as (
    select CS_BILL_CDEMO_SK as from_field
    from TPCDS.RAW.CATALOG_SALES
    where CS_BILL_CDEMO_SK is not null
),

parent as (
    select CD_DEMO_SK as to_field
    from CUSTOMER_DEMOGRAPHICS
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



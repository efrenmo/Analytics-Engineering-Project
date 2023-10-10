
    
    

with child as (
    select CS_BILL_ADDR_SK as from_field
    from TPCDS.RAW.CATALOG_SALES
    where CS_BILL_ADDR_SK is not null
),

parent as (
    select CA_ADDRESS_SK as to_field
    from CUSTOMER_ADDRESS
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



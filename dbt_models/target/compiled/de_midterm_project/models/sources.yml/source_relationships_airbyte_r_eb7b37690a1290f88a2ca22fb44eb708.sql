
    
    

with child as (
    select WS_BILL_CUSTOMER_SK as from_field
    from TPCDS.RAW.WEB_SALES
    where WS_BILL_CUSTOMER_SK is not null
),

parent as (
    select C_CUSTOMER_SK as to_field
    from CUSTOMER
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



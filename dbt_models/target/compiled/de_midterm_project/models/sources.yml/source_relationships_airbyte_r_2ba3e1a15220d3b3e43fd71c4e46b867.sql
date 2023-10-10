
    
    

with child as (
    select INV_DATE_SK as from_field
    from TPCDS.RAW.INVENTORY
    where INV_DATE_SK is not null
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




    
    

with child as (
    select INV_ITEM_SK as from_field
    from TPCDS.RAW.INVENTORY
    where INV_ITEM_SK is not null
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



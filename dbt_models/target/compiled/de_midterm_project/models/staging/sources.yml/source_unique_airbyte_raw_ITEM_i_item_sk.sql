
    
    

select
    i_item_sk as unique_field,
    count(*) as n_records

from TPCDS.RAW.ITEM
where i_item_sk is not null
group by i_item_sk
having count(*) > 1



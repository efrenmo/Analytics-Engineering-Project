
    
    

select
    p_item_sk as unique_field,
    count(*) as n_records

from TPCDS.RAW.PROMOTION
where p_item_sk is not null
group by p_item_sk
having count(*) > 1




    
    

select
    P_PROMO_SK as unique_field,
    count(*) as n_records

from TPCDS.BI_ANALYTICS.promotion_item
where P_PROMO_SK is not null
group by P_PROMO_SK
having count(*) > 1




    
    

select
    C_CUSTOMER_SK as unique_field,
    count(*) as n_records

from TPCDS.RAW.CUSTOMER
where C_CUSTOMER_SK is not null
group by C_CUSTOMER_SK
having count(*) > 1



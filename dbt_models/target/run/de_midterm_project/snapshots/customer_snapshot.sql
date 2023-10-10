
      begin;
    merge into "TPCDS"."STAGE"."CUSTOMER_SNAPSHOT" as DBT_INTERNAL_DEST
    using "TPCDS"."STAGE"."CUSTOMER_SNAPSHOT__dbt_tmp" as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     and DBT_INTERNAL_DEST.dbt_valid_to is null
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert ("C_SALUTATION", "C_PREFERRED_CUST_FLAG", "C_FIRST_SALES_DATE_SK", "C_CUSTOMER_SK", "C_LOGIN", "C_CURRENT_CDEMO_SK", "C_FIRST_NAME", "C_CURRENT_HDEMO_SK", "C_CURRENT_ADDR_SK", "C_LAST_NAME", "C_CUSTOMER_ID", "C_LAST_REVIEW_DATE_SK", "C_BIRTH_MONTH", "C_BIRTH_COUNTRY", "C_BIRTH_YEAR", "C_BIRTH_DAY", "C_EMAIL_ADDRESS", "C_FIRST_SHIPTO_DATE_SK", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")
        values ("C_SALUTATION", "C_PREFERRED_CUST_FLAG", "C_FIRST_SALES_DATE_SK", "C_CUSTOMER_SK", "C_LOGIN", "C_CURRENT_CDEMO_SK", "C_FIRST_NAME", "C_CURRENT_HDEMO_SK", "C_CURRENT_ADDR_SK", "C_LAST_NAME", "C_CUSTOMER_ID", "C_LAST_REVIEW_DATE_SK", "C_BIRTH_MONTH", "C_BIRTH_COUNTRY", "C_BIRTH_YEAR", "C_BIRTH_DAY", "C_EMAIL_ADDRESS", "C_FIRST_SHIPTO_DATE_SK", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")

;
    commit;
  
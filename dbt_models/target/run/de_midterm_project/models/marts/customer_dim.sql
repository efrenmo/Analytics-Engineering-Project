
  
    

        create or replace transient table TPCDS.BI_ANALYTICS.customer_dim
         as
        (SELECT
    C_SALUTATION,
	C_PREFERRED_CUST_FLAG,
	C_FIRST_SALES_DATE_SK,
	C_CUSTOMER_SK,
	C_LOGIN,
	C_CURRENT_CDEMO_SK,
	C_FIRST_NAME,
	C_CURRENT_HDEMO_SK,
	C_CURRENT_ADDR_SK,
	C_LAST_NAME,
	C_CUSTOMER_ID,
	C_LAST_REVIEW_DATE_SK,
	C_BIRTH_MONTH,
	C_BIRTH_COUNTRY,
	C_BIRTH_YEAR,
	C_BIRTH_DAY,
	C_EMAIL_ADDRESS,
	C_FIRST_SHIPTO_DATE_SK,
	CA_STREET_NAME,
	CA_SUITE_NUMBER,
	CA_STATE,
	CA_LOCATION_TYPE,
	CA_COUNTRY,
	CA_ADDRESS_ID,
	CA_COUNTY,
	CA_STREET_NUMBER,
	CA_ZIP,
	CA_CITY,
	CA_STREET_TYPE,
	CA_GMT_OFFSET,
	CD_DEP_EMPLOYED_COUNT,
	CD_DEP_COUNT,
	CD_CREDIT_RATING,
	CD_EDUCATION_STATUS,
	CD_PURCHASE_ESTIMATE,
	CD_MARITAL_STATUS,
	CD_DEP_COLLEGE_COUNT,
	CD_GENDER,
	HD_BUY_POTENTIAL,
	HD_DEP_COUNT,
	HD_VEHICLE_COUNT,
	HD_INCOME_BAND_SK,
	IB_LOWER_BOUND,
	IB_UPPER_BOUND,
	dbt_valid_from as valid_from,
    dbt_valid_to as valid_to	    
FROM TPCDS.STAGE.customer_snapshot
JOIN TPCDS.RAW.CUSTOMER_ADDRESS on c_current_addr_sk = ca_address_sk
JOIN TPCDS.RAW.CUSTOMER_DEMOGRAPHICS on c_current_cdemo_sk = cd_demo_sk
JOIN TPCDS.RAW.HOUSEHOLD_DEMOGRAPHICS on c_current_hdemo_sk = hd_demo_sk
JOIN TPCDS.RAW.INCOME_BAND on hd_income_band_sk = ib_income_band_sk 
WHERE dbt_valid_to is null
        );
      
  
SELECT 
    P_START_DATE_SK,
    P_CHANNEL_CATALOG,
    P_CHANNEL_DEMO,
    P_CHANNEL_EMAIL,
    P_END_DATE_SK,
    P_CHANNEL_PRESS,
    P_CHANNEL_TV,
    P_DISCOUNT_ACTIVE,
    P_CHANNEL_DETAILS,
    P_PURPOSE,
    P_COST,
    P_PROMO_ID,
    P_CHANNEL_EVENT,
    P_ITEM_SK,
    P_RESPONSE_TARGET,
    P_PROMO_SK,
    P_PROMO_NAME,
    P_CHANNEL_DMAIL,
    P_CHANNEL_RADIO,
    I_ITEM_DESC,
    I_CONTAINER,
    I_MANUFACT_ID,
    I_WHOLESALE_COST,
    I_BRAND_ID,
    I_FORMULATION,
    I_CURRENT_PRICE,
    I_SIZE,
    I_MANUFACT,
    I_REC_START_DATE,
    I_MANAGER_ID,
    I_CLASS,
    I_ITEM_ID,
    I_CLASS_ID,
    I_CATEGORY,
    I_CATEGORY_ID,
    I_BRAND,
    I_UNITS,
    I_COLOR,
    I_PRODUCT_NAME,
    I_REC_END_DATE
FROM TPCDS.RAW.PROMOTION 
JOIN TPCDS.RAW.ITEM ON P_ITEM_SK = I_ITEM_SK
WHERE P_PROMO_SK IS NOT NULL
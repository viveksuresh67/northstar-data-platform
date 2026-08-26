select
    SELLER_ID, 
    SELLER_ZIP_CODE_PREFIX, 
    SELLER_CITY, 
    SELLER_STATE
from {{ source('olist', 'olist_sellers') }}
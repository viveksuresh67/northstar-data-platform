select
    ORDER_ID, 
    ORDER_ITEM_ID, 
    PRODUCT_ID, 
    SELLER_ID, 
    SHIPPING_LIMIT_DATE, 
    cast(PRICE as float) as item_price, 
    cast(FREIGHT_VALUE as float) as freight_amt
from {{ source('olist', 'olist_order_items') }}
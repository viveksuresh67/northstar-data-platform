select
    ORDER_ID, 
    CUSTOMER_ID, 
    ORDER_STATUS, 
    ORDER_PURCHASE_TIMESTAMP, 
    cast(ORDER_APPROVED_AT as TIMESTAMP_NTZ) as order_approved_at_timestamp, 
    ORDER_DELIVERED_CARRIER_DATE, 
    ORDER_DELIVERED_CUSTOMER_DATE, 
    ORDER_ESTIMATED_DELIVERY_DATE
from {{ source('olist', 'olist_orders') }}
select
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_STATUS,
    ORDER_DELIVERED_CARRIER_DATE - to_date(ORDER_APPROVED_AT_TIMESTAMP) as days_to_carrier,
    (case
        when order_status = 'delivered' then ORDER_DELIVERED_CUSTOMER_DATE - ORDER_DELIVERED_CARRIER_DATE
        else NULL
    end) as days_to_customer,
    ORDER_ESTIMATED_DELIVERY_DATE - ORDER_DELIVERED_CUSTOMER_DATE as days_early_late
from {{ ref('stg_olist_orders')}}
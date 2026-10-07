Select
    order_id,
    cust.customer_id,
    cust.customer_unique_id,
    customer_city,
    customer_state,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    (CASE
        when order_estimated_delivery_date >= order_delivered_customer_date then 'pass'
        when order_estimated_delivery_date < order_delivered_customer_date then 'fail'
        else 'pending'
    end) as order_sla
from {{ ref('stg_olist_orders') }} as ord
join {{ ref('stg_olist_customers') }} as cust
    on ord.customer_id = cust.customer_id
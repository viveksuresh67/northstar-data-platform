select
    cust.customer_unique_id,
    count(DISTINCT cust.order_id) as order_count,
    min(cust.order_purchase_timestamp) as first_order_date,
    max(cust.order_purchase_timestamp) as latest_order_date
from {{ ref('int_customer_orders') }} cust
group by 1
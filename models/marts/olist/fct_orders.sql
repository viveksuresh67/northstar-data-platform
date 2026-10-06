select
    ord.order_id,
    ord.customer_id,
    ord.order_status,
    ord.order_purchase_timestamp,
    ord.order_delivered_customer_date,
    ord.order_estimated_delivery_date,
    ord.order_sla,
    pay.total_payment_value,
    pay.payment_types
from {{ ref('int_customer_orders') }} ord
left join {{ ref('int_order_payments') }} pay --keep every orders
    on ord.order_id = pay.order_id
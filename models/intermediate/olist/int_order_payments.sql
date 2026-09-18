select  
    ORDER_ID,
    count(PAYMENT_SEQUENTIAL) as payment_count,
    sum(PAYMENT_VALUE) as total_payment_value,
    listagg(distinct(payment_type), ', ') within group (order by payment_type) as payment_types
from {{ ref('stg_olist_order_payments') }}
group by 1
select
    ORDER_ID, 
    cast(PAYMENT_SEQUENTIAL as integer) as payment_sequential,
    PAYMENT_TYPE,
    cast(PAYMENT_INSTALLMENTS as integer) as payment_installments, 
    cast(PAYMENT_VALUE as number(10,2)) as payment_value
from {{ source('olist', 'olist_order_payments') }}
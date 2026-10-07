with order_items as (

    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        item_price,
        freight_amt,
        item_price + freight_amt as total_item_amount
    from {{ ref('stg_olist_order_items') }}

),

orders as (

    select
        order_id,
        customer_id,
        customer_unique_id,
        order_status,
        cast(order_purchase_timestamp as date) as order_purchase_date
    from {{ ref('int_customer_orders') }}

)

select
    oi.order_id,
    oi.order_item_id,
    ord.customer_id,
    ord.customer_unique_id,
    oi.product_id,
    oi.seller_id,
    ord.order_purchase_date,
    ord.order_status,
    oi.shipping_limit_date,
    oi.item_price,
    oi.freight_amt,
    oi.total_item_amount

from order_items oi

left join orders ord
    on oi.order_id = ord.order_id
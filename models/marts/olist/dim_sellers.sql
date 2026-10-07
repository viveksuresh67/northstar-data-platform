with grp_ord AS(
    select
        seller_id,
        count(distinct order_id) as order_count,
        sum(item_price) as total_items_sales,
        sum(freight_amt) as total_freight_amount,
        sum(freight_amt) + sum(item_price) as total_amount_charged
    from {{ ref('stg_olist_order_items') }}
    group by 1
)

select
    sel.seller_id,
    sel.seller_zip_code_prefix,
    sel.seller_city,
    sel.seller_state,
    ord.order_count,
    ord.total_items_sales,
    ord.total_freight_amount,
    ord.total_amount_charged 
from {{ ref('stg_olist_sellers') }} sel
join grp_ord ord
    on sel.seller_id = ord.seller_id
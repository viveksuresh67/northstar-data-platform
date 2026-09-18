with grp_prod as(
    select
        product_id,
        count(distinct order_id) as order_count,
        sum(item_price) as total_items_sales,
        sum(freight_amt) as total_freight_amount
    from {{ ref('stg_olist_order_items') }}
    group by 1
)

select
    pr.product_id,
    product_category_name_english as category_name,
    order_count,
    total_items_sales,
    total_freight_amount,
    total_items_sales + total_freight_amount as total_amount_charged
from {{ ref('stg_olist_products')}} as pr
join grp_prod ord
    on pr.product_id = ord.product_id
join {{ ref('stg_olist_product_category_name_translation') }} as cat
    on pr.product_category_name = cat.product_category_name
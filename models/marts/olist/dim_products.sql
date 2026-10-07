select
    prd.product_id,
    sal.category_name,
    prd.product_name_length,
    prd.product_description_length,
    prd.product_photos_qty,
    prd.product_weight_g,
    prd.product_length_cm,
    prd.product_height_cm,
    prd.product_width_cm,
    sal.order_count,
    sal.total_items_sales,
    sal.total_freight_amount,
    sal.total_amount_charged
from {{ ref('stg_olist_products') }} prd
left join {{ ref('int_product_sales') }} sal
    on  prd.product_id = sal.product_id
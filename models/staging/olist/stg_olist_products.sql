select
    PRODUCT_ID, 
    PRODUCT_CATEGORY_NAME, 
    cast(PRODUCT_NAME_LENGHT as integer) as product_name_length, 
    cast(PRODUCT_DESCRIPTION_LENGHT as integer) as product_description_length, 
    cast(PRODUCT_PHOTOS_QTY as integer) as product_photos_qty, 
    cast(PRODUCT_WEIGHT_G as integer) as product_weight_g, 
    cast(PRODUCT_LENGTH_CM as float) as product_length_cm, 
    cast(PRODUCT_HEIGHT_CM as float) as product_height_cm, 
    cast(PRODUCT_WIDTH_CM as float) as product_width_cm
from {{ source('olist', 'olist_products')}}
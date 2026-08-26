select
    PRODUCT_CATEGORY_NAME, 
    PRODUCT_CATEGORY_NAME_ENGLISH
from {{ source('olist', 'product_category_name_translation') }}
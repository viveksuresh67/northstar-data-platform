select
    REVIEW_ID, 
    ORDER_ID, 
    cast(REVIEW_SCORE as integer) as review_score , 
    REVIEW_COMMENT_TITLE, 
    REVIEW_COMMENT_MESSAGE, 
    REVIEW_CREATION_DATE, 
    REVIEW_ANSWER_TIMESTAMP
from {{ source('olist', 'olist_order_reviews') }}
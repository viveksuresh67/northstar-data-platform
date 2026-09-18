select
    order_id,
    count(*) as review_count,
    avg(review_score) as avg_review_score,
    max(
        case
            when review_comment_message is not null
                 and trim(review_comment_message) <> ''
            then 1
            else 0
        end
    ) as has_review_comment,
    avg(
        datediff(
            'day',
            review_creation_date,
            review_answer_timestamp
        )
    ) as avg_review_response_days
from {{ ref('stg_olist_order_reviews') }}
group by order_id
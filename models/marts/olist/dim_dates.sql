with base as (
    select 
        dateadd(
            day,
            row_number() over (order by 1) - 1,
            '2016-09-04'::date
        ) as calendar_date
    from table(generator(rowcount => 774))
)

select
    calendar_date,
    year(calendar_date) as year,
    quarter(calendar_date) as quarter,
    month(calendar_date) as month,
    monthname(calendar_date) as month_name,
    week(calendar_date) as week,
    day(calendar_date) as day_of_month,
    dayofweek(calendar_date) as day_of_week,
    dayname(calendar_date) as day_name,
    dayname(calendar_date) in ('Sat', 'Sun') as is_weekend
from base
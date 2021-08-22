{% set impacted_county = ["Cornwall", "Gloucestershire", "Surrey"] %}

select
    customer_id, count(*),
    {% for county in impacted_county %}
    count(case when county = '{{county}}' then customer_id end) as {{county}}_count,
    {% endfor %}
from `winter-berm-323206.company_watch.stage_data`

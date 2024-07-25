-- IMPORTS
with sources as (
    select * from {{ref('raw_customers')}}
),

with renamed_and_cleaning as (
select
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax
from
    sources
)

--query final
select * from renamed_and_cleaning
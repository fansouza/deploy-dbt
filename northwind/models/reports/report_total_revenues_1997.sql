-- models/reporting/report_total_revenues_1997.sql
-- CONFIG
{{ config(
    schema='gold',
    materialized='table'
) }}

---- IMPORT

with sources_orders_details as (
    select order_id 
    from {{ ref('stg_order_details') }}
),
sources_orders(
    select 
        *
    from {{ ref('stg_orders') }}
)

-- REGRA DE NEGOCIO

with filtered as (
    select order_id 
    from sources_orders
    where extract(year from order_date) = 1997
),

with business_rules as (
select 
    sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total_revenues_1997
from 
    sources_orders_details as order_details
inner join 
    filtered on filtered.order_id = order_details.order_id
)

-- QUERY FINAL
SELECT * FROM business_rules
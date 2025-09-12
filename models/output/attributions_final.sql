{{config(materialized = 'table')}}
SELECT 
user_pseudo_id,
channel,	
source,
medium,
first_click_conversions as conversions,
type
from {{ source('src_stg','mart_first_click') }}
union all
SELECT 
user_pseudo_id,
channel,	
source,
medium,
last_click_conversions as conversions,
type
from {{ source('src_stg','mart_last_click') }}
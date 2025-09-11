{{config(materialized = 'table')}}
SELECT
  channel,
  source,
  medium,
  SUM(conversions) AS last_click_conversions
FROM {{source('src_stg','int_user_ranks')}}
WHERE is_conversion = 1 AND event_rank_desc = 1  
GROUP BY 1, 2, 3
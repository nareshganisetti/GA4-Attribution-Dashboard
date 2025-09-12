{{config(materialized = 'table')}}
SELECT
  user_pseudo_id,
  channel,
  source,
  medium,
  SUM(conversions) AS first_click_conversions,
  'first_click' as type
FROM {{source('src_stg','int_user_ranks')}}
WHERE is_conversion = 1 AND event_rank_asc = 1  -- First event per user leading to conversion
GROUP BY 1, 2, 3,4

{{config(materialized = 'table')}}
WITH ranked_events AS (
  SELECT
    user_pseudo_id,
    event_timestamp,
    event_name,
    source,
    medium,
    channel,
    ROW_NUMBER() OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp ASC) AS event_rank_asc,  -- For first-click
    ROW_NUMBER() OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp DESC) AS event_rank_desc  -- For last-click
  FROM {{ source('src_atr_project','stg_events') }}
),
conversions AS (
  SELECT
    user_pseudo_id,
    event_timestamp AS conversion_timestamp,
    COUNT(*) AS conversions,  -- Or SUM(value) for revenue
    1 AS is_conversion
  FROM {{ source('src_atr_project','stg_events') }}
  WHERE event_name = 'purchase'
  GROUP BY 1, 2
)
SELECT
  r.*,
  c.conversions,
  c.is_conversion,
  c.conversion_timestamp
FROM ranked_events r
LEFT JOIN conversions c
  ON r.user_pseudo_id = c.user_pseudo_id
  AND r.event_timestamp <= c.conversion_timestamp
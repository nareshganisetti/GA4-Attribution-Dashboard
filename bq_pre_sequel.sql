CREATE OR REPLACE table summer-nucleus-471608-c4.attribution_test.stg_events AS
SELECT
  user_pseudo_id,
  event_timestamp,
  event_name,
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  CONCAT(traffic_source.source, '/', traffic_source.medium) AS channel,
  ecommerce.purchase_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210131';
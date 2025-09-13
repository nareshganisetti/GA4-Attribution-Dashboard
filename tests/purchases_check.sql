SELECT channel from {{source('src_stg','attributions_final')}}
where conversions < 0
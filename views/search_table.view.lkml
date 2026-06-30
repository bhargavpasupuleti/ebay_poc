view: search_table {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.search` ;;

  dimension: search_row_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(
      CAST(${TABLE}.user_id AS STRING), '|',
      CAST(${TABLE}.item_id AS STRING), '|',
      CAST(CAST(${TABLE}.cal_dt AS DATE) AS STRING)
    ) ;;
  }

  dimension_group: activity_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.cal_dt AS DATE) ;;
  }

  dimension_group: purchase_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.item_prchs_dt AS DATE) ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.prdct_nm ;;
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_nm ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }

  dimension: category_desc {
    type: string
    sql: ${TABLE}.category_desc ;;
  }

  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
  }

  dimension: item_site_id {
    type: number
    sql: ${TABLE}.item_site_id ;;
  }

  dimension: experience_level_id {
    type: number
    sql: ${TABLE}.exprnc_lvl_id ;;
  }

  dimension: srch_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.srch_cnt, 0) ;;
  }

  dimension: vi_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.vi_cnt, 0) ;;
  }

  dimension: vi_dwell_time {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.vi_dwell_time, 0) ;;
  }

  dimension: item_price {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.item_price, 0) ;;
  }

  dimension: searched_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.srch_cnt, 0) > 0 ;;
  }

  dimension: viewed_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.vi_cnt, 0) > 0 ;;
  }

  dimension: purchased_item {
    hidden: yes
    type: yesno
    sql: ${TABLE}.item_prchs_dt IS NOT NULL ;;
  }

  dimension: high_dwell_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.vi_dwell_time, 0) >= 60 ;;
  }

  set: search_drill_fields {
    fields: [
      activity_date_date,
      user_id,
      item_id,
      item_name,
      product_name,
      brand_name,
      category_id,
      category_desc,
      site_id,
      item_site_id,
      experience_level_id
    ]
  }

  measure: rows {
    type: count
    drill_fields: [search_drill_fields*]
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
  }

  measure: categories {
    type: count_distinct
    sql: ${category_id} ;;
  }

  measure: total_search_events {
    type: sum
    sql: ${srch_cnt} ;;
  }

  measure: total_view_item_events {
    type: sum
    sql: ${vi_cnt} ;;
  }

  measure: total_view_item_dwell_time {
    type: sum
    sql: ${vi_dwell_time} ;;
  }

  measure: average_item_price {
    type: average
    sql: ${item_price} ;;
    value_format_name: usd
  }

  measure: average_view_item_dwell_time {
    type: average
    sql: ${vi_dwell_time} ;;
    value_format_name: decimal_2
  }

  measure: search_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes"]
  }

  measure: view_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes"]
  }

  measure: purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [purchased_item: "yes"]
  }

  measure: search_and_view_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", viewed_item: "yes"]
  }

  measure: search_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", purchased_item: "no"]
  }

  measure: view_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", purchased_item: "no"]
  }

  measure: high_dwell_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_dwell_item: "yes"]
  }

  measure: search_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "7 days"]
  }

  measure: search_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "14 days"]
  }

  measure: search_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "30 days"]
  }

  measure: view_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", activity_date_date: "7 days"]
  }

  measure: view_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", activity_date_date: "30 days"]
  }

  measure: avg_dwell_per_view {
    type: number
    sql: SAFE_DIVIDE(${total_view_item_dwell_time}, ${total_view_item_events}) ;;
    value_format_name: decimal_2
  }

  measure: search_to_view_rate {
    type: number
    sql: SAFE_DIVIDE(${view_users}, ${search_users}) ;;
    value_format_name: percent_2
  }

  measure: view_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${view_users}) ;;
    value_format_name: percent_2
  }

  measure: search_growth_7d_to_30d {
    type: number
    sql: SAFE_DIVIDE(${search_users_last_30d} - ${search_users_last_7d}, ${search_users_last_7d}) ;;
    value_format_name: percent_2
  }
}

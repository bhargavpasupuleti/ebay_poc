view: search{
  sql_table_name: `ebay_looker_poc.search` ;;

  dimension: search_row_key {
    primary_key: yes
    hidden: yes
    type: string
    description: "Synthetic row key built from user, item, and activity date for stable row-level drill behavior."
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
    description: "Date when the browse or search activity happened."
    sql: CAST(${TABLE}.cal_dt AS DATE) ;;
  }

  dimension_group: purchase_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    description: "Date the item was eventually purchased, if it converted."
    sql: CAST(${TABLE}.item_prchs_dt AS DATE) ;;
  }

  dimension: user_id {
    type: number
    description: "Internal customer identifier tied to the browse or search activity."
    value_format: "0"
    sql: ${TABLE}.user_id ;;
  }

  dimension: item_id {
    type: number
    description: "Unique item or listing the customer interacted with."
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_name {
    type: string
    description: "Human-readable listing title used for drill and audience composition analysis."
    sql: ${TABLE}.item_name ;;
  }

  dimension: product_name {
    type: string
    description: "Product name or title the customer viewed or searched for."
    sql: ${TABLE}.prdct_nm ;;
  }

  dimension: brand_name {
    type: string
    description: "Brand associated with the item the customer searched for or viewed."
    sql: ${TABLE}.brand_nm ;;
  }

  dimension: category_id {
    type: number
    description: "Most detailed leaf category ID assigned to the item."
    sql: ${TABLE}.leaf_categ_id ;;
  }

  dimension: category_desc {
    type: string
    description: "Business-friendly category name for the item."
    sql: ${TABLE}.category_desc ;;
  }

  dimension: site_id {
    type: number
    description: "eBay market where the customer activity took place."
    sql: ${TABLE}.site_id ;;
  }

  dimension: item_site_id {
    type: number
    description: "eBay site where the item was listed."
    sql: ${TABLE}.item_site_id ;;
  }

  dimension: experience_level_id {
    type: number
    description: "Code showing the shopping experience or platform the customer used."
    sql: ${TABLE}.exprnc_lvl_id ;;
  }

  dimension: srch_cnt {
    hidden: yes
    type: number
    description: "Number of times the customer searched and reached this item or product context."
    sql: COALESCE(${TABLE}.srch_cnt, 0) ;;
  }

  dimension: vi_cnt {
    hidden: yes
    type: number
    description: "Number of times the customer viewed the item."
    sql: COALESCE(${TABLE}.vi_cnt, 0) ;;
  }

  dimension: vi_dwell_time {
    hidden: yes
    type: number
    description: "Amount of time the customer spent looking at the item page."
    sql: COALESCE(${TABLE}.vi_dwell_time, 0) ;;
  }

  dimension: item_price {
    hidden: yes
    type: number
    description: "Listed price of the item the customer interacted with."
    sql: COALESCE(${TABLE}.item_price, 0) ;;
  }

  dimension: searched_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one search event."
    sql: COALESCE(${TABLE}.srch_cnt, 0) > 0 ;;
  }

  dimension: viewed_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one item-view event."
    sql: COALESCE(${TABLE}.vi_cnt, 0) > 0 ;;
  }

  dimension: purchased_item {
    hidden: yes
    type: yesno
    description: "Yes when the item eventually converted to purchase."
    sql: ${TABLE}.item_prchs_dt IS NOT NULL ;;
  }

  dimension: high_dwell_item {
    hidden: yes
    type: yesno
    description: "Yes when the item view dwell time is at least 60 time units."
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
    description: "Raw row count at the user-item-date search grain."
    drill_fields: [search_drill_fields*]
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Distinct users in the filtered browse/search result set."
  }

  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
    description: "Distinct items in the filtered browse/search result set."
  }

  measure: categories {
    type: count_distinct
    sql: ${category_id} ;;
    description: "Distinct leaf categories in the filtered browse/search result set."
  }

  measure: total_search_events {
    type: sum
    sql: ${srch_cnt} ;;
    description: "Total search events across the filtered result set."
  }

  measure: total_view_item_events {
    type: sum
    sql: ${vi_cnt} ;;
    description: "Total item-view events across the filtered result set."
  }

  measure: total_view_item_dwell_time {
    type: sum
    sql: ${vi_dwell_time} ;;
    description: "Total dwell time accumulated across item views in the filtered result set."
  }

  measure: average_item_price {
    type: average
    sql: ${item_price} ;;
    value_format_name: usd
    description: "Average listed item price across the filtered result set."
  }

  measure: average_view_item_dwell_time {
    type: average
    sql: ${vi_dwell_time} ;;
    value_format_name: decimal_2
    description: "Average dwell time per row across the filtered result set."
  }

  measure: search_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes"]
    description: "Distinct users with at least one search event."
  }

  measure: view_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes"]
    description: "Distinct users with at least one item view."
  }

  measure: purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [purchased_item: "yes"]
    description: "Distinct users whose browsed or searched item eventually converted to purchase."
  }

  measure: search_and_view_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", viewed_item: "yes"]
    description: "Distinct users with both search and item-view activity."
  }

  measure: search_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", purchased_item: "no"]
    description: "Distinct users who searched but did not purchase."
  }

  measure: view_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", purchased_item: "no"]
    description: "Distinct users who viewed an item but did not purchase."
  }

  measure: high_dwell_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_dwell_item: "yes"]
    description: "Distinct users with high dwell time on item detail pages."
  }

  measure: search_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "7 days"]
    description: "Distinct search audience in the last 7 days."
  }

  measure: search_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "14 days"]
    description: "Distinct search audience in the last 14 days."
  }

  measure: search_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [searched_item: "yes", activity_date_date: "30 days"]
    description: "Distinct search audience in the last 30 days."
  }

  measure: view_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", activity_date_date: "7 days"]
    description: "Distinct item-view audience in the last 7 days."
  }

  measure: view_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [viewed_item: "yes", activity_date_date: "30 days"]
    description: "Distinct item-view audience in the last 30 days."
  }

  measure: avg_dwell_per_view {
    type: number
    sql: SAFE_DIVIDE(${total_view_item_dwell_time}, ${total_view_item_events}) ;;
    value_format_name: decimal_2
    description: "Average dwell time per view event."
  }

  measure: search_to_view_rate {
    type: number
    sql: SAFE_DIVIDE(${view_users}, ${search_users}) ;;
    value_format_name: percent_2
    description: "Share of search users who also viewed an item."
  }

  measure: view_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${view_users}) ;;
    value_format_name: percent_2
    description: "Share of view users whose interaction converted to purchase."
  }

  measure: search_growth_7d_to_30d {
    type: number
    sql: SAFE_DIVIDE(${search_users_last_30d} - ${search_users_last_7d}, ${search_users_last_7d}) ;;
    value_format_name: percent_2
    description: "Relative growth of the search audience from the 7-day window to the 30-day window."
  }
}

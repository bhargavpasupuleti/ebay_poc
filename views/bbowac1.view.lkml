view: bbowac {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.bbowac` ;;

  dimension: behavior_row_key {
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
    sql: ${TABLE}.prod_name ;;
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }

  dimension: category_desc {
    type: string
    sql: ${TABLE}.category_desc ;;
  }

  dimension: listing_site_id {
    type: number
    sql: ${TABLE}.lstg_site_id ;;
  }

  dimension: listing_type_cd {
    type: number
    sql: ${TABLE}.lstg_type_cd ;;
  }

  dimension: condition_rollup_id {
    type: number
    sql: ${TABLE}.cndtn_rollup_id ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}.curncy_id ;;
  }

  dimension: watch_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.watch_cnt, 0) ;;
  }

  dimension: bid_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.bid_cnt, 0) ;;
  }

  dimension: add_to_cart_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) ;;
  }

  dimension: offer_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.offer_cnt, 0) ;;
  }

  dimension: asq_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.asq_cnt, 0) ;;
  }

  dimension: item_prchsd_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) ;;
  }

  dimension: byng_trans_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.byng_trans_cnt, 0) ;;
  }

  dimension: bin_sold_ind {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.bin_sold_ind, 0) ;;
  }

  dimension: gmb_usd_amt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.gmb_usd_amt, 0) ;;
  }

  dimension: gmb_lc_amt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.gmb_lc_amt, 0) ;;
  }

  dimension: gmb_lstg_curncy_amt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.gmb_lstg_curncy_amt, 0) ;;
  }

  dimension: watched_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.watch_cnt, 0) > 0 ;;
  }

  dimension: bid_on_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.bid_cnt, 0) > 0 ;;
  }

  dimension: added_to_cart {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0 ;;
  }

  dimension: made_offer {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.offer_cnt, 0) > 0 ;;
  }

  dimension: asked_seller {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.asq_cnt, 0) > 0 ;;
  }

  dimension: purchased_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) > 0 ;;
  }

  dimension: high_intent_item {
    hidden: yes
    type: yesno
    sql: (
      COALESCE(${TABLE}.watch_cnt, 0) > 0 OR
      COALESCE(${TABLE}.bid_cnt, 0) > 0 OR
      COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0
    ) ;;
  }

  dimension: watch_no_purchase_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.watch_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: bid_no_purchase_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.bid_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: add_to_cart_no_purchase_item {
    hidden: yes
    type: yesno
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: high_intent_no_purchase_item {
    hidden: yes
    type: yesno
    sql: (
      COALESCE(${TABLE}.watch_cnt, 0) > 0 OR
      COALESCE(${TABLE}.bid_cnt, 0) > 0 OR
      COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0
    ) AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  parameter: target_audience_size {
    type: number
    default_value: "20000"
  }

  set: audience_drill_fields {
    fields: [
      activity_date_date,
      user_id,
      item_id,
      item_name,
      product_name,
      brand_name,
      category_id,
      category_desc
    ]
  }

  measure: rows {
    type: count
    drill_fields: [audience_drill_fields*]
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [audience_drill_fields*]
  }

  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
  }

  measure: total_watch_events {
    type: sum
    sql: ${watch_cnt} ;;
  }

  measure: total_bid_events {
    type: sum
    sql: ${bid_cnt} ;;
  }

  measure: total_add_to_cart_events {
    type: sum
    sql: ${add_to_cart_cnt} ;;
  }

  measure: total_offer_events {
    type: sum
    sql: ${offer_cnt} ;;
  }

  measure: total_ask_seller_events {
    type: sum
    sql: ${asq_cnt} ;;
  }

  measure: total_purchase_events {
    type: sum
    sql: ${item_prchsd_cnt} ;;
  }

  measure: total_buying_transactions {
    type: sum
    sql: ${byng_trans_cnt} ;;
  }

  measure: total_gmb_usd {
    type: sum
    sql: ${gmb_usd_amt} ;;
    value_format_name: usd
  }

  measure: total_gmb_lc {
    type: sum
    sql: ${gmb_lc_amt} ;;
    value_format_name: decimal_2
  }

  measure: watch_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes"]
    drill_fields: [audience_drill_fields*]
  }

  measure: bid_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_on_item: "yes"]
  }

  measure: add_to_cart_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [added_to_cart: "yes"]
  }

  measure: offer_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [made_offer: "yes"]
  }

  measure: ask_seller_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [asked_seller: "yes"]
  }

  measure: purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [purchased_item: "yes"]
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_item: "yes"]
  }

  measure: watch_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watch_no_purchase_item: "yes"]
  }

  measure: bid_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_no_purchase_item: "yes"]
  }

  measure: add_to_cart_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [add_to_cart_no_purchase_item: "yes"]
  }

  measure: high_intent_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_no_purchase_item: "yes"]
  }

  measure: watch_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "7 days"]
  }

  measure: watch_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "14 days"]
  }

  measure: watch_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "30 days"]
  }

  measure: watch_users_last_60d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "60 days"]
  }

  measure: watch_users_last_90d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "90 days"]
  }

  measure: bid_no_purchase_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_no_purchase_item: "yes", activity_date_date: "7 days"]
  }

  measure: high_intent_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_item: "yes", activity_date_date: "14 days"]
  }

  measure: watch_users_delta_30d_vs_7d {
    type: number
    sql: ${watch_users_last_30d} - ${watch_users_last_7d} ;;
    value_format_name: decimal_0
  }

  measure: watch_users_growth_7d_to_30d {
    type: number
    sql: SAFE_DIVIDE(${watch_users_last_30d} - ${watch_users_last_7d}, ${watch_users_last_7d}) ;;
    value_format_name: percent_2
  }

  measure: watch_users_7d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_7d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
  }

  measure: watch_users_14d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_14d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
  }

  measure: watch_users_30d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_30d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
  }

  measure: watch_users_60d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_60d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
  }

  measure: watch_users_90d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_90d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
  }

  measure: avg_items_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_purchase_events}, ${purchase_users}) ;;
    value_format_name: decimal_2
  }

  measure: avg_transactions_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_buying_transactions}, ${purchase_users}) ;;
    value_format_name: decimal_2
  }

  measure: avg_gmb_usd_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${purchase_users}) ;;
    value_format_name: usd
  }

  measure: watch_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${watch_users}) ;;
    value_format_name: percent_2
  }

  measure: bid_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${bid_users}) ;;
    value_format_name: percent_2
  }

  measure: add_to_cart_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${add_to_cart_users}) ;;
    value_format_name: percent_2
  }

  measure: high_intent_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${high_intent_users}) ;;
    value_format_name: percent_2
  }
}

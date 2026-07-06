view: bbowac {
  sql_table_name: `ebay_looker_poc.bbowac` ;;

  dimension: behavior_row_key {
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
    description: "The date the customer activity or purchase metric was recorded in the daily BBOWAC snapshot."
    sql: CAST(${TABLE}.cal_dt AS DATE) ;;
  }

  dimension: user_id {
    type: number
    description: "Internal customer identifier tied to the item-level action or buying outcome."
    value_format: "0"
    sql: ${TABLE}.user_id ;;
  }

  dimension: item_id {
    type: number
    description: "Unique item or listing identifier tied to the customer activity."
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_name {
    type: string
    description: "Human-readable item or listing title used for drill and audience composition analysis."
    sql: ${TABLE}.item_name ;;
  }

  dimension: product_name {
    type: string
    description: "Name or title of the product or listing associated with the activity."
    sql: ${TABLE}.prod_name ;;
  }

  dimension: brand_name {
    type: string
    description: "Brand associated with the item."
    sql: ${TABLE}.brand_name ;;
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

  dimension: listing_site_id {
    type: number
    description: "eBay site where the item was listed."
    sql: ${TABLE}.lstg_site_id ;;
  }

  dimension: listing_type_cd {
    type: number
    description: "Code showing how the item was listed for sale, such as auction or fixed price."
    sql: ${TABLE}.lstg_type_cd ;;
  }

  dimension: condition_rollup_id {
    type: number
    description: "Grouped code for the item condition, such as new, used, or refurbished."
    sql: ${TABLE}.cndtn_rollup_id ;;
  }

  dimension: currency_id {
    type: number
    description: "Currency identifier associated with the item or monetary value metrics."
    sql: ${TABLE}.curncy_id ;;
  }

  dimension: watch_cnt {
    hidden: yes
    type: number
    description: "Number of times the item was added to watchlist on the snapshot date."
    sql: COALESCE(${TABLE}.watch_cnt, 0) ;;
  }

  dimension: bid_cnt {
    hidden: yes
    type: number
    description: "Number of bids placed on the item on the snapshot date."
    sql: COALESCE(${TABLE}.bid_cnt, 0) ;;
  }

  dimension: add_to_cart_cnt {
    hidden: yes
    type: number
    description: "Number of times the customer added the item to cart on the snapshot date."
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) ;;
  }

  dimension: offer_cnt {
    hidden: yes
    type: number
    description: "Number of offers made on the item on the snapshot date."
    sql: COALESCE(${TABLE}.offer_cnt, 0) ;;
  }

  dimension: asq_cnt {
    hidden: yes
    type: number
    description: "Number of times the customer asked a seller question about the item."
    sql: COALESCE(${TABLE}.asq_cnt, 0) ;;
  }

  dimension: item_prchsd_cnt {
    hidden: yes
    type: number
    description: "Number of items purchased in the current reporting logic for the item-user-date row."
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) ;;
  }

  dimension: byng_trans_cnt {
    hidden: yes
    type: number
    description: "Number of buying transactions tied to the item on the snapshot date."
    sql: COALESCE(${TABLE}.byng_trans_cnt, 0) ;;
  }

  dimension: bin_sold_ind {
    hidden: yes
    type: number
    description: "Flag showing whether the item was sold through Buy It Now rather than bidding."
    sql: COALESCE(${TABLE}.bin_sold_ind, 0) ;;
  }

  dimension: gmb_usd_amt {
    hidden: yes
    type: number
    value_format_name: usd
    description: "Total merchandise value converted to USD for the row."
    sql: COALESCE(${TABLE}.gmb_usd_amt, 0) ;;
  }

  dimension: gmb_lc_amt {
    hidden: yes
    type: number
    description: "Total merchandise value in local currency for the row."
    sql: COALESCE(${TABLE}.gmb_lc_amt, 0) ;;
  }

  dimension: watched_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one watch event for the item."
    sql: COALESCE(${TABLE}.watch_cnt, 0) > 0 ;;
  }

  dimension: bid_on_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one bid on the item."
    sql: COALESCE(${TABLE}.bid_cnt, 0) > 0 ;;
  }

  dimension: added_to_cart {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one add-to-cart event for the item."
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0 ;;
  }

  dimension: made_offer {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one offer event for the item."
    sql: COALESCE(${TABLE}.offer_cnt, 0) > 0 ;;
  }

  dimension: asked_seller {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one seller-question event for the item."
    sql: COALESCE(${TABLE}.asq_cnt, 0) > 0 ;;
  }

  dimension: purchased_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains at least one purchased item."
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) > 0 ;;
  }

  dimension: high_intent_item {
    hidden: yes
    type: yesno
    description: "Yes when the item shows at least one strong intent signal: watch, bid, or add to cart."
    sql: (
      COALESCE(${TABLE}.watch_cnt, 0) > 0 OR
      COALESCE(${TABLE}.bid_cnt, 0) > 0 OR
      COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0
    ) ;;
  }

  dimension: watch_no_purchase_item {
    hidden: yes
    type: yesno
    description: "Yes when the item was watched but not purchased within the row grain."
    sql: COALESCE(${TABLE}.watch_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: bid_no_purchase_item {
    hidden: yes
    type: yesno
    description: "Yes when the item received a bid but no purchase within the row grain."
    sql: COALESCE(${TABLE}.bid_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: add_to_cart_no_purchase_item {
    hidden: yes
    type: yesno
    description: "Yes when the item was added to cart but not purchased within the row grain."
    sql: COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0 AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  dimension: high_intent_no_purchase_item {
    hidden: yes
    type: yesno
    description: "Yes when the row contains a high-intent action but no purchase."
    sql: (
      COALESCE(${TABLE}.watch_cnt, 0) > 0 OR
      COALESCE(${TABLE}.bid_cnt, 0) > 0 OR
      COALESCE(${TABLE}.add_to_cart_cnt, 0) > 0
    ) AND COALESCE(${TABLE}.item_prchsd_cnt, 0) = 0 ;;
  }

  parameter: target_audience_size {
    type: number
    default_value: "20000"
    description: "Target audience size used by gap-to-target measures when comparing recency windows."
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
      category_desc,
      listing_site_id,
      listing_type_cd
    ]
  }



  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Distinct users in the filtered BBOWAC audience."
    drill_fields: [audience_drill_fields*]
  }

  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
    description: "Distinct items represented in the filtered BBOWAC result set."
  }

  measure: total_watch_events {
    type: sum
    sql: ${watch_cnt} ;;
    description: "Total watchlist-add events across the filtered result set."
  }

  measure: total_bid_events {
    type: sum
    sql: ${bid_cnt} ;;
    description: "Total bid events across the filtered result set."
  }

  measure: total_add_to_cart_events {
    type: sum
    sql: ${add_to_cart_cnt} ;;
    description: "Total add-to-cart events across the filtered result set."
  }

  measure: total_offer_events {
    type: sum
    sql: ${offer_cnt} ;;
    description: "Total offer events across the filtered result set."
  }

  measure: total_ask_seller_events {
    type: sum
    sql: ${asq_cnt} ;;
    description: "Total ask-seller question events across the filtered result set."
  }

  measure: total_purchase_events {
    type: sum
    sql: ${item_prchsd_cnt} ;;
    description: "Total purchased-item count across the filtered result set."
  }

  measure: total_buying_transactions {
    type: sum
    sql: ${byng_trans_cnt} ;;
    description: "Total buying transactions across the filtered result set."
  }

  measure: total_gmb_usd {
    type: sum
    sql: ${gmb_usd_amt} ;;
    value_format_name: usd
    description: "Total gross merchandise bookings converted to USD across the filtered result set."
  }

  measure: total_gmb_lc {
    type: sum
    sql: ${gmb_lc_amt} ;;
    value_format_name: decimal_2
    description: "Total gross merchandise bookings in local currency across the filtered result set."
  }

  measure: watch_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes"]
    description: "Distinct users who added at least one item to watchlist in the filtered result set."
    drill_fields: [audience_drill_fields*]
  }

  measure: bid_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_on_item: "yes"]
    description: "Distinct users who placed at least one bid in the filtered result set."
  }

  measure: add_to_cart_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [added_to_cart: "yes"]
    description: "Distinct users who added at least one item to cart in the filtered result set."
  }

  measure: offer_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [made_offer: "yes"]
    description: "Distinct users who made at least one offer in the filtered result set."
  }

  measure: ask_seller_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [asked_seller: "yes"]
    description: "Distinct users who asked at least one seller question in the filtered result set."
  }

  measure: purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [purchased_item: "yes"]
    description: "Distinct users with at least one purchase in the filtered result set."
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_item: "yes"]
    description: "Distinct users with at least one high-intent action: watch, bid, or add to cart."
  }

  measure: watch_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watch_no_purchase_item: "yes"]
    description: "Distinct users who watched an item but did not purchase it at the row grain."
  }

  measure: bid_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_no_purchase_item: "yes"]
    description: "Distinct users who bid on an item but did not purchase it at the row grain."
  }

  measure: add_to_cart_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [add_to_cart_no_purchase_item: "yes"]
    description: "Distinct users who added an item to cart but did not purchase it at the row grain."
  }

  measure: high_intent_no_purchase_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_no_purchase_item: "yes"]
    description: "Distinct users with high intent but no purchase at the row grain."
  }

  measure: watch_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "7 days"]
    description: "Distinct watch audience in the last 7 days."
  }

  measure: watch_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "14 days"]
    description: "Distinct watch audience in the last 14 days."
  }

  measure: watch_users_last_30d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "30 days"]
    description: "Distinct watch audience in the last 30 days."
  }

  measure: watch_users_last_60d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "60 days"]
    description: "Distinct watch audience in the last 60 days."
  }

  measure: watch_users_last_90d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [watched_item: "yes", activity_date_date: "90 days"]
    description: "Distinct watch audience in the last 90 days."
  }

  measure: bid_no_purchase_users_last_7d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [bid_no_purchase_item: "yes", activity_date_date: "7 days"]
    description: "Distinct users who bid but did not purchase in the last 7 days."
  }

  measure: high_intent_users_last_14d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [high_intent_item: "yes", activity_date_date: "14 days"]
    description: "Distinct high-intent users in the last 14 days."
  }

  measure: watch_users_delta_30d_vs_7d {
    type: number
    sql: ${watch_users_last_30d} - ${watch_users_last_7d} ;;
    value_format_name: decimal_0
    description: "Absolute difference between the 30-day and 7-day watch audiences."
  }

  measure: watch_users_growth_7d_to_30d {
    type: number
    sql: SAFE_DIVIDE(${watch_users_last_30d} - ${watch_users_last_7d}, ${watch_users_last_7d}) ;;
    value_format_name: percent_2
    description: "Relative growth of the watch audience from the 7-day window to the 30-day window."
  }

  measure: watch_users_7d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_7d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
    description: "Absolute gap between the 7-day watch audience and the selected target audience size."
  }

  measure: watch_users_14d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_14d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
    description: "Absolute gap between the 14-day watch audience and the selected target audience size."
  }

  measure: watch_users_30d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_30d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
    description: "Absolute gap between the 30-day watch audience and the selected target audience size."
  }

  measure: watch_users_60d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_60d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
    description: "Absolute gap between the 60-day watch audience and the selected target audience size."
  }

  measure: watch_users_90d_gap_to_target {
    type: number
    sql: ABS(${watch_users_last_90d} - CAST({% parameter target_audience_size %} AS NUMERIC)) ;;
    value_format_name: decimal_0
    description: "Absolute gap between the 90-day watch audience and the selected target audience size."
  }

  measure: avg_items_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_purchase_events}, ${purchase_users}) ;;
    value_format_name: decimal_2
    description: "Average purchased-item count per distinct purchasing user."
  }

  measure: avg_transactions_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_buying_transactions}, ${purchase_users}) ;;
    value_format_name: decimal_2
    description: "Average buying transaction count per distinct purchasing user."
  }

  measure: avg_gmb_usd_per_purchase_user {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${purchase_users}) ;;
    value_format_name: usd
    description: "Average USD merchandise value per distinct purchasing user."
  }

  measure: watch_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${watch_users}) ;;
    value_format_name: percent_2
    description: "Purchase-user rate relative to the watch audience."
  }

  measure: bid_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${bid_users}) ;;
    value_format_name: percent_2
    description: "Purchase-user rate relative to the bid audience."
  }

  measure: add_to_cart_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${add_to_cart_users}) ;;
    value_format_name: percent_2
    description: "Purchase-user rate relative to the add-to-cart audience."
  }

  measure: high_intent_to_purchase_rate {
    type: number
    sql: SAFE_DIVIDE(${purchase_users}, ${high_intent_users}) ;;
    value_format_name: percent_2
    description: "Purchase-user rate relative to the broader high-intent audience."
  }
}

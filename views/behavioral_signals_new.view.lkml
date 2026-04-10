view: behavioral_signals_new {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.behavioral_signals_new` ;;

  dimension: ab_experiment_id {
    type: string
    sql: ${TABLE}.ab_experiment_id ;;
  }
  dimension: ab_variant {
    type: string
    sql: ${TABLE}.ab_variant ;;
  }
  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }
  dimension: cart_value_usd {
    type: number
    sql: ${TABLE}.cart_value_usd ;;
  }
  dimension: churn_risk_score {
    type: number
    sql: ${TABLE}.churn_risk_score ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension_group: event_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_timestamp ;;
  }
  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }
  dimension: is_authenticated {
    type: yesno
    sql: ${TABLE}.is_authenticated ;;
  }
  dimension: item_category {
    type: string
    sql: ${TABLE}.item_category ;;
  }
  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
  }
  dimension: item_price_usd {
    type: number
    sql: ${TABLE}.item_price_usd ;;
  }
  dimension: items_in_cart {
    type: number
    sql: ${TABLE}.items_in_cart ;;
  }
  dimension: notification_triggered {
    type: yesno
    sql: ${TABLE}.notification_triggered ;;
  }
  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }
  dimension: page_url_type {
    type: string
    sql: ${TABLE}.page_url_type ;;
  }
  dimension: prior_purchases_30d {
    type: number
    sql: ${TABLE}.prior_purchases_30d ;;
  }
  dimension: prior_sessions_7d {
    type: number
    sql: ${TABLE}.prior_sessions_7d ;;
  }
  dimension: propensity_to_buy_score {
    type: number
    sql: ${TABLE}.propensity_to_buy_score ;;
  }
  dimension: recommendation_flag {
    type: yesno
    sql: ${TABLE}.recommendation_flag ;;
  }
  dimension: referrer_type {
    type: string
    sql: ${TABLE}.referrer_type ;;
  }
  dimension: scroll_depth_pct {
    type: number
    sql: ${TABLE}.scroll_depth_pct ;;
  }
  dimension: search_keyword_category {
    type: string
    sql: ${TABLE}.search_keyword_category ;;
  }
  dimension: search_query_flag {
    type: yesno
    sql: ${TABLE}.search_query_flag ;;
  }
  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }
  dimension: signal_id {
    type: string
    sql: ${TABLE}.signal_id ;;
  }
  dimension: time_on_page_sec {
    type: number
    sql: ${TABLE}.time_on_page_sec ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension: wishlist_size {
    type: number
    sql: ${TABLE}.wishlist_size ;;
  }
  measure: count {
    type: count
  }
}

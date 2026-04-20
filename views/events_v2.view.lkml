view: events_v2 {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.events_v2` ;;

  ########################
  # Primary Key
  ########################

  dimension: event_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.event_id ;;
  }


  ########################
  # User & Session
  ########################

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  ########################
  # Event Date
  ########################

  dimension_group: event_date {
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.event_date ;;
  }

  ########################
  # Event Details
  ########################

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: search_keyword {
    type: string
    sql: ${TABLE}.search_keyword ;;
  }

  ########################
  # Platform & Device
  ########################

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  ########################
  # Intent & Signals
  ########################

  dimension: is_high_intent {
    type: yesno
    sql: ${event_type} IN ('add_to_cart', 'wishlist_add', 'checkout') ;;
  }

  dimension: is_search {
    type: yesno
    sql: ${event_type} = 'search' ;;
  }

  dimension: is_heavy_browse {
    type: yesno
    sql: ${TABLE}.is_2b_heavy_browse ;;
  }

  ########################
  # Cart Value
  ########################

  dimension: cart_value_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.cart_value_usd ;;
  }

  ########################
  # Measures
  ########################

  measure: event_count {
    type: count
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: high_intent_events {
    type: count
    filters: [is_high_intent: "yes"]
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_intent: "yes"]
  }

  measure: high_intent_event_rate {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN ${event_count} = 0 THEN NULL
        ELSE ${high_intent_events} / ${event_count}
      END ;;
  }

  measure: avg_cart_value_usd {
    type: average
    value_format_name: usd
    sql: ${cart_value_usd} ;;
  }

  measure: heavy_browse_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_heavy_browse: "yes"]
  }

  dimension: days_to_conversion {
    type: number
    sql: DATE_DIFF(${purchase_transaction_v2.transaction_date_date},
      ${event_date_date}, DAY) ;;
  }


}

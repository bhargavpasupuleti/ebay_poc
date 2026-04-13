view: user_profile_new {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_profile_new` ;;

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.account_status ;;
  }
  dimension: acquisition_source {
    type: string
    sql: ${TABLE}.acquisition_source ;;
  }
  dimension: age_band {
    type: string
    sql: ${TABLE}.age_band ;;
  }
  dimension: avg_order_value {
    type: number
    sql: ${TABLE}.avg_order_value ;;
  }
  dimension: browser_primary {
    type: string
    sql: ${TABLE}.browser_primary ;;
  }
  dimension: buyer_feedback_score {
    type: number
    sql: ${TABLE}.buyer_feedback_score ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: days_since_last_login {
    type: number
    sql: ${TABLE}.days_since_last_login ;;
  }
  dimension: days_since_last_purchase {
    type: number
    sql: ${TABLE}.days_since_last_purchase ;;
  }
  dimension: device_primary {
    type: string
    sql: ${TABLE}.device_primary ;;
  }
  dimension: email_hash {
    type: string
    sql: ${TABLE}.email_hash ;;
  }
  dimension: email_opt_in {
    type: yesno
    sql: ${TABLE}.email_opt_in ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }
  dimension: lifetime_value_usd {
    type: number
    sql: ${TABLE}.lifetime_value_usd ;;
  }
  dimension: loyalty_points {
    type: number
    sql: ${TABLE}.loyalty_points ;;
  }
  dimension: loyalty_tier {
    type: string
    sql: ${TABLE}.loyalty_tier ;;
  }
  dimension: os_primary {
    type: string
    sql: ${TABLE}.os_primary ;;
  }
  dimension: preferred_category {
    type: string
    sql: ${TABLE}.preferred_category ;;
  }
  dimension: preferred_channel {
    type: string
    sql: ${TABLE}.preferred_channel ;;
  }
  dimension: push_opt_in {
    type: yesno
    sql: ${TABLE}.push_opt_in ;;
  }
  dimension_group: registration {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.registration_date ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }
  dimension: seller_rating {
    type: number
    sql: ${TABLE}.seller_rating ;;
  }
  dimension: sms_opt_in {
    type: yesno
    sql: ${TABLE}.sms_opt_in ;;
  }
  dimension: state_region {
    type: string
    sql: ${TABLE}.state_region ;;
  }
  dimension: total_listings {
    type: number
    sql: ${TABLE}.total_listings ;;
  }
  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  measure: count {
    type: count
  }
}

view: user_profile_v2 {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_profile_v2`  ;;

  ########################
  # PRIMARY KEY
  ########################

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  ########################
  # CORE USER ATTRIBUTES
  ########################

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: lifecycle_stage {
    type: string
    sql: ${TABLE}.lifecycle_stage ;;
  }

  dimension: preferred_channel {
    type: string
    sql: ${TABLE}.preferred_channel ;;
  }

  dimension: preferred_category {
    type: string
    sql: ${TABLE}.preferred_category ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: platform_primary {
    type: string
    sql: ${TABLE}.platform_primary ;;
  }

  dimension: is_seller {
    type: yesno
    sql: ${TABLE}.is_seller ;;
  }

  ########################
  # OPT-IN FLAGS
  ########################

  dimension: email_opt_in {
    type: yesno
    sql: ${TABLE}.email_opt_in ;;
  }

  dimension: push_opt_in {
    type: yesno
    sql: ${TABLE}.push_opt_in ;;
  }

  dimension: sms_opt_in {
    type: yesno
    sql: ${TABLE}.sms_opt_in ;;
  }

  ########################
  # DATES
  ########################

  dimension_group: registration_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.registration_date ;;
  }

  dimension_group: last_purchase_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_purchase_date ;;
  }

  ########################
  # NUMERIC USER METRICS
  ########################

  dimension: ltv_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.ltv_usd ;;
  }

  dimension: total_orders_90d {
    type: number
    sql: ${TABLE}.total_orders_90d ;;
  }

  dimension: predicted_churn_propensity {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.predicted_churn_propensity ;;
  }

  dimension: predicted_clv_next_90d {
    type: number
    value_format_name: usd
    sql: ${TABLE}.predicted_clv_next_90d ;;
  }

  dimension: predicted_return_rate {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.predicted_return_rate ;;
  }

  dimension: rfm_score {
    type: number
    sql: ${TABLE}.rfm_score ;;
  }

  dimension: bbowac_activity_90d {
    type: number
    sql: ${TABLE}.bbowac_activity_90d ;;
  }

  dimension: heavy_browse_2b_90d {
    type: number
    sql: ${TABLE}.heavy_browse_2b_90d ;;
  }

  ############################
  # DERIVED DIMENSIONS (KEY)
  ############################

  dimension: ltv_bucket {
    type: string
    sql:
      CASE
        WHEN ${ltv_usd} < 50 THEN 'low'
        WHEN ${ltv_usd} < 200 THEN 'mid'
        ELSE 'high'
      END ;;
  }

  dimension: recency_bucket {
    type: string
    sql:
      CASE
        WHEN DATEDIFF(day, ${last_purchase_date_date}, CURRENT_DATE) < 7 THEN 'recent'
        WHEN DATEDIFF(day, ${last_purchase_date_date}, CURRENT_DATE) < 30 THEN 'warm'
        ELSE 'cold'
      END ;;
  }

  dimension: is_active_user {
    type: yesno
    sql: ${total_orders_90d} > 0 ;;
  }

  dimension: is_high_value_user {
    type: yesno
    sql: ${ltv_usd} >= 200 ;;
  }

  dimension: is_high_intent_user {
    type: yesno
    sql:
      ${bbowac_activity_90d} > 0
      OR ${heavy_browse_2b_90d} > 0 ;;
  }

  ########################
  # MEASURES
  ########################

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: active_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_active_user: "yes"]
  }

  measure: buyers_90d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [total_orders_90d: ">0"]
  }

  measure: high_value_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_value_user: "yes"]
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_intent_user: "yes"]
  }

  measure: avg_ltv_usd {
    type: average
    value_format_name: usd
    sql: ${ltv_usd} ;;
  }

  measure: avg_predicted_clv_90d {
    type: average
    value_format_name: usd
    sql: ${predicted_clv_next_90d} ;;
  }

}

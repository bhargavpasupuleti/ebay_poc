
view: campaign_dim_v2 {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_dim_v2` ;;

  ########################
  # Primary Key
  ########################

  dimension: campaign_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  ########################
  # Core Campaign Details
  ########################

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: campaign_goal {
    type: string
    sql: ${TABLE}.campaign_goal ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  ########################
  # Targeting
  ########################

  dimension: target_segment {
    type: string
    sql: ${TABLE}.target_segment ;;
  }

  dimension: target_category {
    type: string
    sql: ${TABLE}.target_category ;;
  }

  ########################
  # Dates
  ########################

  dimension_group: launch_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.launch_date ;;
  }

  dimension_group: end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.end_date ;;
  }

  ########################
  # Budget & Experimentation
  ########################

  dimension: budget_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.budget_usd ;;
  }

  dimension: is_ab_test {
    type: yesno
    sql: ${TABLE}.is_ab_test ;;
  }

  dimension: ab_variant_count {
    type: number
    sql: ${TABLE}.ab_variant_count ;;
  }

  ########################
  # Messaging & Content
  ########################

  dimension: subject_line {
    type: string
    sql: ${TABLE}.subject_line ;;
  }

  dimension: email_body_content {
    type: string
    sql: ${TABLE}.email_body_content ;;
  }

  dimension: hero_message {
    type: string
    sql: ${TABLE}.hero_message ;;
  }

  ########################
  # Offers & Personalization
  ########################

  dimension: offer_type {
    type: string
    sql: ${TABLE}.offer_type ;;
  }

  dimension: offer_value_pct {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.offer_value_pct ;;
  }

  dimension: product_recommendations_included {
    type: yesno
    sql: ${TABLE}.product_recommendations_included ;;
  }

  dimension: personalization_level {
    type: string
    sql: ${TABLE}.personalization_level ;;
  }

  ########################
  # External References
  ########################

  dimension: monday_campaign_id {
    type: string
    sql: ${TABLE}.monday_campaign_id ;;
  }
  measure: count {
    type: count
    label: "Number of campaigns"
  }

  measure: total_budget_usd {
    type: sum
    sql: ${budget_usd} ;;
    value_format_name: usd
  }

}

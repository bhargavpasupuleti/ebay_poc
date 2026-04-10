view: campaign_dim_new {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_dim_new` ;;

  dimension: approval_status {
    type: string
    sql: ${TABLE}.approval_status ;;
  }
  dimension: automation_flag {
    type: yesno
    sql: ${TABLE}.automation_flag ;;
  }
  dimension: budget_usd {
    type: number
    sql: ${TABLE}.budget_usd ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
  }
  dimension: category_focus {
    type: string
    sql: ${TABLE}.category_focus ;;
  }
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: created_by {
    type: string
    sql: ${TABLE}.created_by ;;
  }
  dimension: creative_theme {
    type: string
    sql: ${TABLE}.creative_theme ;;
  }
  dimension_group: end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.end_date ;;
  }
  dimension: goal {
    type: string
    sql: ${TABLE}.goal ;;
  }
  dimension: is_ab_test {
    type: yesno
    sql: ${TABLE}.is_ab_test ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_modified_date ;;
  }
  dimension: owner_team {
    type: string
    sql: ${TABLE}.owner_team ;;
  }
  dimension: priority_tier {
    type: string
    sql: ${TABLE}.priority_tier ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: segment_target {
    type: string
    sql: ${TABLE}.segment_target ;;
  }
  dimension_group: start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_date ;;
  }
  dimension: variant_count {
    type: number
    sql: ${TABLE}.variant_count ;;
  }
  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
}

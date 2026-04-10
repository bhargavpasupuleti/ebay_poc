view: message_metadata {
  sql_table_name: `ebay_looker_poc.message_metadata` ;;

  dimension: bounce_type {
    type: string
    sql: ${TABLE}.bounce_type ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: click_status {
    type: string
    sql: ${TABLE}.click_status ;;
  }
  dimension_group: clicked_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.clicked_timestamp ;;
  }
  dimension: complaint_flag {
    type: yesno
    sql: ${TABLE}.complaint_flag ;;
  }
  dimension: conversion_status {
    type: string
    sql: ${TABLE}.conversion_status ;;
  }
  dimension: cta_text {
    type: string
    sql: ${TABLE}.cta_text ;;
  }
  dimension_group: delivered_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_timestamp ;;
  }
  dimension: delivery_status {
    type: string
    sql: ${TABLE}.delivery_status ;;
  }
  dimension: discount_pct {
    type: number
    sql: ${TABLE}.discount_pct ;;
  }
  dimension: fatigue_score {
    type: number
    sql: ${TABLE}.fatigue_score ;;
  }
  dimension: free_shipping_flag {
    type: yesno
    sql: ${TABLE}.free_shipping_flag ;;
  }
  dimension: has_countdown_timer {
    type: yesno
    sql: ${TABLE}.has_countdown_timer ;;
  }
  dimension: has_dynamic_content {
    type: yesno
    sql: ${TABLE}.has_dynamic_content ;;
  }
  dimension: has_emoji {
    type: yesno
    sql: ${TABLE}.has_emoji ;;
  }
  dimension: has_personalization {
    type: yesno
    sql: ${TABLE}.has_personalization ;;
  }
  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }
  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
  }
  dimension: message_type {
    type: string
    sql: ${TABLE}.message_type ;;
  }
  dimension: model_version {
    type: string
    sql: ${TABLE}.model_version ;;
  }
  dimension: offer_type {
    type: string
    sql: ${TABLE}.offer_type ;;
  }
  dimension: open_status {
    type: string
    sql: ${TABLE}.open_status ;;
  }
  dimension_group: opened_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.opened_timestamp ;;
  }
  dimension: predicted_click_prob {
    type: number
    sql: ${TABLE}.predicted_click_prob ;;
  }
  dimension: predicted_open_prob {
    type: number
    sql: ${TABLE}.predicted_open_prob ;;
  }
  dimension: send_day {
    type: string
    sql: ${TABLE}.send_day ;;
  }
  dimension: send_hour {
    type: number
    sql: ${TABLE}.send_hour ;;
  }
  dimension: send_rank {
    type: number
    sql: ${TABLE}.send_rank ;;
  }
  dimension_group: send_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.send_timestamp ;;
  }
  dimension: subject_line_length {
    type: number
    sql: ${TABLE}.subject_line_length ;;
  }
  dimension: suppression_reason {
    type: string
    sql: ${TABLE}.suppression_reason ;;
  }
  dimension: template_id {
    type: string
    sql: ${TABLE}.template_id ;;
  }
  dimension: unsubscribe_flag {
    type: yesno
    sql: ${TABLE}.unsubscribe_flag ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
  }
}

view: campaign_performance_new {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_performance_new` ;;

  dimension: ab_variant {
    type: string
    sql: ${TABLE}.ab_variant ;;
  }
  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: complaints {
    type: number
    sql: ${TABLE}.complaints ;;
  }
  dimension: conversion_rate {
    type: number
    sql: ${TABLE}.conversion_rate ;;
  }
  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }
  dimension: cost_usd {
    type: number
    sql: ${TABLE}.cost_usd ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: day_of_week {
    type: string
    sql: ${TABLE}.day_of_week ;;
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: frequency {
    type: number
    sql: ${TABLE}.frequency ;;
  }
  dimension: hour_of_day {
    type: number
    sql: ${TABLE}.hour_of_day ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: is_holdout {
    type: yesno
    sql: ${TABLE}.is_holdout ;;
  }
  dimension: messages_clicked {
    type: number
    sql: ${TABLE}.messages_clicked ;;
  }
  dimension: messages_delivered {
    type: number
    sql: ${TABLE}.messages_delivered ;;
  }
  dimension: messages_opened {
    type: number
    sql: ${TABLE}.messages_opened ;;
  }
  dimension: messages_sent {
    type: number
    sql: ${TABLE}.messages_sent ;;
  }
  dimension: open_rate {
    type: number
    sql: ${TABLE}.open_rate ;;
  }
  dimension: perf_id {
    type: string
    sql: ${TABLE}.perf_id ;;
  }
  dimension: reach {
    type: number
    sql: ${TABLE}.reach ;;
  }
  dimension: revenue_per_message {
    type: number
    sql: ${TABLE}.revenue_per_message ;;
  }
  dimension: revenue_usd {
    type: number
    sql: ${TABLE}.revenue_usd ;;
  }
  dimension: roas {
    type: number
    sql: ${TABLE}.roas ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }
  dimension: unsubscribes {
    type: number
    sql: ${TABLE}.unsubscribes ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
  }
}

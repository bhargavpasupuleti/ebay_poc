view: campaign_performance_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_performance_v2` ;;

  dimension: attributed_revenue_usd {
    type: number
    sql: ${TABLE}.attributed_revenue_usd ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
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
  dimension: roi {
    type: number
    sql: ${TABLE}.roi ;;
  }
  dimension: target_category {
    type: string
    sql: ${TABLE}.target_category ;;
  }
  dimension: target_segment {
    type: string
    sql: ${TABLE}.target_segment ;;
  }
  measure: count {
    type: count
  }
}

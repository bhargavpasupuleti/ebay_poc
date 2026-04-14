view: campaign_performance_v2 {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_performance_v2` ;;

  ########################
  # Dimensions
  ########################

  dimension: perf_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.perf_id ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: target_segment {
    type: string
    sql: ${TABLE}.target_segment ;;
  }

  dimension: target_category {
    type: string
    sql: ${TABLE}.target_category ;;
  }

  ########################
  # Measures – Volumes
  ########################

  measure: messages_sent {
    type: sum
    sql: ${TABLE}.messages_sent ;;
  }

  measure: messages_opened {
    type: sum
    sql: ${TABLE}.messages_opened ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
  }

  ########################
  # Measures – Financials
  ########################

  measure: attributed_revenue_usd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.attributed_revenue_usd ;;
  }

  measure: cost_usd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cost_usd ;;
  }

  measure: roi {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN ${cost_usd} = 0 THEN NULL
        ELSE (${attributed_revenue_usd} - ${cost_usd}) / ${cost_usd}
      END ;;
  }

  ########################
  # Measures – Rates (Calculated)
  ########################

  measure: open_rate {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN ${messages_sent} = 0 THEN NULL
        ELSE ${messages_opened} / ${messages_sent}
      END ;;
  }

  measure: ctr {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN ${messages_opened} = 0 THEN NULL
        ELSE ${clicks} / ${messages_opened}
      END ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN ${clicks} = 0 THEN NULL
        ELSE ${conversions} / ${clicks}
      END ;;
  }

}

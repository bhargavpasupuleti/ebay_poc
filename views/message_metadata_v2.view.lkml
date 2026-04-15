view: message_metadata_v2 {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.message_metadata_v2` ;;

  ########################
  # PRIMARY / KEYS
  ########################

  dimension: message_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.message_id ;;
  }

  dimension: zeta_send_id {
    type: string
    sql: ${TABLE}.zeta_send_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: ab_variant {
    type: string
    sql: ${TABLE}.ab_variant ;;
  }

  ########################
  # CHANNEL & TAGS
  ########################

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: send_tag {
    type: string
    sql: ${TABLE}.send_tag ;;
  }

  dimension: engagement_tag {
    type: string
    sql: ${TABLE}.engagement_tag ;;
  }

  ########################
  # EVENT FLAGS (FIXED)
  ########################
  # These should NOT be plain numbers exposed as dimensions

  dimension: is_opened {
    type: yesno
    sql: ${TABLE}.opened = 1 ;;
  }

  dimension: is_clicked {
    type: yesno
    sql: ${TABLE}.clicked = 1 ;;
  }

  dimension: is_converted {
    type: yesno
    sql: ${TABLE}.converted = 1 ;;
  }

  ########################
  # TIME
  ########################

  dimension_group: sent_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.sent_date ;;
  }

  ########################
  # FINANCIALS
  ########################

  dimension: attributed_revenue_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.attributed_revenue_usd ;;
  }

  ########################
  # MEASURES – VOLUME
  ########################

  measure: messages_sent {
    type: count
    description: "Total messages sent"
  }

  measure: messages_opened {
    type: count
    filters: [is_opened: "yes"]
  }

  measure: messages_clicked {
    type: count
    filters: [is_clicked: "yes"]
  }

  measure: messages_converted {
    type: count
    filters: [is_converted: "yes"]
  }

  ########################
  # MEASURES – USERS
  ########################

  measure: users_reached {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: converters {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_converted: "yes"]
  }

  ########################
  # MEASURES – REVENUE
  ########################

  measure: attributed_revenue {
    type: sum
    value_format_name: usd
    sql: ${attributed_revenue_usd} ;;
  }

  ########################
  # MEASURES – RATES (CRITICAL)
  ########################

  measure: open_rate {
    type: number
    value_format_name: percent_2
    description: "Opens / Messages Sent"
    sql:
      CASE
        WHEN ${messages_sent} = 0 THEN NULL
        ELSE ${messages_opened} / ${messages_sent}
      END ;;
  }

  measure: ctr {
    type: number
    value_format_name: percent_2
    description: "Clicks / Opens"
    sql:
      CASE
        WHEN ${messages_opened} = 0 THEN NULL
        ELSE ${messages_clicked} / ${messages_opened}
      END ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    description: "Conversions / Clicks"
    sql:
      CASE
        WHEN ${messages_clicked} = 0 THEN NULL
        ELSE ${messages_converted} / ${messages_clicked}
      END ;;
  }

  ########################
  # DERIVED INTENT SIGNALS
  ########################

  dimension: is_high_intent_message {
    type: yesno
    sql:
      ${TABLE}.clicked = 1
      OR ${TABLE}.converted = 1 ;;
  }

}

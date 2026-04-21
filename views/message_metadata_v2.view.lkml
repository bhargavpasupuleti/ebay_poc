view: message_metadata_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.message_metadata_v2` ;;

  ########################
  # PRIMARY / KEYS
  ########################

  dimension: message_id {
    primary_key: yes
    type: string
    description: "The unique identifier for an individual message sent to a user."
    synonyms: ["ID", "Message Key", "Trace ID", "UUID"]
    sql: ${TABLE}.message_id ;;
  }

  dimension: zeta_send_id {
    type: string
    description: "The specific identifier assigned by the Zeta platform for this deployment."
    synonyms: ["Zeta ID", "Send ID", "Deployment ID", "Zeta Key"]
    sql: ${TABLE}.zeta_send_id ;;
  }

  dimension: user_id {
    type: string
    description: "The unique identifier for the customer receiving the message."
    synonyms: ["Customer ID", "Member ID", "UID", "User Key"]
    sql: ${TABLE}.user_id ;;
  }

  dimension: campaign_id {
    type: string
    description: "Links this message to a specific marketing campaign."
    synonyms: ["Campaign Code", "Promo ID", "Marketing ID"]
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: ab_variant {
    type: string
    description: "The specific A/B test version or treatment group assigned to this message."
    synonyms: ["Test Cell", "Treatment", "Variant Name", "Split Group"]
    sql: ${TABLE}.ab_variant ;;
  }

  ########################
  # CHANNEL & TAGS
  ########################

  dimension: channel {
    type: string
    description: "The medium used to deliver the message (e.g., Email, SMS, Push)."
    synonyms: ["Platform", "Delivery Method", "Medium"]
    sql: ${TABLE}.channel ;;
  }

  dimension: send_tag {
    type: string
    description: "Internal categorization tag applied at the time of sending."
    synonyms: ["Deployment Tag", "Send Category", "Batch Label"]
    sql: ${TABLE}.send_tag ;;
  }

  dimension: engagement_tag {
    type: string
    description: "Tags used to classify the nature of the user's engagement with this message."
    synonyms: ["Behavior Tag", "Interest Tag", "Interaction Label"]
    sql: ${TABLE}.engagement_tag ;;
  }

  ########################
  # EVENT FLAGS
  ########################

  dimension: is_opened {
    type: yesno
    description: "Indicates whether the recipient opened or viewed the message."
    synonyms: ["Opened", "Read", "Viewed", "Is Read"]
    sql: ${TABLE}.opened = 1 ;;
  }

  dimension: is_clicked {
    type: yesno
    description: "Indicates whether the recipient clicked a link within the message."
    synonyms: ["Clicked", "Tapped", "Interacted", "Engagement Flag"]
    sql: ${TABLE}.clicked = 1 ;;
  }

  dimension: is_converted {
    type: yesno
    description: "Indicates whether this message directly led to a desired transaction or goal."
    synonyms: ["Converted", "Purchased", "Ordered", "Success Flag"]
    sql: ${TABLE}.converted = 1 ;;
  }

  ########################
  # TIME
  ########################

  dimension_group: sent_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: timestamp         # ← ADD THIS
    convert_tz: no
    description: "The timestamp representing when the message was dispatched."
    synonyms: ["Deployment Time", "Launch Date", "Message Timestamp"]
    sql: TIMESTAMP(${TABLE}.sent_date) ;;
  }

  ########################
  # FINANCIALS
  ########################

  dimension: attributed_revenue_usd {
    type: number
    value_format_name: usd
    description: "The monetary value attributed to this specific message interaction."
    synonyms: ["Revenue", "Sales Amount", "Transaction Value", "Credit"]
    sql: ${TABLE}.attributed_revenue_usd ;;
  }

  ########################
  # MEASURES – VOLUME
  ########################

  measure: messages_sent {
    type: count
    description: "The total number of messages successfully dispatched."
    synonyms: ["Volume", "Gross Sends", "Deployments", "Total Dispatched"]
  }

  measure: messages_opened {
    type: count
    filters: [is_opened: "yes"]
    description: "The total number of messages that were opened by recipients."
    synonyms: ["Total Opens", "Read Count", "View Volume"]
  }

  measure: messages_clicked {
    type: count
    filters: [is_clicked: "yes"]
    description: "The total number of messages that resulted in a click."
    synonyms: ["Total Clicks", "Engagement Count", "Interaction Volume"]
  }

  measure: messages_converted {
    type: count
    filters: [is_converted: "yes"]
    description: "The total number of messages that resulted in a conversion."
    synonyms: ["Total Conversions", "Order Count", "Successes"]
  }

  ########################
  # MEASURES – USERS
  ########################

  measure: users_reached {
    type: count_distinct
    sql: ${user_id} ;;
    description: "The unique count of individual customers who were sent a message."
    synonyms: ["Reach", "Unique Recipients", "Audience Size"]
  }

  measure: converters {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_converted: "yes"]
    description: "The unique count of customers who completed a conversion."
    synonyms: ["Unique Buyers", "Purchasers", "Success Customers"]
  }

  ########################
  # MEASURES – REVENUE
  ########################

  measure: attributed_revenue {
    type: sum
    value_format_name: usd
    description: "The sum of all revenue attributed to message interactions."
    synonyms: ["Total Sales", "Gross Revenue", "Attributed Income"]
    sql: ${attributed_revenue_usd} ;;
  }

  ########################
  # MEASURES – RATES
  ########################

  measure: open_rate {
    type: number
    value_format_name: percent_2
    description: "Calculated as: Total Opens divided by Total Messages Sent."
    synonyms: ["OR", "Read Rate", "Visibility Rate"]
    sql:
      CASE
        WHEN ${messages_sent} = 0 THEN NULL
        ELSE ${messages_opened} / ${messages_sent}
      END ;;
  }

  measure: ctr {
    type: number
    label: "CTR"
    value_format_name: percent_2
    description: "Calculated as: Total Clicks divided by Total Opens."
    synonyms: ["Click Rate", "Engagement Rate", "Interaction Rate"]
    sql:
      CASE
        WHEN ${messages_opened} = 0 THEN NULL
        ELSE ${messages_clicked} / ${messages_opened}
      END ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    description: "Calculated as: Total Conversions divided by Total Clicks."
    synonyms: ["CVR", "Success Rate", "Close Rate"]
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
    description: "Flagged 'Yes' if the user either clicked or converted from this message."
    synonyms: ["High Engagement", "Valuable Interaction", "Hot Lead"]
    sql:
      ${TABLE}.clicked = 1
      OR ${TABLE}.converted = 1 ;;
  }

}

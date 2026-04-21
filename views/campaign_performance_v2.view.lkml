view: campaign_performance_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_performance_v2` ;;

  ########################
  # Dimensions
  ########################

  dimension: perf_id {
    primary_key: yes
    type: string
    description: "Unique identifier for each performance record."
    synonyms: ["Performance ID", "Record Key", "Log ID"]
    sql: ${TABLE}.perf_id ;;
  }

  dimension: campaign_id {
    type: string
    description: "The foreign key linking to the Campaign Dimension table."
    synonyms: ["Campaign Code", "Campaign Link", "ID"]
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    description: "The specific date when the performance activity (sends, clicks, etc.) occurred."
    synonyms: ["Activity Date", "Event Date", "Timestamp"]
    sql: timestamp(${TABLE}.date) ;;
  }

  dimension: channel {
    type: string
    description: "The marketing channel used for this specific performance snapshot (e.g., Email, SMS)."
    synonyms: ["Platform", "Medium", "Method"]
    sql: ${TABLE}.channel ;;
  }

  dimension: target_segment {
    type: string
    description: "The audience segment that generated this performance data."
    synonyms: ["Customer Group", "Audience", "Cohort"]
    sql: ${TABLE}.target_segment ;;
  }

  dimension: target_category {
    type: string
    description: "The product category being promoted in this performance record."
    synonyms: ["Department", "Merchandise Group", "Product Category"]
    sql: ${TABLE}.target_category ;;
  }

  ########################
  # Measures – Volumes
  ########################

  measure: messages_sent {
    type: sum
    description: "Total number of communications successfully dispatched."
    synonyms: ["Sends", "Volume", "Deployments", "Impressions"]
    sql: ${TABLE}.messages_sent ;;
  }

  measure: messages_opened {
    type: sum
    description: "Total number of messages viewed or opened by recipients."
    synonyms: ["Opens", "Views", "Read Count"]
    sql: ${TABLE}.messages_opened ;;
  }

  measure: clicks {
    type: sum
    description: "Total number of times links within the campaign were clicked."
    synonyms: ["Taps", "Interactions", "Traffic"]
    sql: ${TABLE}.clicks ;;
  }

  measure: conversions {
    type: sum
    description: "Total number of successful desired actions (e.g., purchases, sign-ups)."
    synonyms: ["Orders", "Sales", "Successes", "Transactions"]
    sql: ${TABLE}.conversions ;;
  }

  ########################
  # Measures – Financials
  ########################

  measure: attributed_revenue_usd {
    type: sum
    value_format_name: usd
    description: "Total revenue attributed to the campaign in US Dollars."
    synonyms: ["Sales", "Income", "Revenue", "Money In"]
    sql: ${TABLE}.attributed_revenue_usd ;;
  }

  measure: cost_usd {
    type: sum
    value_format_name: usd
    description: "Total cost or spend incurred for this campaign snapshot."
    synonyms: ["Spend", "Expenses", "Ad Cost", "Investment"]
    sql: ${TABLE}.cost_usd ;;
  }

  measure: roi {
    type: number
    label: "ROI"
    value_format_name: percent_2
    description: "Return on Investment: (Revenue - Cost) / Cost."
    synonyms: ["Profitability", "Return", "Yield"]
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
    description: "The percentage of sent messages that were opened."
    synonyms: ["OR", "Read Rate", "Engagement Rate"]
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
    description: "Click-Through Rate: The percentage of opened messages that resulted in a click."
    synonyms: ["Click Rate", "Interaction Rate"]
    sql:
      CASE
        WHEN ${messages_opened} = 0 THEN NULL
        ELSE ${clicks} / ${messages_opened}
      END ;;
  }

  measure: conversion_rate {
    type: number
    value_format_name: percent_2
    description: "The percentage of clicks that resulted in a conversion."
    synonyms: ["CVR", "CR", "Close Rate"]
    sql:
      CASE
        WHEN ${clicks} = 0 THEN NULL
        ELSE ${conversions} / ${clicks}
      END ;;
  }

}

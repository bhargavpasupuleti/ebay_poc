
view: campaign_dim_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_dim_v3` ;;

  ########################
  # Primary Key
  ########################

  dimension: campaign_id {
    primary_key: yes
    type: string
    description: "The unique internal identifier for each marketing campaign."
    synonyms: ["ID", "Campaign Code", "Campaign Key"]
    sql: ${TABLE}.campaign_id ;;
  }

  ########################
  # Core Campaign Details
  ########################

  dimension: campaign_name {
    type: string
    description: "The formal name given to the marketing campaign."
    synonyms: ["Title", "Campaign Label", "Promo Name"]
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {
    type: string
    description: "The format of the campaign, such as Holiday, Seasonal, or Triggered."
    synonyms: ["Category", "Campaign Class", "Marketing Type"]
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: campaign_goal {
    type: string
    description: "The primary objective of the campaign (e.g., Conversion, Retention, Awareness)."
    synonyms: ["Objective", "Purpose", "Target Outcome"]
    sql: ${TABLE}.campaign_goal ;;
  }

  dimension: channel {
    type: string
    description: "The medium through which the campaign is delivered (e.g., Email, SMS, Social)."
    synonyms: ["Platform", "Medium", "Distribution Channel"]
    sql: ${TABLE}.channel ;;
  }

  ########################
  # Targeting
  ########################

  dimension: target_segment {
    type: string
    description: "The specific audience group or persona being targeted."
    synonyms: ["Audience", "Customer Group", "Cohort"]
    sql: ${TABLE}.target_segment ;;
  }

  dimension: target_category {
    type: string
    description: "The product category the campaign is focused on (e.g., Furniture, Decor)."
    synonyms: ["Product Class", "Merchandise Category", "Dept"]
    sql: ${TABLE}.target_category ;;
  }

  ########################
  # Dates
  ########################

  dimension_group: launch_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: timestamp
    description: "The date and time when the campaign officially starte."
    synonyms: ["Start Date", "Go Live", "Deployment Date"]
    sql: TIMESTAMP(${TABLE}.launch_date) ;;
  }

  dimension_group: end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: timestamp
    description: "The date and time when the campaign was scheduled to conclude."
    synonyms: ["Completion Date", "Expiration", "Finish Date"]
    sql: TIMESTAMP(${TABLE}.end_date) ;;
  }

  ########################
  # Budget & Experimentation
  ########################

  dimension: budget_usd {
    type: number
    value_format_name: usd
    description: "The total financial amount allocated for this campaign in US Dollars."
    synonyms: ["Cost", "Spend", "Investment", "Budget"]
    sql: ${TABLE}.budget_usd ;;
  }

  dimension: is_ab_test {
    type: yesno
    description: "Indicates if the campaign was part of an A/B or Multivariate experiment."
    synonyms: ["Experiment", "Split Test", "Testing Flag"]
    sql: ${TABLE}.is_ab_test ;;
  }

  dimension: ab_variant_count {
    type: number
    description: "The number of different versions or treatments tested within this campaign."
    synonyms: ["Test Cells", "Number of Variants", "Split Count"]
    sql: ${TABLE}.ab_variant_count ;;
  }

  ########################
  # Messaging & Content
  ########################

  dimension: subject_line {
    type: string
    description: "The email subject line or headline used for the campaign."
    synonyms: ["Email Header", "Subject", "Title Line"]
    sql: ${TABLE}.subject_line ;;
  }

  dimension: email_body_content {
    type: string
    description: "The main text or copy included in the body of the campaign communication."
    synonyms: ["Copy", "Message Body", "Content Text"]
    sql: ${TABLE}.email_body_content ;;
  }

  dimension: hero_message {
    type: string
    description: "The primary call-to-action or hook featured prominently in the creative."
    synonyms: ["Headline", "CTA", "Main Hook", "Hero Copy"]
    sql: ${TABLE}.hero_message ;;
  }

  ########################
  # Offers & Personalization
  ########################

  dimension: offer_type {
    type: string
    description: "The kind of incentive provided (e.g., Percentage Off, Dollar Off, BOGO)."
    synonyms: ["Promotion Type", "Discount Type", "Incentive"]
    sql: ${TABLE}.offer_type ;;
  }

  dimension: offer_value_pct {
    type: number
    value_format_name: percent_2
    description: "The percentage value of the discount offered."
    synonyms: ["Discount Percent", "Savings Rate", "Pct Off"]
    sql: ${TABLE}.offer_value_pct ;;
  }

  dimension: product_recommendations_included {
    type: yesno
    description: "Indicates if dynamic product suggestions were included in the message."
    synonyms: ["Product Recs", "Dynamic Content", "Personalized Products"]
    sql: ${TABLE}.product_recommendations_included ;;
  }

  dimension: personalization_level {
    type: string
    description: "Describes the depth of personalization (e.g., None, Segment-based, 1-to-1)."
    synonyms: ["Tailoring", "Customization Level"]
    sql: ${TABLE}.personalization_level ;;
  }

  ########################
  # External References
  ########################

  dimension: monday_campaign_id {
    type: string
    description: "The reference ID used to link this campaign to Monday.com project management."
    synonyms: ["Monday ID", "Project ID", "External Ref"]
    sql: ${TABLE}.monday_campaign_id ;;
  }

  ########################
  # Measures
  ########################

  measure: count {
    type: count
    label: "Number of Campaigns"
    description: "Total count of unique campaign records."
    synonyms: ["Total Campaigns", "Volume of Campaigns"]
  }

  measure: total_budget_usd {
    type: sum
    sql: ${budget_usd} ;;
    value_format_name: usd
    description: "The sum of all budget allocations across the selected campaigns."
    synonyms: ["Total Spend", "Aggregate Budget", "Gross Investment"]
  }

}

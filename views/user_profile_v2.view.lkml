view: user_profile_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_profile_v2`  ;;

  ########################
  # PRIMARY KEY
  ########################

  dimension: user_id {
    primary_key: yes
    type: string
    description: "The unique identifier for each customer."
    synonyms: ["Customer ID", "Member ID", "UID", "Subscriber Key"]
    sql: ${TABLE}.user_id ;;
  }

  ########################
  # CORE USER ATTRIBUTES
  ########################

  dimension: segment {
    type: string
    description: "The marketing segment assigned to the user (e.g., VIP, Occasional, New)."
    synonyms: ["Tier", "Customer Group", "Persona", "Loyalty Group"]
    sql: ${TABLE}.segment ;;
  }

  dimension: lifecycle_stage {
    type: string
    description: "The current stage in the customer journey (e.g., Acquisition, Retention, Churn-risk)."
    synonyms: ["Status", "Journey Stage", "Relationship Phase"]
    sql: ${TABLE}.lifecycle_stage ;;
  }

  dimension: preferred_channel {
    type: string
    description: "The communication channel the user engages with most (Email, SMS, or Push)."
    synonyms: ["Best Channel", "Contact Preference", "Favorite Platform"]
    sql: ${TABLE}.preferred_channel ;;
  }

  dimension: preferred_category {
    type: string
    description: "The product category the user browses or purchases most frequently."
    synonyms: ["Favorite Dept", "Affinity Category", "Main Interest"]
    sql: ${TABLE}.preferred_category ;;
  }

  dimension: state {
    type: string
    description: "The US state associated with the user's primary address."
    synonyms: ["Region", "Location", "Province"]
    sql: ${TABLE}.state ;;
  }

  dimension: platform_primary {
    type: string
    description: "The primary device platform used by the customer (e.g., Web, iOS, Android)."
    synonyms: ["Main Device", "Primary OS", "App vs Web"]
    sql: ${TABLE}.platform_primary ;;
  }

  dimension: is_seller {
    type: yesno
    description: "Indicates if the user has a seller account in addition to being a buyer."
    synonyms: ["Vendor Flag", "Merchant", "Is Merchant"]
    sql: ${TABLE}.is_seller ;;
  }

  ########################
  # OPT-IN FLAGS
  ########################

  dimension: email_opt_in {
    type: yesno
    description: "Whether the user has consented to receive marketing emails."
    synonyms: ["Email Subscribed", "Mailable"]
    sql: ${TABLE}.email_opt_in ;;
  }

  dimension: push_opt_in {
    type: yesno
    description: "Whether the user has enabled mobile push notifications."
    synonyms: ["App Alerts Enabled", "Push Subscribed"]
    sql: ${TABLE}.push_opt_in ;;
  }

  dimension: sms_opt_in {
    type: yesno
    description: "Whether the user has consented to receive marketing text messages."
    synonyms: ["Text Opt-in", "Mobile Subscribed"]
    sql: ${TABLE}.sms_opt_in ;;
  }

  ########################
  # DATES
  ########################

  dimension_group: registration_date {
    type: time
    datatype: timestamp
    timeframes: [date, week, month, year]
    description: "The date the user first created their account."
    synonyms: ["Sign-up Date", "Join Date", "Account Creation"]
    sql: TIMESTAMP(${TABLE}.registration_date) ;;
  }

  dimension_group: last_purchase_date {
    type: time
    datatype: timestamp
    timeframes: [date, week, month, year]
    description: "The date of the user's most recent successful transaction."
    synonyms: ["Recent Order Date", "Last Sale"]
    sql: TIMESTAMP(${TABLE}.last_purchase_date) ;;
  }

  ########################
  # NUMERIC USER METRICS
  ########################

  dimension: ltv_usd {
    type: number
    value_format_name: usd
    description: "Lifetime Value: The total historical spend of the customer in USD."
    synonyms: ["Lifetime Spend", "Total Sales", "LTV", "Historical Value"]
    sql: ${TABLE}.ltv_usd ;;
  }

  dimension: total_orders_90d {
    type: number
    description: "The number of orders placed by the user in the last 90 days."
    synonyms: ["Recent Order Count", "90 Day Frequency"]
    sql: ${TABLE}.total_orders_90d ;;
  }

  dimension: predicted_churn_propensity {
    type: number
    value_format_name: percent_2
    description: "The ML-predicted probability (0-1) that the user will stop engaging."
    synonyms: ["Churn Risk", "Attrition Score", "Likelihood to Leave"]
    sql: ${TABLE}.predicted_churn_propensity ;;
  }

  dimension: predicted_clv_next_90d {
    type: number
    value_format_name: usd
    description: "The ML-predicted spend for this user over the next 3 months."
    synonyms: ["Future Value", "pCLV", "Predicted Revenue"]
    sql: ${TABLE}.predicted_clv_next_90d ;;
  }

  dimension: predicted_return_rate {
    type: number
    value_format_name: percent_2
    description: "The ML-predicted probability that the user will return their next purchase."
    synonyms: ["Return Propensity", "Refund Risk"]
    sql: ${TABLE}.predicted_return_rate ;;
  }

  dimension: rfm_score {
    type: number
    description: "The composite score based on Recency, Frequency, and Monetary metrics."
    synonyms: ["Engagement Score", "RFM Index"]
    sql: ${TABLE}.rfm_score ;;
  }

  dimension: bbowac_activity_90d {
    type: number
    description: "Internal activity score based on browsing and cart actions (90 days)."
    synonyms: ["Interaction Score", "Activity Level"]
    sql: ${TABLE}.bbowac_activity_90d ;;
  }

  dimension: heavy_browse_2b_90d {
    type: number
    description: "Count of deep browsing sessions (2+ pages) in the last 90 days."
    synonyms: ["Deep Browsing Count", "Research Frequency"]
    sql: ${TABLE}.heavy_browse_2b_90d ;;
  }

  ############################
  # DERIVED DIMENSIONS
  ############################

  dimension: ltv_bucket {
    type: string
    description: "Categorization of users into Low, Mid, or High LTV tiers."
    synonyms: ["Spend Tier", "Value Class"]
    sql:
      CASE
        WHEN ${ltv_usd} < 50 THEN 'low'
        WHEN ${ltv_usd} < 200 THEN 'mid'
        ELSE 'high'
      END ;;
  }

  dimension: recency_bucket {
    type: string
    description: "Classification of users based on how recently they purchased (Recent, Warm, Cold)."
    synonyms: ["Activity Status", "Recency Class"]
    sql:
      CASE
        WHEN DATE_DIFF(CURRENT_DATE, ${last_purchase_date_date}, DAY) < 7 THEN 'recent'
        WHEN DATE_DIFF(CURRENT_DATE, ${last_purchase_date_date}, DAY) < 30 THEN 'warm'
        ELSE 'cold'
      END ;;
  }

  dimension: is_active_user {
    type: yesno
    description: "True if the user has placed at least one order in the last 90 days."
    synonyms: ["Currently Active", "Recent Buyer"]
    sql: ${total_orders_90d} > 0 ;;
  }

  dimension: is_high_value_user {
    type: yesno
    description: "True if the user's Lifetime Value is $200 or more."
    synonyms: ["VIP", "Top Spender", "Whale"]
    sql: ${ltv_usd} >= 200 ;;
  }

  dimension: is_high_intent_user {
    type: yesno
    description: "True if the user shows heavy browsing or cart activity signals."
    synonyms: ["Hot Lead", "Likely Buyer", "Active Shopper"]
    sql:
      ${bbowac_activity_90d} > 0
      OR ${heavy_browse_2b_90d} > 0 ;;
  }

  ########################
  # MEASURES
  ########################

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "The total count of unique customers."
    synonyms: ["Customer Count", "Total Members", "Headcount"]
  }

  measure: active_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_active_user: "yes"]
    description: "Number of unique users active in the last 90 days."
    synonyms: ["Active Reach", "90d Actives"]
  }

  measure: buyers_90d {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [total_orders_90d: ">0"]
    description: "Count of unique users who made a purchase in the last 90 days."
    synonyms: ["Recent Purchasers", "Converting Users"]
  }

  measure: high_value_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_value_user: "yes"]
    description: "Count of unique users in the high-value/VIP tier."
    synonyms: ["VIP Count", "Top Spender Count"]
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_intent_user: "yes"]
    description: "Count of unique users exhibiting high-intent browsing behavior."
    synonyms: ["Prospective Buyers", "Lead Count"]
  }

  measure: avg_ltv_usd {
    type: average
    value_format_name: usd
    description: "The average Lifetime Value across all selected users."
    synonyms: ["Average Lifetime Spend", "Mean LTV"]
    sql: ${ltv_usd} ;;
  }

  measure: avg_predicted_clv_90d {
    type: average
    value_format_name: usd
    description: "The average predicted spend for the next 90 days per user."
    synonyms: ["Forecasted Revenue Per Head", "Average pCLV"]
    sql: ${predicted_clv_next_90d} ;;
  }

  dimension: churn_risk_band {
    type: string
    description: "Categorised churn risk from predicted_churn_propensity score."
    sql:
    CASE
      WHEN ${predicted_churn_propensity} >= 0.7 THEN 'High Risk'
      WHEN ${predicted_churn_propensity} >= 0.4 THEN 'Medium Risk'
      ELSE 'Low Risk'
    END ;;
  }

  measure: high_churn_risk_users {
    type:        count_distinct
    sql:         ${user_id} ;;
    description: "Users with predicted churn propensity >= 70%"
    filters: [churn_risk_band: "High Risk"]
  }

  measure: avg_churn_propensity {
    type:              average
    value_format_name: percent_2
    sql:               ${predicted_churn_propensity} ;;
  }

# Opt-in Reachability
  measure: email_reachable_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [email_opt_in: "yes"]
  }

  measure: push_reachable_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [push_opt_in: "yes"]
  }

  measure: sms_reachable_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [sms_opt_in: "yes"]
  }

# Lifecycle Distribution
  measure: new_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [lifecycle_stage: "new"]
  }

  measure: lapsed_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [lifecycle_stage: "lapsed"]
  }

  measure: loyal_users {
    type:    count_distinct
    sql:     ${user_id} ;;
    filters: [lifecycle_stage: "loyal"]
  }

}

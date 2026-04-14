view: user_profile_desc {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_profile_new` ;;

  dimension: user_id {
    label: "User ID"
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    description: "Unique identifier for the user (may be hashed or internal id)."
    synonyms: ["uid","customer_id","buyer_id"]
  }

  dimension: account_status {
    label: "Account Status"
    type: string
    sql: ${TABLE}.account_status ;;
    description: "Current status of the user's account (e.g., active, suspended)."
    synonyms: ["status","user_status","account_state"]
  }

  dimension: acquisition_source {
    label: "Acquisition Source"
    type: string
    sql: ${TABLE}.acquisition_source ;;
    description: "Channel or campaign through which the user was acquired."
    synonyms: ["signup_source","traffic_source","marketing_source"]
  }

  dimension: age_band {
    label: "Age Band"
    type: string
    sql: ${TABLE}.age_band ;;
    description: "Age range bucket for the user (e.g., 18-24, 25-34)."
    synonyms: ["age_group","age_range","demographic_age"]
  }

  dimension: avg_order_value {
    label: "Average Order Value"
    type: number
    sql: ${TABLE}.avg_order_value ;;
    value_format_name: "usd"
    description: "Average monetary value of the user's orders."
    synonyms: ["aov","average_cart_value","avg_order_amt"]
  }

  dimension: browser_primary {
    label: "Primary Browser"
    type: string
    sql: ${TABLE}.browser_primary ;;
    description: "User's most frequently used web browser."
    synonyms: ["browser","browser_name","primary_browser_name"]
  }

  dimension: buyer_feedback_score {
    label: "Buyer Feedback Score"
    type: number
    sql: ${TABLE}.buyer_feedback_score ;;
    description: "Aggregated feedback or rating score from buyer interactions."
    synonyms: ["feedback_score","rating_score","buyer_score"]
  }

  dimension: city {
    label: "City"
    type: string
    sql: ${TABLE}.city ;;
    description: "City associated with the user's profile or last known location."
    synonyms: ["town","locality","user_city"]
  }

  dimension: country {
    label: "Country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    description: "Country associated with the user (ISO code or name)."
    synonyms: ["country_code","user_country","geo_country"]
  }

  dimension: days_since_last_login {
    label: "Days Since Last Login"
    type: number
    sql: ${TABLE}.days_since_last_login ;;
    description: "Number of days since the user's most recent login."
    synonyms: ["days_since_login","last_login_days","days_since_last_signin"]
  }

  dimension: days_since_last_purchase {
    label: "Days Since Last Purchase"
    type: number
    sql: ${TABLE}.days_since_last_purchase ;;
    description: "Number of days since the user's most recent purchase."
    synonyms: ["days_since_purchase","last_purchase_days","days_since_last_order"]
  }

  dimension: device_primary {
    label: "Primary Device"
    type: string
    sql: ${TABLE}.device_primary ;;
    description: "User's most frequently used device category (mobile/desktop/tablet)."
    synonyms: ["device","device_type","primary_device_type"]
  }

  dimension: email_hash {
    label: "Email Hash"
    type: string
    sql: ${TABLE}.email_hash ;;
    description: "Hashed representation of the user's email for privacy."
    synonyms: ["email_hashed","hashed_email","email_fingerprint"]
  }

  dimension: email_opt_in {
    label: "Email Opt In"
    type: yesno
    sql: ${TABLE}.email_opt_in ;;
    description: "Whether the user has opted in to receive marketing emails."
    synonyms: ["email_subscribed","subscribed_email","marketing_email_opt_in"]
  }

  dimension: gender {
    label: "Gender"
    type: string
    sql: ${TABLE}.gender ;;
    description: "Self-reported or inferred gender of the user."
    synonyms: ["sex","user_gender","demographic_gender"]
  }

  dimension: language {
    label: "Language"
    type: string
    sql: ${TABLE}.language ;;
    description: "Preferred language of the user."
    synonyms: ["locale","preferred_language","user_locale"]
  }

  dimension: lifetime_value_usd {
    label: "Lifetime Value (USD)"
    type: number
    sql: ${TABLE}.lifetime_value_usd ;;
    value_format_name: "usd"
    description: "Total historical revenue attributed to the user in USD."
    synonyms: ["ltv","customer_lifetime_value","lifetime_revenue"]
  }

  dimension: loyalty_points {
    label: "Loyalty Points"
    type: number
    sql: ${TABLE}.loyalty_points ;;
    description: "Current loyalty or reward points balance for the user."
    synonyms: ["points_balance","reward_points","loyalty_balance"]
  }

  dimension: loyalty_tier {
    label: "Loyalty Tier"
    type: string
    sql: ${TABLE}.loyalty_tier ;;
    description: "Membership tier within the loyalty program (e.g., gold, silver)."
    synonyms: ["tier","membership_tier","loyalty_level"]
  }

  dimension: os_primary {
    label: "Primary Operating System"
    type: string
    sql: ${TABLE}.os_primary ;;
    description: "Operating system most commonly used by the user (e.g., iOS, Android)."
    synonyms: ["os","platform","primary_os"]
  }

  dimension: preferred_category {
    label: "Preferred Category"
    type: string
    sql: ${TABLE}.preferred_category ;;
    description: "Product category the user most frequently engages with."
    synonyms: ["favorite_category","top_category","preferred_product_category"]
  }

  dimension: preferred_channel {
    label: "Preferred Channel"
    type: string
    sql: ${TABLE}.preferred_channel ;;
    description: "User's preferred communication or shopping channel (e.g., app, web)."
    synonyms: ["channel_preference","fav_channel","preferred_platform"]
  }

  dimension: push_opt_in {
    label: "Push Opt In"
    type: yesno
    sql: ${TABLE}.push_opt_in ;;
    description: "Whether the user has opted in to receive push notifications."
    synonyms: ["push_subscribed","push_notifications_opt_in","notifications_opt_in"]
  }

  dimension_group: registration {
    label: "Registration Date"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.registration_date ;;
    description: "Date when the user registered or created their account."
    synonyms: ["signup_date","created_at","registration_time"]
  }

  dimension: segment {
    label: "Segment"
    type: string
    sql: ${TABLE}.segment ;;
    description: "Customer segment or cohort assigned to the user."
    synonyms: ["cohort","customer_segment","user_segment"]
  }

  dimension: seller_rating {
    label: "Seller Rating"
    type: number
    sql: ${TABLE}.seller_rating ;;
    description: "Rating score for users who are sellers (if applicable)."
    synonyms: ["rating","seller_score","vendor_rating"]
  }

  dimension: sms_opt_in {
    label: "SMS Opt In"
    type: yesno
    sql: ${TABLE}.sms_opt_in ;;
    description: "Whether the user has opted in to receive SMS messages."
    synonyms: ["sms_subscribed","text_opt_in","sms_notifications_opt_in"]
  }

  dimension: state_region {
    label: "State or Region"
    type: string
    sql: ${TABLE}.state_region ;;
    description: "State, province, or region associated with the user."
    synonyms: ["state","province","region"]
  }

  dimension: total_listings {
    label: "Total Listings"
    type: number
    sql: ${TABLE}.total_listings ;;
    description: "Number of active listings the user has (for sellers)."
    synonyms: ["listings_count","active_listings","num_listings"]
  }

  dimension: total_orders {
    label: "Total Orders"
    type: number
    sql: ${TABLE}.total_orders ;;
    description: "Total number of orders placed by the user."
    synonyms: ["orders_count","order_history_count","num_orders"]
  }

  measure: count {
    label: "User Count"
    type: count
    description: "Number of user profile records returned."
    synonyms: ["row_count","profiles_count","users_count"]
  }
}

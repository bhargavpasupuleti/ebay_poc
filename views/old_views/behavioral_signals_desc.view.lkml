view: behavioral_signals_desc {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.behavioral_signals_new` ;;

  dimension: ab_experiment_id {
    label: "AB Experiment ID"
    type: string
    sql: ${TABLE}.ab_experiment_id ;;
    description: "Unique identifier for an A/B test or experiment."
    synonyms: ["experiment_id","test_id","ab_test_id"]
  }

  dimension: ab_variant {
    label: "AB Variant"
    type: string
    sql: ${TABLE}.ab_variant ;;
    description: "Variant or cohort within an A/B experiment (e.g., control, variant A)."
    synonyms: ["variant_name","cohort","test_group"]
  }

  dimension: browser {
    label: "Browser"
    type: string
    sql: ${TABLE}.browser ;;
    description: "Name of the web browser used by the user (e.g., Chrome, Safari)."
    synonyms: ["browser_name","user_agent_browser"]
  }

  dimension: cart_value_usd {
    label: "Cart Value (USD)"
    type: number
    sql: ${TABLE}.cart_value_usd ;;
    description: "Total value of items in the cart in US dollars."
    value_format_name: "usd"
    synonyms: ["cart_total","basket_value","cart_amount"]
  }

  dimension: churn_risk_score {
    label: "Churn Risk Score"
    type: number
    sql: ${TABLE}.churn_risk_score ;;
    description: "Modelled probability or score indicating likelihood of user churn (higher = greater risk)."
    synonyms: ["churn_score","attrition_risk"]
  }

  dimension: country {
    label: "Country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    description: "Country associated with the event or user (ISO code or name)."
    synonyms: ["country_code","user_country","geo_country"]
  }

  dimension: device {
    label: "Device"
    type: string
    sql: ${TABLE}.device ;;
    description: "Device category used (e.g., mobile, desktop, tablet)."
    synonyms: ["device_type","device_category"]
  }

  dimension_group: event_timestamp {
    label: "Event Timestamp"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_timestamp ;;
    description: "Timestamp when the behavioral signal/event occurred."
    synonyms: ["event_time","timestamp","occurred_at"]
  }

  dimension: event_type {
    label: "Event Type"
    type: string
    sql: ${TABLE}.event_type ;;
    description: "Type of behavioral event (e.g., view, add_to_cart, purchase)."
    synonyms: ["action","event_name","activity_type"]
  }

  dimension: is_authenticated {
    label: "Is Authenticated"
    type: yesno
    sql: ${TABLE}.is_authenticated ;;
    description: "Whether the user was logged in at the time of the event."
    synonyms: ["logged_in","authenticated_flag","user_authenticated"]
  }

  dimension: item_category {
    label: "Item Category"
    type: string
    sql: ${TABLE}.item_category ;;
    description: "High-level category of the item (e.g., electronics, apparel)."
    synonyms: ["category","product_category","item_type"]
  }

  dimension: item_id {
    label: "Item ID"
    type: string
    sql: ${TABLE}.item_id ;;
    description: "Unique identifier for the item or SKU."
    synonyms: ["product_id","sku","listing_id"]
  }

  dimension: item_price_usd {
    label: "Item Price (USD)"
    type: number
    sql: ${TABLE}.item_price_usd ;;
    description: "Price of the individual item in US dollars."
    value_format_name: "usd"
    synonyms: ["price","unit_price","product_price"]
  }

  dimension: items_in_cart {
    label: "Items in Cart"
    type: number
    sql: ${TABLE}.items_in_cart ;;
    description: "Number of items currently in the user's cart."
    synonyms: ["cart_quantity","cart_count","basket_items"]
  }

  dimension: notification_triggered {
    label: "Notification Triggered"
    type: yesno
    sql: ${TABLE}.notification_triggered ;;
    description: "Whether a notification was sent or triggered for this event."
    synonyms: ["notified","push_sent","notification_flag"]
  }

  dimension: os {
    label: "Operating System"
    type: string
    sql: ${TABLE}.os ;;
    description: "Operating system of the user's device (e.g., iOS, Android, Windows)."
    synonyms: ["os_name","platform"]
  }

  dimension: page_url_type {
    label: "Page URL Type"
    type: string
    sql: ${TABLE}.page_url_type ;;
    description: "Classification of the page URL (e.g., product_page, search_results)."
    synonyms: ["page_type","url_type","page_category"]
  }

  dimension: prior_purchases_30d {
    label: "Prior Purchases 30d"
    type: number
    sql: ${TABLE}.prior_purchases_30d ;;
    description: "Count of purchases by the user in the prior 30 days."
    synonyms: ["purchases_30d","recent_purchases","last_30d_purchases"]
  }

  dimension: prior_sessions_7d {
    label: "Prior Sessions 7d"
    type: number
    sql: ${TABLE}.prior_sessions_7d ;;
    description: "Number of sessions the user had in the prior 7 days."
    synonyms: ["sessions_7d","recent_sessions","last_7d_sessions"]
  }

  dimension: propensity_to_buy_score {
    label: "Propensity to Buy Score"
    type: number
    sql: ${TABLE}.propensity_to_buy_score ;;
    description: "Modelled likelihood that the user will make a purchase (higher = more likely)."
    synonyms: ["buy_propensity","purchase_probability","purchase_score"]
  }

  dimension: recommendation_flag {
    label: "Recommendation Flag"
    type: yesno
    sql: ${TABLE}.recommendation_flag ;;
    description: "Indicates whether a recommendation was shown or applied."
    synonyms: ["recommended","rec_flag","recommendation_shown"]
  }

  dimension: referrer_type {
    label: "Referrer Type"
    type: string
    sql: ${TABLE}.referrer_type ;;
    description: "Source type that referred the user (e.g., organic_search, paid_search, direct)."
    synonyms: ["traffic_source","referrer","source_type"]
  }

  dimension: scroll_depth_pct {
    label: "Scroll Depth Percent"
    type: number
    sql: ${TABLE}.scroll_depth_pct ;;
    description: "Percentage of the page scrolled by the user (0-100)."
    synonyms: ["scroll_pct","depth_pct","page_scroll"]
  }

  dimension: search_keyword_category {
    label: "Search Keyword Category"
    type: string
    sql: ${TABLE}.search_keyword_category ;;
    description: "Categorized intent or topic of the user's search keywords."
    synonyms: ["keyword_category","search_intent","query_category"]
  }

  dimension: search_query_flag {
    label: "Search Query Flag"
    type: yesno
    sql: ${TABLE}.search_query_flag ;;
    description: "Whether the event included a search query."
    synonyms: ["searched","has_query","query_flag"]
  }

  dimension: session_id {
    label: "Session ID"
    type: string
    sql: ${TABLE}.session_id ;;
    description: "Identifier for the user session."
    synonyms: ["visit_id","session_key","session_uuid"]
  }

  dimension: signal_id {
    label: "Signal ID"
    type: string
    sql: ${TABLE}.signal_id ;;
    primary_key: yes
    description: "Unique identifier for this behavioral signal record."
    synonyms: ["event_id","signal_uuid","record_id"]
  }

  dimension: time_on_page_sec {
    label: "Time on Page (sec)"
    type: number
    sql: ${TABLE}.time_on_page_sec ;;
    description: "Time spent on the page in seconds."
    synonyms: ["dwell_time","page_time_seconds","time_spent"]
  }

  dimension: user_id {
    label: "User ID"
    type: string
    sql: ${TABLE}.user_id ;;
    description: "Unique identifier for the user (may be anonymous or logged-in id)."
    synonyms: ["uid","customer_id","buyer_id"]
  }

  dimension: wishlist_size {
    label: "Wishlist Size"
    type: number
    sql: ${TABLE}.wishlist_size ;;
    description: "Number of items in the user's wishlist."
    synonyms: ["favorites_count","saved_items_count","wishlist_count"]
  }

  measure: count {
    label: "Event Count"
    type: count
    description: "Count of behavioral signal records in the result set."
    synonyms: ["row_count","events_count"]
  }
}

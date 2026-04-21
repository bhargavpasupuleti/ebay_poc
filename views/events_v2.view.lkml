view: events_v2 {
sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.events_v2` ;;

  ########################
  # Primary Key
  ########################

  dimension: event_id {
    primary_key: yes
    type: string
    description: "The unique identifier for a specific user action or event."
    synonyms: ["Action ID", "Activity Key", "Event Key"]
    sql: ${TABLE}.event_id ;;
  }


  dimension: user_id {
    type: string
    description: "The unique identifier for the customer or visitor."
    synonyms: ["Customer ID", "Member ID", "Visitor ID", "UID"]
    sql: ${TABLE}.user_id ;;
  }

  dimension: session_id {
    type: string
    description: "The unique identifier for a single browsing session or visit."
    synonyms: ["Visit ID", "Session Key", "Browsing Session"]
    sql: ${TABLE}.session_id ;;
  }

  ########################
  # Event Date
  ########################

  dimension_group: event_date {
    type: time
    timeframes: [raw, date, week, month, year]
    datatype: timestamp          # ← ADD THIS — tells Looker it's a DATE not
    description: "The date and time when the event occurred."
    synonyms: ["Activity Date", "Timestamp", "Occurred At"]
    sql: TIMESTAMP(${TABLE}.event_date) ;;
  }

  ########################
  # Event Details
  ########################

  dimension: event_type {
    type: string
    description: "The specific action taken by the user (e.g., page_view, add_to_cart, search)."
    synonyms: ["Action Type", "Behavior", "Event Name"]
    sql: ${TABLE}.event_type ;;
  }

  dimension: category {
    type: string
    description: "The high-level product or site category associated with the event."
    synonyms: ["Department", "Site Section", "Product Group"]
    sql: ${TABLE}.category ;;
  }

  dimension: search_keyword {
    type: string
    description: "The specific terms or phrases entered by the user in the search bar."
    synonyms: ["Search Term", "Query", "Keywords"]
    sql: ${TABLE}.search_keyword ;;
  }

  ########################
  # Platform & Device
  ########################

  dimension: device {
    type: string
    description: "The type of hardware used (e.g., Mobile, Desktop, Tablet)."
    synonyms: ["Hardware", "Device Type", "Handset"]
    sql: ${TABLE}.device ;;
  }

  dimension: platform {
    type: string
    description: "The operating system or environment (e.g., iOS, Android, Web)."
    synonyms: ["OS", "Environment", "Source Platform"]
    sql: ${TABLE}.platform ;;
  }

  ########################
  # Intent & Signals
  ########################

  dimension: is_high_intent {
    type: yesno
    description: "Identifies actions that strongly signal purchase intent (Add to Cart, Wishlist, Checkout)."
    synonyms: ["Hot Lead", "Buying Signal", "Purchase Intent"]
    sql: ${event_type} IN ('add_to_cart', 'wishlist_add', 'checkout') ;;
  }

  dimension: is_search {
    type: yesno
    description: "True if the event was a site search."
    synonyms: ["Search Action", "Is Query"]
    sql: ${event_type} = 'search' ;;
  }

  dimension: is_heavy_browse {
    type: yesno
    description: "Identifies users exhibiting high browsing activity, typically indicating deep interest."
    synonyms: ["Window Shopper", "Deep Browser", "Active Researcher"]
    sql: ${TABLE}.is_2b_heavy_browse ;;
  }

  ########################
  # Cart Value
  ########################

  dimension: cart_value_usd {
    type: number
    value_format_name: usd
    description: "The total monetary value of items in the cart at the time of the event."
    synonyms: ["Basket Value", "Cart Amount", "Potential Revenue"]
    sql: ${TABLE}.cart_value_usd ;;
  }

  ########################
  # Measures
  ########################

  measure: event_count {
    type: count
    description: "The total volume of actions or events recorded."
    synonyms: ["Total Events", "Volume of Actions", "Activity Count"]
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "The unique count of individual customers or visitors."
    synonyms: ["Reach", "Unique Visitors", "Customer Count"]
  }

  measure: sessions {
    type: count_distinct
    sql: ${session_id} ;;
    description: "The unique count of browsing sessions."
    synonyms: ["Total Visits", "Traffic", "Session Count"]
  }

  measure: high_intent_events {
    type: count
    filters: [is_high_intent: "yes"]
    description: "Total number of events categorized as high-intent actions."
    synonyms: ["Quality Actions", "Conversion Signals"]
  }

  measure: high_intent_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_high_intent: "yes"]
    description: "The number of unique users who performed at least one high-intent action."
    synonyms: ["Prospects", "Interested Shoppers"]
  }

  measure: high_intent_event_rate {
    type: number
    value_format_name: percent_2
    description: "The ratio of high-intent actions to total site actions."
    synonyms: ["Intent Density", "Action Quality Rate"]
    sql:
      CASE
        WHEN ${event_count} = 0 THEN NULL
        ELSE ${high_intent_events} / ${event_count}
      END ;;
  }

  measure: avg_cart_value_usd {
    type: average
    value_format_name: usd
    description: "The average value of carts across all recorded events."
    synonyms: ["Average Basket", "Average Cart Size"]
    sql: ${cart_value_usd} ;;
  }

  measure: heavy_browse_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_heavy_browse: "yes"]
    description: "The number of unique users flagged for heavy browsing behavior."
    synonyms: ["Power Browsers", "High Engagement Users"]
  }

  dimension: days_to_conversion {
    type: number
    description: "The time elapsed between this event and the final purchase transaction."
    synonyms: ["Conversion Lag", "Purchase Latency", "Time to Buy"]
    sql: DATE_DIFF(${purchase_transaction_v2.transaction_date_date}, ${event_date_date}, DAY) ;;
  }

  measure: cart_abandoners {
    type:        count_distinct
    sql:         ${user_id} ;;
    description: "Users who added to cart but did NOT complete a purchase. Proxy for cart abandonment."
    filters: [event_type: "add_to_cart"]
    # Note: for true abandonment, agent should cross-reference with purchase_transaction_v2
  }

  measure: add_to_cart_events {
    type:    count
    filters: [event_type: "add_to_cart"]
  }

  measure: checkout_events {
    type:    count
    filters: [event_type: "checkout"]
  }

  measure: page_view_events {
    type:    count
    filters: [event_type: "page_view"]
  }

  measure: search_events {
    type:    count
    filters: [event_type: "search"]
  }

  measure: wishlist_add_events {
    type:    count
    filters: [event_type: "wishlist_add"]
  }

# Cart Abandonment Rate = add_to_cart events / purchase events ratio
  measure: cart_to_purchase_rate {
    type:               number
    value_format_name:  percent_2
    description:        "Ratio of add-to-cart events that resulted in a purchase. Inverse is cart abandonment rate."
    sql: SAFE_DIVIDE(${purchase_transaction_v2.transactions}, ${add_to_cart_events}) ;;
  }


}

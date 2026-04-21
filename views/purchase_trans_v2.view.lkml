view: purchase_transaction_v2 {
sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.purchase_trans_v2` ;;

  ########################
  # Primary Key
  ########################

  dimension: transaction_id {
    primary_key: yes
    type: string
    description: "The unique identifier for a completed purchase or order."
    synonyms: ["Order ID", "Purchase ID", "Transaction Key", "Receipt Number"]
    sql: ${TABLE}.transaction_id ;;
  }

  ########################
  # Foreign Keys
  ########################

  dimension: user_id {
    type: string
    description: "The unique identifier for the customer who made the purchase."
    synonyms: ["Customer ID", "Buyer ID", "UID", "Shopper ID"]
    sql: ${TABLE}.user_id ;;
  }

  dimension: item_id {
    type: string
    description: "The unique identifier for the specific product sold."
    synonyms: ["SKU", "Product ID", "Item Code", "Article Number"]
    sql: ${TABLE}.item_id ;;
  }

  ########################
  # Transaction Date
  ########################

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]

    datatype: date          # ← ADD THIS

    description: "The date and time when the purchase was finalized."
    synonyms: ["Order Date", "Purchase Date", "Sale Date", "Transaction Time"]
    sql: ${TABLE}.transaction_date ;;
  }

  ########################
  # Item Details
  ########################

  dimension: item_title {
    type: string
    description: "The formal name or description of the product."
    synonyms: ["Product Name", "Item Name", "Title", "Label"]
    sql: ${TABLE}.item_title ;;
  }

  dimension: category {
    type: string
    description: "The specific product classification (e.g., Dining Tables, Floor Lamps)."
    synonyms: ["Product Category", "Sub-category", "Department", "Class"]
    sql: ${TABLE}.category ;;
  }

  dimension: category_group {
    type: string
    description: "The high-level grouping of products (e.g., Furniture, Decor)."
    synonyms: ["Division", "Top-level Category", "Super Category"]
    sql: ${TABLE}.category_group ;;
  }

  dimension: item_condition {
    type: string
    description: "The state of the item at time of sale (e.g., New, Refurbished)."
    synonyms: ["State", "Quality", "Status"]
    sql: ${TABLE}.item_condition ;;
  }

  ########################
  # Platform & Device
  ########################

  dimension: platform {
    type: string
    description: "The software environment used for the purchase (e.g., iOS, Android, Web)."
    synonyms: ["OS", "Operating System", "Storefront"]
    sql: ${TABLE}.platform ;;
  }

  dimension: device {
    type: string
    description: "The hardware used by the customer (e.g., Mobile, Tablet, Desktop)."
    synonyms: ["Hardware", "Device Type", "User Agent"]
    sql: ${TABLE}.device ;;
  }

  ########################
  # Flags
  ########################

  dimension: is_return {
    type: yesno
    description: "Indicates if the transaction was eventually returned or refunded."
    synonyms: ["Returned", "Refunded", "Reversed", "Is Refund"]
    sql: ${TABLE}.is_return ;;
  }

  ########################
  # Pricing (Base Fields)
  ########################

  dimension: item_price_usd {
    type: number
    value_format_name: usd
    description: "The unit price of a single item in US Dollars."
    synonyms: ["Unit Cost", "Price Each", "Sticker Price"]
    sql: ${TABLE}.item_price_usd ;;
  }

  dimension: quantity {
    type: number
    description: "The number of units purchased in the transaction."
    synonyms: ["Volume", "Unit Count", "Amount Purchased"]
    sql: ${TABLE}.quantity ;;
  }

  dimension: shipping_cost_usd {
    type: number
    value_format_name: usd
    description: "The cost charged for shipping/delivery in US Dollars."
    synonyms: ["Freight", "Delivery Fee", "Shipping Charges"]
    sql: ${TABLE}.shipping_cost_usd ;;
  }

  ########################
  # Measures
  ########################

  measure: transactions {
    type: count
    description: "Total number of unique transaction records."
    synonyms: ["Order Count", "Total Purchases", "Number of Sales"]
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Total number of unique customers who made a purchase."
    synonyms: ["Unique Buyers", "Customer Reach", "Purchaser Count"]
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
    description: "The total sum of all units sold across transactions."
    synonyms: ["Total Units", "Items Sold", "Quantity Sum"]
  }

  measure: gmv_usd {
    type: sum
    value_format_name: usd
    description: "Gross Merchandise Value: Total sales before shipping and taxes."
    synonyms: ["Revenue", "Total Sales", "Gross Revenue", "GMV"]
    sql: ${item_price_usd} * ${quantity} ;;
  }

  measure: shipping_usd {
    type: sum
    value_format_name: usd
    description: "Total shipping revenue collected."
    synonyms: ["Total Freight", "Shipping Income"]
    sql: ${shipping_cost_usd} ;;
  }

  measure: total_paid_usd {
    type: sum
    value_format_name: usd
    description: "The grand total paid by customers (Product Price * Quantity + Shipping)."
    synonyms: ["Gross Spend", "Total Amount Paid", "Total Collections"]
    sql: (${item_price_usd} * ${quantity}) + ${shipping_cost_usd} ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_2
    description: "The percentage of transactions that resulted in a return."
    synonyms: ["Refund Rate", "Churn Rate on Items"]
    sql:
      CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE SUM(CASE WHEN ${is_return} THEN 1 ELSE 0 END) / COUNT(*)
      END ;;
  }

  measure: transactions_per_user {
    type: number
    value_format_name: decimal_2
    description: "The average number of orders placed per unique customer."
    synonyms: ["Order Frequency", "Purchase Rate per Customer"]
    sql:
    CASE
      WHEN ${users} = 0 THEN NULL
      ELSE ${transactions} / ${users}
    END ;;
  }

  measure: returning_buyers {
    type:    count_distinct
    sql:     ${user_id} ;;
    description: "Distinct users who made more than one purchase (proxy for repeat buyers)."
  }

  measure: net_gmv_usd {
    type:              number
    value_format_name: usd
    description:       "GMV minus returns estimate."
    sql: SUM(CASE WHEN NOT ${is_return} THEN ${item_price_usd} * ${quantity} ELSE 0 END) ;;
  }

  measure: avg_order_value {
    type:              number
    value_format_name: usd
    sql:  SAFE_DIVIDE(${gmv_usd}, ${transactions}) ;;
  }

}

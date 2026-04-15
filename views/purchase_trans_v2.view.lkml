view: purchase_transaction {

  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.purchase_trans_v2` ;;

  ########################
  # Primary Key
  ########################

  dimension: transaction_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  ########################
  # Foreign Keys
  ########################

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
  }

  ########################
  # Transaction Date
  ########################

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.transaction_date ;;
  }

  ########################
  # Item Details
  ########################

  dimension: item_title {
    type: string
    sql: ${TABLE}.item_title ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: category_group {
    type: string
    sql: ${TABLE}.category_group ;;
  }

  dimension: item_condition {
    type: string
    sql: ${TABLE}.item_condition ;;
  }

  ########################
  # Platform & Device
  ########################

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  ########################
  # Flags
  ########################

  dimension: is_return {
    type: yesno
    sql: ${TABLE}.is_return ;;
  }

  ########################
  # Pricing (Base Fields)
  ########################

  dimension: item_price_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.item_price_usd ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: shipping_cost_usd {
    type: number
    value_format_name: usd
    sql: ${TABLE}.shipping_cost_usd ;;
  }

  ########################
  # Measures
  ########################

  measure: transactions {
    type: count
  }

  measure: users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
  }

  measure: gmv_usd {
    type: sum
    value_format_name: usd
    sql: ${item_price_usd} * ${quantity} ;;
  }

  measure: shipping_usd {
    type: sum
    value_format_name: usd
    sql: ${shipping_cost_usd} ;;
  }

  measure: total_paid_usd {
    type: number
    value_format_name: usd
    sql: (${item_price_usd} * ${quantity}) + ${shipping_cost_usd} ;;
  }

  measure: return_rate {
    type: number
    value_format_name: percent_2
    sql:
      CASE
        WHEN COUNT(*) = 0 THEN NULL
        ELSE SUM(CASE WHEN ${is_return} THEN 1 ELSE 0 END) / COUNT(*)
      END ;;
  }

  measure: transactions_per_user {
    type: number
    value_format_name: decimal_2
    sql:
    CASE
      WHEN ${users} = 0 THEN NULL
      ELSE ${transactions} / ${users}
    END ;;
  }

}

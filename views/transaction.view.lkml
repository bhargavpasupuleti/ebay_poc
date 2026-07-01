view: transaction {
  sql_table_name: `ebay_looker_poc.transaction` ;;

  dimension: transaction_row_key {
    primary_key: yes
    hidden: yes
    type: string
    description: "Synthetic row key built from transaction and item for stable row-level drill behavior."
    sql: CONCAT(CAST(${TABLE}.transaction_id AS STRING), '|', CAST(${TABLE}.item_id AS STRING)) ;;
  }

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    description: "Date when the purchase happened."
    sql: CAST(${TABLE}.trans_dt AS DATE) ;;
  }

  dimension: transaction_id {
    type: string
    description: "Unique purchase event identifier for the checkout transaction."
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: buyer_id {
    type: number
    description: "Internal buyer identifier tied to the purchase."
    sql: ${TABLE}.buyer_id ;;
  }

  dimension: seller_id {
    type: number
    description: "Internal seller identifier tied to the purchased item."
    sql: ${TABLE}.seller_id ;;
  }

  dimension: item_id {
    type: string
    description: "Unique eBay listing or item involved in the purchase."
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_name {
    type: string
    description: "Human-readable listing title used for drill and transaction composition analysis."
    sql: ${TABLE}.item_name ;;
  }

  dimension: category_id {
    type: number
    description: "Most detailed leaf category ID assigned to the item."
    sql: ${TABLE}.leaf_categ_id ;;
  }

  dimension: category_desc {
    type: string
    description: "Business-friendly category name for the purchased item."
    sql: ${TABLE}.ctgry_desc ;;
  }

  dimension: engagement_lv1_desc {
    type: string
    description: "Higher-level engagement classification attached to the attributed transaction record."
    sql: ${TABLE}.engmnt_lv1_desc ;;
  }

  dimension: engagement_lv2_desc {
    type: string
    description: "More detailed engagement classification attached to the attributed transaction record."
    sql: ${TABLE}.engmnt_lv2_desc ;;
  }

  dimension: event_type_desc {
    type: string
    description: "Business event or message type that received attribution for the purchase."
    sql: ${TABLE}.event_type_desc ;;
  }

  dimension: expertise_desc {
    type: string
    description: "Customer expertise or shopper sophistication segment available on the attributed transaction record."
    sql: ${TABLE}.expertise_desc ;;
  }

  dimension: fm_segment_desc {
    type: string
    description: "FM segment label attached to the attributed transaction record."
    sql: ${TABLE}.fm_segmnt_desc ;;
  }

  dimension: channel_name {
    type: string
    description: "Communication channel that received attribution for the purchase."
    sql: ${TABLE}.chnl_name ;;
  }

  dimension: channel_tracking_id {
    type: string
    description: "Unique tracking value used to tie sends, engagement, and purchase attribution together across a channel."
    sql: ${TABLE}.chnl_trckng_id ;;
  }

  dimension: source_campaign_cd {
    type: string
    description: "Originating campaign code stored on the marketing event record."
    sql: ${TABLE}.src_cmpgn_cd ;;
  }

  dimension: source_tracking_cd {
    type: string
    description: "Campaign or send code used to identify the originating source program."
    sql: ${TABLE}.src_trckng_cd ;;
  }

  dimension: message_tracking_id {
    type: string
    description: "Message-level tracking identifier used to link outbound communication and downstream purchase attribution."
    sql: ${TABLE}.msg_trckng_id ;;
  }

  dimension: traffic_source_detail {
    type: string
    description: "Extra campaign and click-tracking details attached to the attributed source event."
    sql: ${TABLE}.trfc_src_dtl ;;
  }

  dimension: click_traffic_source_detail {
    type: string
    description: "Additional detailed tracking information captured for the matched click event."
    sql: ${TABLE}.click_trfc_src_dtl ;;
  }

  dimension: cmi_traffic_source_id {
    type: string
    description: "Detailed traffic source code coming from the checkout-level attribution source."
    sql: ${TABLE}.cmi_trfc_src_id ;;
  }

  dimension: user_country_id {
    type: string
    description: "Buyer country identifier on the transaction record."
    sql: ${TABLE}.user_cntry_id ;;
  }

  dimension: user_site_id {
    type: string
    description: "eBay site or market the buyer belongs to."
    sql: ${TABLE}.user_site_id ;;
  }

  dimension: item_site_id {
    type: string
    description: "eBay site where the item was listed."
    sql: ${TABLE}.item_site_id ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    description: "Number of units bought in the transaction."
    sql: COALESCE(${TABLE}.quantity, 0) ;;
  }

  dimension: item_prchsd_cnt {
    hidden: yes
    type: number
    description: "Number of purchased items credited in the transaction using current reporting logic."
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) ;;
  }

  dimension: core_item_cnt {
    hidden: yes
    type: number
    description: "Number of core items counted for the purchase in the reporting logic."
    sql: COALESCE(${TABLE}.core_item_cnt, 0) ;;
  }

  dimension: item_price {
    hidden: yes
    type: number
    description: "Price of one unit of the purchased item."
    sql: COALESCE(${TABLE}.item_price, 0) ;;
  }

  dimension: gmb_amt {
    hidden: yes
    type: number
    value_format_name: usd
    description: "Attributed merchandise value of the transaction in the reporting currency."
    sql: COALESCE(${TABLE}.gmb_amt, 0) ;;
  }

  dimension: incntv_spend_amt {
    hidden: yes
    type: number
    value_format_name: usd
    description: "Value of incentive cost attributed to the transaction."
    sql: COALESCE(${TABLE}.incntv_spend_amt, 0) ;;
  }

  dimension: incentivized_transaction {
    hidden: yes
    type: yesno
    description: "Yes when the transaction has attributed incentive spend greater than zero."
    sql: COALESCE(${TABLE}.incntv_spend_amt, 0) > 0 ;;
  }

  set: transaction_drill_fields {
    fields: [
      transaction_date_date,
      transaction_id,
      buyer_id,
      seller_id,
      item_id,
      item_name,
      category_id,
      category_desc,
      channel_name,
      source_campaign_cd,
      source_tracking_cd,
      fm_segment_desc,
      expertise_desc
    ]
  }


  measure: transactions {
    type: count_distinct
    sql: ${transaction_id} ;;
    description: "Distinct attributed transactions in the filtered result set."
    drill_fields: [transaction_drill_fields*]
  }

  measure: buyers {
    type: count_distinct
    sql: ${buyer_id} ;;
    description: "Distinct buyers in the filtered transaction result set."
  }


  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
    description: "Distinct purchased items in the filtered transaction result set."
  }

  measure: total_items_purchased {
    type: sum
    sql: ${item_prchsd_cnt} ;;
    description: "Total purchased-item count across the filtered result set."
  }

  measure: total_units {
    type: sum
    sql: ${quantity} ;;
    description: "Total purchased unit quantity across the filtered result set."
  }

  measure: total_core_items {
    type: sum
    sql: ${core_item_cnt} ;;
    description: "Total core item count across the filtered result set."
  }

  measure: total_gmb_usd {
    type: sum
    sql: ${gmb_amt} ;;
    value_format_name: usd
    description: "Total attributed merchandise value in reporting currency across the filtered result set."
  }

  measure: total_incentive_spend {
    type: sum
    sql: ${incntv_spend_amt} ;;
    value_format_name: usd
    description: "Total attributed incentive spend across the filtered result set."
  }

  measure: incentivized_transactions {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [incentivized_transaction: "yes"]
    description: "Distinct transactions with attributed incentive spend."
  }

  measure: incentivized_buyers {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [incentivized_transaction: "yes"]
    description: "Distinct buyers with at least one incentivized transaction."
  }

  measure: buyers_last_7d {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [transaction_date_date: "7 days"]
    description: "Distinct buyers in the last 7 days."
  }

  measure: buyers_last_30d {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [transaction_date_date: "30 days"]
    description: "Distinct buyers in the last 30 days."
  }

  measure: transactions_last_7d {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [transaction_date_date: "7 days"]
    description: "Distinct transactions in the last 7 days."
  }

  measure: transactions_last_30d {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [transaction_date_date: "30 days"]
    description: "Distinct transactions in the last 30 days."
  }

  measure: gmb_last_7d {
    type: sum
    sql: ${gmb_amt} ;;
    filters: [transaction_date_date: "7 days"]
    value_format_name: usd
    description: "Attributed merchandise value in the last 7 days."
  }

  measure: gmb_last_30d {
    type: sum
    sql: ${gmb_amt} ;;
    filters: [transaction_date_date: "30 days"]
    value_format_name: usd
    description: "Attributed merchandise value in the last 30 days."
  }

  measure: average_order_value {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${transactions}) ;;
    value_format_name: usd
    description: "Average attributed merchandise value per distinct transaction."
  }

  measure: avg_gmb_per_buyer {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${buyers}) ;;
    value_format_name: usd
    description: "Average attributed merchandise value per distinct buyer."
  }

  measure: items_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_items_purchased}, ${transactions}) ;;
    value_format_name: decimal_2
    description: "Average purchased-item count per distinct transaction."
  }

  measure: units_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_units}, ${transactions}) ;;
    value_format_name: decimal_2
    description: "Average unit quantity per distinct transaction."
  }

  measure: incentive_spend_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_incentive_spend}, ${transactions}) ;;
    value_format_name: usd
    description: "Average attributed incentive spend per distinct transaction."
  }

  measure: gmb_per_incentive_dollar {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${total_incentive_spend}) ;;
    value_format_name: decimal_2
    description: "Attributed merchandise value generated per dollar of attributed incentive spend."
  }

  measure: incentivized_buyer_rate {
    type: number
    sql: SAFE_DIVIDE(${incentivized_buyers}, ${buyers}) ;;
    value_format_name: percent_2
    description: "Share of buyers with at least one incentivized transaction."
  }
}

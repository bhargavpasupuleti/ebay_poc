view: crm_transaction {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.transaction` ;;

  dimension: transaction_row_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(CAST(${TABLE}.transaction_id AS STRING), '|', CAST(${TABLE}.item_id AS STRING)) ;;
  }

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.trans_dt AS DATE) ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: buyer_id {
    type: number
    sql: ${TABLE}.buyer_id ;;
  }

  dimension: seller_id {
    type: number
    sql: ${TABLE}.seller_id ;;
  }

  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }

  dimension: category_desc {
    type: string
    sql: ${TABLE}.ctgry_desc ;;
  }

  dimension: engagement_lv1_desc {
    type: string
    sql: ${TABLE}.engmnt_lv1_desc ;;
  }

  dimension: engagement_lv2_desc {
    type: string
    sql: ${TABLE}.engmnt_lv2_desc ;;
  }

  dimension: event_type_desc {
    type: string
    sql: ${TABLE}.event_type_desc ;;
  }

  dimension: expertise_desc {
    type: string
    sql: ${TABLE}.expertise_desc ;;
  }

  dimension: fm_segment_desc {
    type: string
    sql: ${TABLE}.fm_segmnt_desc ;;
  }

  dimension: channel_name {
    type: string
    sql: ${TABLE}.chnl_name ;;
  }

  dimension: chnl_trckng_id {
    type: string
    sql: ${TABLE}.chnl_trckng_id ;;
  }



  dimension: source_tracking_cd {
    type: string
    sql: ${TABLE}.src_trckng_cd ;;
  }

  dimension: message_tracking_id {
    type: string
    sql: ${TABLE}.msg_trckng_id ;;
  }

  dimension: traffic_source_detail {
    type: string
    sql: ${TABLE}.trfc_src_dtl ;;
  }

  dimension: click_traffic_source_detail {
    type: string
    sql: ${TABLE}.click_trfc_src_dtl ;;
  }

  dimension: cmi_traffic_source_id {
    type: string
    sql: ${TABLE}.cmi_trfc_src_id ;;
  }

  dimension: user_country_id {
    type: string
    sql: ${TABLE}.user_cntry_id ;;
  }

  dimension: user_site_id {
    type: string
    sql: ${TABLE}.user_site_id ;;
  }

  dimension: item_site_id {
    type: string
    sql: ${TABLE}.item_site_id ;;
  }

  dimension: quantity {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.quantity, 0) ;;
  }

  dimension: item_prchsd_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.item_prchsd_cnt, 0) ;;
  }

  dimension: core_item_cnt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.core_item_cnt, 0) ;;
  }

  dimension: item_price {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.item_price, 0) ;;
  }

  dimension: gmb_amt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.gmb_amt, 0) ;;
  }

  dimension: incntv_spend_amt {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.incntv_spend_amt, 0) ;;
  }

  dimension: incentivized_transaction {
    hidden: yes
    type: yesno
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
      source_tracking_cd,
      fm_segment_desc,
      expertise_desc
    ]
  }

  measure: rows {
    type: count
    drill_fields: [transaction_drill_fields*]
  }

  measure: transactions {
    type: count_distinct
    sql: ${transaction_id} ;;
    drill_fields: [transaction_drill_fields*]
  }

  measure: buyers {
    type: count_distinct
    sql: ${buyer_id} ;;
  }

  measure: sellers {
    type: count_distinct
    sql: ${seller_id} ;;
  }

  measure: items {
    type: count_distinct
    sql: ${item_id} ;;
  }

  measure: total_items_purchased {
    type: sum
    sql: ${item_prchsd_cnt} ;;
  }

  measure: total_units {
    type: sum
    sql: ${quantity} ;;
  }

  measure: total_core_items {
    type: sum
    sql: ${core_item_cnt} ;;
  }

  measure: total_gmb_usd {
    type: sum
    sql: ${gmb_amt} ;;
    value_format_name: usd
  }

  measure: total_incentive_spend {
    type: sum
    sql: ${incntv_spend_amt} ;;
    value_format_name: usd
  }

  measure: incentivized_transactions {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [incentivized_transaction: "yes"]
  }

  measure: incentivized_buyers {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [incentivized_transaction: "yes"]
  }

  measure: buyers_last_7d {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [transaction_date_date: "7 days"]
  }

  measure: buyers_last_30d {
    type: count_distinct
    sql: ${buyer_id} ;;
    filters: [transaction_date_date: "30 days"]
  }

  measure: transactions_last_7d {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [transaction_date_date: "7 days"]
  }

  measure: transactions_last_30d {
    type: count_distinct
    sql: ${transaction_id} ;;
    filters: [transaction_date_date: "30 days"]
  }

  measure: gmb_last_7d {
    type: sum
    sql: ${gmb_amt} ;;
    filters: [transaction_date_date: "7 days"]
    value_format_name: usd
  }

  measure: gmb_last_30d {
    type: sum
    sql: ${gmb_amt} ;;
    filters: [transaction_date_date: "30 days"]
    value_format_name: usd
  }

  measure: average_order_value {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${transactions}) ;;
    value_format_name: usd
  }

  measure: avg_gmb_per_buyer {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${buyers}) ;;
    value_format_name: usd
  }

  measure: items_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_items_purchased}, ${transactions}) ;;
    value_format_name: decimal_2
  }

  measure: units_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_units}, ${transactions}) ;;
    value_format_name: decimal_2
  }

  measure: incentive_spend_per_transaction {
    type: number
    sql: SAFE_DIVIDE(${total_incentive_spend}, ${transactions}) ;;
    value_format_name: usd
  }

  measure: gmb_per_incentive_dollar {
    type: number
    sql: SAFE_DIVIDE(${total_gmb_usd}, ${total_incentive_spend}) ;;
    value_format_name: decimal_2
  }

  measure: incentivized_buyer_rate {
    type: number
    sql: SAFE_DIVIDE(${incentivized_buyers}, ${buyers}) ;;
    value_format_name: percent_2
  }
}

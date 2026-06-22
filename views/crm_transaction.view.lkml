view: crm_transaction {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.crm_transaction` ;;

  dimension: buyer_id {
    type: number
    sql: ${TABLE}.buyer_id ;;
  }
  dimension: canvas_id {
    type: string
    sql: ${TABLE}.canvas_id ;;
  }
  dimension: chnl_name {
    type: string
    sql: ${TABLE}.chnl_name ;;
  }
  dimension: chnl_trckng_id {
    type: string
    sql: ${TABLE}.chnl_trckng_id ;;
  }
  dimension: click_trfc_src_dtl {
    type: string
    sql: ${TABLE}.click_trfc_src_dtl ;;
  }
  dimension: cmi_trfc_src_id {
    type: string
    sql: ${TABLE}.cmi_trfc_src_id ;;
  }
  dimension: core_item_cnt {
    type: number
    sql: ${TABLE}.core_item_cnt ;;
  }
  dimension: ctgry_desc {
    type: string
    sql: ${TABLE}.ctgry_desc ;;
  }
  dimension: engmnt_lv1_desc {
    type: string
    sql: ${TABLE}.engmnt_lv1_desc ;;
  }
  dimension: engmnt_lv2_desc {
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
  dimension: fm_segmnt_desc {
    type: string
    sql: ${TABLE}.fm_segmnt_desc ;;
  }
  dimension: gmb_amt {
    type: number
    sql: ${TABLE}.gmb_amt ;;
  }
  dimension: ibuyer_cnt {
    type: number
    sql: ${TABLE}.ibuyer_cnt ;;
  }
  dimension: incntv_spend_amt {
    type: number
    sql: ${TABLE}.incntv_spend_amt ;;
  }
  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
  }
  dimension: item_prchsd_cnt {
    type: number
    sql: ${TABLE}.item_prchsd_cnt ;;
  }
  dimension: item_price {
    type: number
    sql: ${TABLE}.item_price ;;
  }
  dimension: item_site_id {
    type: string
    sql: ${TABLE}.item_site_id ;;
  }
  dimension: leaf_categ_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }
  dimension: msg_trckng_id {
    type: string
    sql: ${TABLE}.msg_trckng_id ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }
  dimension: seller_id {
    type: number
    sql: ${TABLE}.seller_id ;;
  }
  dimension: sent_user_id {
    type: number
    sql: ${TABLE}.sent_user_id ;;
  }
  dimension: src_cmpgn_cd {
    type: string
    sql: ${TABLE}.src_cmpgn_cd ;;
  }
  dimension: src_trckng_cd {
    type: string
    sql: ${TABLE}.src_trckng_cd ;;
  }
  dimension_group: trans_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.trans_dt ;;
  }
  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }
  dimension: trfc_src_dtl {
    type: string
    sql: ${TABLE}.trfc_src_dtl ;;
  }
  dimension: user_cntry_id {
    type: string
    sql: ${TABLE}.user_cntry_id ;;
  }
  dimension: user_site_id {
    type: string
    sql: ${TABLE}.user_site_id ;;
  }
  measure: count {
    type: count
    drill_fields: [chnl_name]
  }

  measure: total_transactions{
  type: count_distinct
  sql: ${transaction_id};;
  }
  measure: total_items_purchased{
  type: sum
  sql: ${item_prchsd_cnt};;
  }

}

view: user_segment_dim {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_segm_dim` ;;

  dimension: bvs_byr_val_sgm_type_cd {
    type: string
    sql: ${TABLE}.bvs_byr_val_sgm_type_cd ;;
  }
  dimension: bvs_byr_val_sgm_type_desc {
    type: string
    sql: ${TABLE}.bvs_byr_val_sgm_type_desc ;;
  }
  dimension: dna_app_visit_ind {
    type: yesno
    sql: ${TABLE}.dna_app_visit_ind ;;
  }
  dimension: dna_cust_cntry_id {
    type: string
    sql: ${TABLE}.dna_cust_cntry_id ;;
  }
  dimension: dw_user_cntry_id {
    type: string
    sql: ${TABLE}.dw_user_cntry_id ;;
  }
  dimension_group: dw_user_cre {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dw_user_cre_date ;;
  }
  dimension: dw_user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.dw_user_id ;;
  }
  dimension: dw_user_site_id {
    type: string
    sql: ${TABLE}.dw_user_site_id ;;
  }
  dimension: dw_user_sts_code {
    type: string
    sql: ${TABLE}.dw_user_sts_code ;;
  }
  dimension: dw_user_sts_desc {
    type: string
    sql: ${TABLE}.dw_user_sts_desc ;;
  }
  dimension: fc_focus_customer_desc {
    type: string
    sql: ${TABLE}.fc_focus_customer_desc ;;
  }
  dimension: fc_focus_customer_flag {
    type: yesno
    sql: ${TABLE}.fc_focus_customer_flag ;;
  }
  dimension: fc_rtw_segment_nm {
    type: string
    sql: ${TABLE}.fc_rtw_segment_nm ;;
  }
  dimension: fm_buyer_type_cd {
    type: string
    sql: ${TABLE}.fm_buyer_type_cd ;;
  }
  dimension: fm_buyer_type_desc {
    type: string
    sql: ${TABLE}.fm_buyer_type_desc ;;
  }
  dimension: life_lifestage_segment {
    type: string
    sql: ${TABLE}.life_lifestage_segment ;;
  }
  measure: count {
    type: count
  }
  measure: total_user_ids{
  type: count_distinct
  sql: ${dw_user_id} ;;
  }
}

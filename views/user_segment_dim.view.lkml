view: user_segment_dim {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.user_segm_dim` ;;

  dimension: dw_user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.dw_user_id ;;
  }

  dimension_group: user_create_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.dw_user_cre_date AS DATE) ;;
  }

  dimension: dw_user_site_id {
    type: string
    sql: ${TABLE}.dw_user_site_id ;;
  }

  dimension: dw_user_country_id {
    type: string
    sql: ${TABLE}.dw_user_cntry_id ;;
  }

  dimension: dna_customer_country_id {
    type: string
    sql: ${TABLE}.dna_cust_cntry_id ;;
  }

  dimension: dw_user_status_code {
    type: string
    sql: ${TABLE}.dw_user_sts_code ;;
  }

  dimension: dw_user_status_desc {
    type: string
    sql: ${TABLE}.dw_user_sts_desc ;;
  }

  dimension: buyer_value_segment_code {
    type: string
    sql: ${TABLE}.bvs_byr_val_sgm_type_cd ;;
  }

  dimension: buyer_value_segment_desc {
    type: string
    sql: ${TABLE}.bvs_byr_val_sgm_type_desc ;;
  }

  dimension: fm_buyer_type_code {
    type: string
    sql: ${TABLE}.fm_buyer_type_cd ;;
  }

  dimension: fm_buyer_type_desc {
    type: string
    sql: ${TABLE}.fm_buyer_type_desc ;;
  }

  dimension: focus_customer_desc {
    type: string
    sql: ${TABLE}.fc_focus_customer_desc ;;
  }

  dimension: focus_customer_flag {
    type: yesno
    sql: ${TABLE}.fc_focus_customer_flag ;;
  }

  dimension: rtw_segment_name {
    type: string
    sql: ${TABLE}.fc_rtw_segment_nm ;;
  }

  dimension: lifestage_segment {
    type: string
    sql: ${TABLE}.life_lifestage_segment ;;
  }

  dimension: app_visitor_flag {
    type: yesno
    sql: ${TABLE}.dna_app_visit_ind ;;
  }

  dimension: user_tenure_days {
    hidden: yes
    type: number
    sql: DATE_DIFF(CURRENT_DATE(), CAST(${TABLE}.dw_user_cre_date AS DATE), DAY) ;;
  }

  dimension: tenure_bucket {
    type: string
    sql: CASE
      WHEN ${user_tenure_days} < 30 THEN '0-29 days'
      WHEN ${user_tenure_days} < 90 THEN '30-89 days'
      WHEN ${user_tenure_days} < 180 THEN '90-179 days'
      WHEN ${user_tenure_days} < 365 THEN '180-364 days'
      ELSE '365+ days'
    END ;;
  }

  set: segment_drill_fields {
    fields: [
      dw_user_id,
      user_create_date_date,
      dw_user_site_id,
      dw_user_country_id,
      dw_user_status_desc,
      buyer_value_segment_desc,
      fm_buyer_type_desc,
      focus_customer_desc,
      rtw_segment_name,
      lifestage_segment,
      tenure_bucket,
      app_visitor_flag
    ]
  }

  measure: users {
    type: count_distinct
    sql: ${dw_user_id} ;;
    drill_fields: [segment_drill_fields*]
  }



  measure: app_visitors {
    type: count_distinct
    sql: ${dw_user_id} ;;
    filters: [app_visitor_flag: "yes"]
  }
}

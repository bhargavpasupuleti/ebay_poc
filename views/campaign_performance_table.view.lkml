view: campaign_performance_table {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.campaign_performance_table` ;;

  dimension: a_gmv {
    type: number
    sql: ${TABLE}.aGMV ;;
  }
  dimension: a_no_ra {
    type: number
    sql: ${TABLE}.aNoRA ;;
  }
  dimension_group: actn_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.actn_dt ;;
  }
  dimension: agmb {
    type: number
    sql: ${TABLE}.agmb ;;
  }
  dimension: app_reengage_user_cnt {
    type: number
    sql: ${TABLE}.app_reengage_user_cnt ;;
  }
  dimension: bi {
    type: number
    sql: ${TABLE}.bi ;;
  }
  dimension: buyer_qv_cnt {
    type: number
    sql: ${TABLE}.buyer_qv_cnt ;;
  }
  dimension: buyer_qv_cnt_bbowacss {
    type: number
    sql: ${TABLE}.buyer_qv_cnt_bbowacss ;;
  }
  dimension: buyer_qv_cnt_new2cat {
    type: number
    sql: ${TABLE}.buyer_qv_cnt_new2cat ;;
  }
  dimension: buyer_qv_cnt_validpage {
    type: number
    sql: ${TABLE}.buyer_qv_cnt_validpage ;;
  }
  dimension: buyer_value_segment {
    type: string
    sql: ${TABLE}.buyer_value_segment ;;
  }
  dimension: chnl_nm {
    type: string
    sql: ${TABLE}.chnl_nm ;;
  }
  dimension: class_l1 {
    type: string
    sql: ${TABLE}.class_l1 ;;
  }
  dimension: class_l2 {
    type: string
    sql: ${TABLE}.class_l2 ;;
  }
  dimension: class_l3 {
    type: string
    sql: ${TABLE}.class_l3 ;;
  }
  dimension: class_l4 {
    type: string
    sql: ${TABLE}.class_l4 ;;
  }
  dimension: class_l5 {
    type: string
    sql: ${TABLE}.class_l5 ;;
  }
  dimension: class_l6 {
    type: string
    sql: ${TABLE}.class_l6 ;;
  }
  dimension: click_cnt {
    type: number
    sql: ${TABLE}.click_cnt ;;
  }
  dimension: comm_type {
    type: string
    sql: ${TABLE}.comm_type ;;
  }
  dimension: crm_flag {
    type: string
    sql: ${TABLE}.crm_flag ;;
  }
  dimension: cross_chnl_grp_nm {
    type: string
    sql: ${TABLE}.cross_chnl_grp_nm ;;
  }
  dimension: cross_chnl_nm {
    type: string
    sql: ${TABLE}.cross_chnl_nm ;;
  }
  dimension: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
  }
  dimension: i_gmb_minus_optout {
    type: number
    sql: ${TABLE}.iGMB_minus_Optout ;;
  }
  dimension: i_no_ra {
    type: number
    sql: ${TABLE}.iNoRA ;;
  }
  dimension: igmb {
    type: number
    sql: ${TABLE}.igmb ;;
  }
  dimension: lifecycle_lo_seg_nm {
    type: string
    sql: ${TABLE}.lifecycle_lo_seg_nm ;;
  }
  dimension: net_gmb {
    type: number
    sql: ${TABLE}.net_GMB ;;
  }
  dimension: opt_out_cost {
    type: number
    sql: ${TABLE}.opt_out_cost ;;
  }
  dimension: prgm_event_type_desc {
    type: string
    sql: ${TABLE}.prgm_event_type_desc ;;
  }
  dimension: prgm_grp_nm {
    type: string
    sql: ${TABLE}.prgm_grp_nm ;;
  }
  dimension: program_name {
    type: string
    sql: ${TABLE}.program_name ;;
  }
  dimension: qv {
    type: number
    sql: ${TABLE}.qv ;;
  }
  dimension: qv_bbowacss {
    type: number
    sql: ${TABLE}.qv_bbowacss ;;
  }
  dimension: qv_new2cat {
    type: number
    sql: ${TABLE}.qv_new2cat ;;
  }
  dimension: qv_validpage {
    type: number
    sql: ${TABLE}.qv_validpage ;;
  }
  dimension: retail_week {
    type: number
    sql: ${TABLE}.retail_week ;;
  }
  dimension_group: retail_wk_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.retail_wk_end_date ;;
  }
  dimension_group: rtl_week_beg_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.rtl_week_beg_dt ;;
  }
  dimension: send_cnt {
    type: number
    sql: ${TABLE}.send_cnt ;;
  }
  dimension: sent_event_type_desc {
    type: string
    sql: ${TABLE}.sent_event_type_desc ;;
  }
  dimension: suppress_flg {
    type: yesno
    sql: ${TABLE}.suppress_flg ;;
  }
  dimension: unsub_cnt {
    type: number
    sql: ${TABLE}.unsub_cnt ;;
  }
  dimension: unsub_cnt_raw {
    type: number
    sql: ${TABLE}.unsub_cnt_raw ;;
  }
  dimension: user_status_nm {
    type: string
    sql: ${TABLE}.user_status_nm ;;
  }
  measure: count {
    type: count
    drill_fields: [program_name]
  }
  measure: total_sends {
    type: sum
    sql: ${TABLE}.send_cnt ;;
    label: "Total Sends"
    value_format: "#0.0,,\"M\""
    drill_fields: [chnl_nm, prgm_grp_nm, comm_type, total_sends]
    tags: ["volume"]
  }
  measure: total_clicks {
    type: sum
    sql: ${TABLE}.click_cnt ;;
    label: "Total Clicks"
    value_format_name: decimal_0
    drill_fields: [chnl_nm, prgm_grp_nm, total_clicks]
    tags: ["volume"]
  }

  measure: total_unsub_raw {
    type: sum
    sql: ${TABLE}.unsub_cnt_raw ;;
    label: "Unsubscribes (Raw)"
    value_format_name: decimal_0
  }

  measure: total_unsub {
    type: sum
    sql: ${TABLE}.unsub_cnt ;;
    label: "Unsubscribes (Net)"
    value_format_name: decimal_0
    tags: ["risk"]
  }

  measure: total_agmb {
    type: sum
    sql: ${TABLE}.agmb ;;
    label: "Attributed GMB (aGMB)"
    value_format_name: usd
    drill_fields: [program_name, comm_type, chnl_nm, total_agmb]
    tags: ["revenue"]
  }

  measure: total_lgmb {
    type: sum
    sql: ${TABLE}.lgmb ;;
    label: "Last-Touch GMB (lGMB)"
    value_format_name: usd
    tags: ["revenue"]
  }

  measure: total_bi {
    type: sum
    sql: ${TABLE}.bi ;;
    label: "Basket Influence (BI)"
    value_format_name: usd
    tags: ["revenue"]
  }

  measure: total_qv {
    type: sum
    sql: ${TABLE}.qv ;;
    label: "Qualified Visits (QV)"
    value_format_name: decimal_0
    tags: ["engagement"]
  }

  measure: total_qv_new2cat {
    type: sum
    sql: ${TABLE}.qv_new2cat ;;
    label: "QV New-to-Category"
    value_format_name: decimal_0
  }

  measure: total_buyer_qv_cnt {
    type: sum
    sql: ${TABLE}.buyer_qv_cnt ;;
    label: "Buyer QV Count"
    value_format_name: decimal_0
    drill_fields: [buyer_value_segment, program_name, total_buyer_qv_cnt]
    tags: ["engagement"]
  }

  measure: total_agmv {
    type: sum
    sql: ${TABLE}.aGMV ;;
    label: "Attributed GMV (aGMV)"
    value_format_name: usd
    tags: ["revenue"]
  }

  measure: total_app_reengage {
    type: sum
    sql: ${TABLE}.app_reengage_user_cnt ;;
    label: "App Re-engage Users"
    value_format_name: decimal_0
  }

  measure: total_opt_out_cost {
    type: sum
    sql: ${TABLE}.opt_out_cost ;;
    label: "Opt-Out Cost"
    value_format_name: usd
    tags: ["cost"]
  }

  measure: total_net_gmb {
    type: sum
    sql: ${TABLE}.net_GMB ;;
    label: "Net GMB"
    value_format_name: usd
    drill_fields: [prgm_grp_nm, chnl_nm, total_net_gmb, total_opt_out_cost]
    tags: ["revenue"]
  }

  measure: total_igmb_minus_optout {
    type: sum
    sql: ${TABLE}.iGMB_minus_Optout ;;
    label: "Incremental GMB (net of opt-out)"
    value_format_name: usd
    drill_fields: [program_name, buyer_value_segment, total_igmb_minus_optout]
    tags: ["revenue"]
  }

  measure: avg_ctr {
    type: average
    sql: ${TABLE}.ctr ;;
    label: "Avg CTR"
    value_format: "0.00%"
    drill_fields: [chnl_nm, program_name, avg_ctr]
    tags: ["engagement"]
  }

  # Computed CTR from raw counts
  measure: computed_ctr {
    type: number
    sql: SAFE_DIVIDE(${total_clicks}, NULLIF(${total_sends}, 0)) ;;
    label: "CTR (computed)"
    value_format: "0.00%"
    tags: ["engagement"]
  }

  # Unsub rate
  measure: unsub_rate {
    type: number
    sql: SAFE_DIVIDE(${total_unsub}, NULLIF(${total_sends}, 0)) ;;
    label: "Unsub Rate"
    value_format: "0.00%"
    tags: ["risk"]
  }

  # iGMB per send
  measure: igmb_per_send {
    type: number
    sql: SAFE_DIVIDE(${total_igmb_minus_optout}, NULLIF(${total_sends}, 0)) ;;
    label: "iGMB per Send ($)"
    value_format: "$0.0000"
    tags: ["revenue"]
  }

  # # Suppressed record count
  # measure: suppressed_count {
  #   type: count
  #   filters: [is_suppressed: "Yes"]
  #   label: "Suppressed Record Count"
  #   value_format_name: decimal_0
  #   tags: ["risk"]
  # }

  # Row count
  measure: record_count {
    type: count
    label: "Record Count"
    value_format_name: decimal_0
  }
}

view: crm_engagementtable {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.crm_engagementtable` ;;

  dimension: a_gmv {
    type: number
    hidden: yes
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
  dimension: buyer_qv_cnt_validpage {
    type: number
    sql: ${TABLE}.buyer_qv_cnt_validpage ;;
  }
  dimension: buyer_value_segment {
    type: string
    sql: ${TABLE}.buyer_value_segment ;;
  }
  dimension: canvas_id {
    type: string
    sql: ${TABLE}.canvas_id ;;
  }
  dimension: chnl_nm {
    type: string
    sql: ${TABLE}.chnl_nm ;;
  }
  dimension: chnl_site_id {
    type: string
    sql: ${TABLE}.chnl_site_id ;;
  }
  dimension: chnl_trckng_id {
    type: string
    sql: ${TABLE}.chnl_trckng_id ;;
  }
  dimension: click_cnt {
    type: number
    sql: ${TABLE}.click_cnt ;;
  }
  dimension: comm_type {
    type: string
    sql: ${TABLE}.comm_type ;;
  }
  dimension: cross_chnl_grp_nm {
    type: string
    sql: ${TABLE}.cross_chnl_grp_nm ;;
  }
  dimension: i_no_ra {
    type: number
    sql: ${TABLE}.iNoRA ;;
  }
  dimension: i_no_rl {
    type: number
    sql: ${TABLE}.iNoRL ;;
  }
  dimension: igmb {
    type: number
    sql: ${TABLE}.igmb ;;
  }
  dimension: is_uep {
    type: yesno
    sql: ${TABLE}.is_uep ;;
  }
  dimension: msg_id {
    type: string
    sql: ${TABLE}.msg_id ;;
  }
  dimension: no_rl {
    type: number
    sql: ${TABLE}.NoRL ;;
  }
  dimension: opt_out_cost {
    type: number
    sql: ${TABLE}.opt_out_cost ;;
  }
  dimension: prgm_grp_nm {
    type: string
    sql: ${TABLE}.prgm_grp_nm ;;
  }
  dimension: prgm_nm {
    type: string
    sql: ${TABLE}.prgm_nm ;;
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
  dimension: retail_year {
    type: number
    sql: ${TABLE}.retail_year ;;
  }
  dimension_group: rtl_week_beg_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.rtl_week_beg_dt ;;
  }
  dimension: sent_event_type_desc {
    type: string
    sql: ${TABLE}.sent_event_type_desc ;;
  }
  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }
  dimension: src_cmpgn_cd {
    type: string
    sql: ${TABLE}.src_cmpgn_cd ;;
  }
  dimension: src_trckng_cd {
    type: string
    sql: ${TABLE}.src_trckng_cd ;;
  }
  dimension: unsub_cnt {
    type: number
    sql: ${TABLE}.unsub_cnt ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: user_status_nm {
    type: string
    sql: ${TABLE}.user_status_nm ;;
  }
  measure: count {
    type: count
  }
  measure: total_agmv {
    label: "Attributed GMV"
    type: sum
    sql: ${a_gmv} ;;
  }
  measure: total_agmb {
    label: "Attributed GMB"
    type: sum
    sql: ${agmb} ;;
  }
  measure: total_clicks{
  type: sum
  sql: ${click_cnt} ;;
  }

  measure: reached_users{
  type: count_distinct
  sql: ${user_id} ;;
  }
  # measure: reach_rate{
  # type: number
  # sql: ${reached_users} / NULLIF(${user_segment_dim.total_user_ids}, 0);;
  # }
  measure: clicks_per_user{
  type: number
  sql: ${total_clicks} / NULLIF(${reached_users}, 0);;
  }

  measure: total_unsubscribes{
  type: sum
  sql: ${unsub_cnt};;
 }
  measure: unsub_rate{
  type: number
  sql: ${total_unsubscribes} / NULLIF(${total_clicks}, 0);;
  value_format_name: percent_4
  }

  measure: total_opt_out_cost{
  type: sum
  sql: ${opt_out_cost};;}
  measure: total_buyer_qv{
  type: sum
  sql: ${buyer_qv_cnt};;
  }
  measure: incremental_gmb {
    type: sum
    sql: ${igmb} ;;
  }

}

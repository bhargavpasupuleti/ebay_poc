view: campaign_insights {
  sql_table_name: `ebay_looker_poc.campaign_performance_table`  ;;  # TODO: point to your warehouse table

  # ------------------------------------------------------------------
  # SURROGATE KEY (grain = channel x program x segment x retail week)
  # ------------------------------------------------------------------
  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(CAST(${TABLE}.actn_dt AS STRING), '|', ${TABLE}.chnl_nm, '|',
                COALESCE(${TABLE}.program_name,''), '|', COALESCE(${TABLE}.buyer_value_segment,''),
                '|', COALESCE(${TABLE}.lifecycle_lo_seg_nm,'')) ;;
  }

  # ------------------------------------------------------------------
  # DATE / TIME DIMENSIONS
  # ------------------------------------------------------------------
  dimension_group: actn {
    label: "Action"
    type: time
    datatype: date
    timeframes: [date, week, month, quarter, year, day_of_week, month_name]
    sql: ${TABLE}.actn_dt ;;
  }

  dimension_group: retail_week_beg {
    label: "Retail Week Start"
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.rtl_week_beg_dt ;;
  }

  dimension_group: retail_week_end {
    label: "Retail Week End"
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.retail_wk_end_date ;;
  }

  dimension: retail_week {
    label: "Retail Week #"
    type: number
    sql: ${TABLE}.retail_week ;;
  }

  # ------------------------------------------------------------------
  # CAMPAIGN / CHANNEL DIMENSIONS
  # ------------------------------------------------------------------
  dimension: channel {
    label: "Channel"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.chnl_nm ;;
    suggestions: ["PUSH_NOTIFICATION", "HUB_NOTIFICATION", "SITE_EMAIL"]
  }

  dimension: comm_type {
    label: "Communication Type"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.comm_type ;;
  }

  dimension: crm_flag {
    label: "CRM Flag"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.crm_flag ;;
  }

  dimension: cross_channel_group {
    label: "Cross Channel Group"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.cross_chnl_grp_nm ;;
  }

  dimension: cross_channel_name {
    label: "Cross Channel Name"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.cross_chnl_nm ;;
  }

  dimension: program_group_name {
    label: "Program Group"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.prgm_grp_nm ;;
  }

  dimension: program_name {
    label: "Program Name"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.program_name ;;
    link: {
      label: "Drill into program detail"
      url: "{{ link }}"
    }
  }

  dimension: sent_event_type {
    label: "Sent Event Type"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.sent_event_type_desc ;;
  }

  dimension: program_event_type {
    label: "Program Event Type"
    group_label: "Campaign Attributes"
    type: string
    sql: ${TABLE}.prgm_event_type_desc ;;
  }

  # ------------------------------------------------------------------
  # PRODUCT / CATEGORY DIMENSIONS
  # ------------------------------------------------------------------
  dimension: class_l1 {
    label: "Category L1"
    group_label: "Product Category"
    type: string
    sql: ${TABLE}.class_l1 ;;
  }

  dimension: class_l2 {
    label: "Category L2"
    group_label: "Product Category"
    type: string
    sql: ${TABLE}.class_l2 ;;
  }

  dimension: class_l3 {
    label: "Category L3"
    group_label: "Product Category"
    type: string
    sql: ${TABLE}.class_l3 ;;
  }

  dimension: class_l4 {
    label: "Category L4"
    group_label: "Product Category"
    type: string
    sql: ${TABLE}.class_l4 ;;
  }

  dimension: class_l5 {
    label: "Category L5"
    group_label: "Product Category"
    type: string
    sql: ${TABLE}.class_l5 ;;
  }

  # ------------------------------------------------------------------
  # AUDIENCE / SEGMENT DIMENSIONS
  # ------------------------------------------------------------------
  dimension: suppress_flag {
    label: "Suppressed?"
    group_label: "Audience"
    type: yesno
    sql: ${TABLE}.suppress_flg ;;
  }

  dimension: buyer_value_segment {
    label: "Buyer Value Segment"
    group_label: "Audience"
    type: string
    sql: ${TABLE}.buyer_value_segment ;;
  }

  # Custom sort order so the segment tiers display logically, not alphabetically
  dimension: buyer_value_segment_sort {
    hidden: yes
    type: number
    sql: CASE ${TABLE}.buyer_value_segment
            WHEN 'High Enthusiasts' THEN 1
            WHEN 'Mid Value Buyer' THEN 2
            WHEN 'Low Value Buyer' THEN 3
            WHEN 'Unsegmented' THEN 4
            ELSE 5 END ;;
  }

  dimension: lifecycle_segment {
    label: "Lifecycle Segment"
    group_label: "Audience"
    type: string
    sql: ${TABLE}.lifecycle_lo_seg_nm ;;
  }

  dimension: user_status {
    label: "User Status"
    group_label: "Audience"
    type: string
    sql: ${TABLE}.user_status_nm ;;
  }

  # ------------------------------------------------------------------
  # RAW ADDITIVE FACTS -> hidden, exposed only through measures below
  # ------------------------------------------------------------------
  dimension: send_cnt      { hidden: yes type: number sql: ${TABLE}.send_cnt ;; }
  dimension: click_cnt     { hidden: yes type: number sql: ${TABLE}.click_cnt ;; }
  dimension: unsub_cnt     { hidden: yes type: number sql: ${TABLE}.unsub_cnt ;; }
  dimension: agmb          { hidden: yes type: number sql: ${TABLE}.agmb ;; }
  dimension: igmb          { hidden: yes type: number sql: ${TABLE}.igmb ;; }
  dimension: bi            { hidden: yes type: number sql: ${TABLE}.bi ;; }
  dimension: qv            { hidden: yes type: number sql: ${TABLE}.qv ;; }
  dimension: buyer_qv_cnt  { hidden: yes type: number sql: ${TABLE}.buyer_qv_cnt ;; }
  dimension: aNoRA         { hidden: yes type: number sql: ${TABLE}.aNoRA ;; }
  dimension: iNoRA         { hidden: yes type: number sql: ${TABLE}.iNoRA ;; }
  dimension: aGMV          { hidden: yes type: number sql: ${TABLE}.aGMV ;; }
  dimension: app_reengage  { hidden: yes type: number sql: ${TABLE}.app_reengage_user_cnt ;; }
  dimension: opt_out_cost  { hidden: yes type: number sql: ${TABLE}.opt_out_cost ;; }
  dimension: net_gmb       { hidden: yes type: number sql: ${TABLE}.net_GMB ;; }
  dimension: igmb_minus_optout { hidden: yes type: number sql: ${TABLE}.iGMB_minus_Optout ;; }

  # ==================================================================
  # MEASURES
  # ==================================================================

  # ---- Volume measures -------------------------------------------------
  measure: total_sends {
    label: "Total Sends"
    group_label: "Volume"
    type: sum
    sql: ${send_cnt} ;;
    value_format_name: decimal_0
    drill_fields: [channel, program_name, total_sends, total_clicks, ctr_pct]
  }

  measure: total_clicks {
    label: "Total Clicks"
    group_label: "Volume"
    type: sum
    sql: ${click_cnt} ;;
    value_format_name: decimal_0
    drill_fields: [channel, program_name, total_clicks, total_sends, ctr_pct]
  }

  measure: total_unsubscribes {
    label: "Total Unsubscribes"
    group_label: "Volume"
    type: sum
    sql: ${unsub_cnt} ;;
    value_format_name: decimal_0
  }

  measure: total_qualified_visits {
    label: "Total Qualified Visits"
    group_label: "Volume"
    type: sum
    sql: ${qv} ;;
    value_format_name: decimal_0
  }

  measure: total_buyer_qv {
    label: "Total Buyer QVs"
    group_label: "Volume"
    type: sum
    sql: ${buyer_qv_cnt} ;;
    value_format_name: decimal_0
  }

  measure: total_app_reengaged_users {
    label: "App Re-engaged Users"
    group_label: "Volume"
    type: sum
    sql: ${app_reengage} ;;
    value_format_name: decimal_0
  }

  # ---- Revenue / financial measures ------------------------------------
  measure: total_agmb {
    label: "Attributed GMB (aGMB)"
    group_label: "Revenue"
    type: sum
    sql: ${agmb} ;;
    value_format_name: usd_0
  }

  measure: total_igmb {
    label: "Incremental GMB (iGMB)"
    group_label: "Revenue"
    type: sum
    sql: ${igmb} ;;
    value_format_name: usd_0
    drill_fields: [channel, program_name, total_igmb, total_sends]
  }

  measure: total_bi {
    label: "Booked Incremental (BI)"
    group_label: "Revenue"
    type: sum
    sql: ${bi} ;;
    value_format_name: usd_0
  }

  measure: total_agmv {
    label: "Attributed GMV (aGMV)"
    group_label: "Revenue"
    type: sum
    sql: ${aGMV} ;;
    value_format_name: usd_0
  }

  measure: total_net_gmb {
    label: "Net GMB"
    group_label: "Revenue"
    type: sum
    sql: ${net_gmb} ;;
    value_format_name: usd_0
  }

  measure: total_igmb_minus_optout {
    label: "iGMB minus Opt-Out Cost"
    group_label: "Revenue"
    type: sum
    sql: ${igmb_minus_optout} ;;
    value_format_name: usd_0
  }

  measure: total_optout_cost {
    label: "Opt-Out Cost"
    group_label: "Revenue"
    type: sum
    sql: ${opt_out_cost} ;;
    value_format_name: usd_0
  }

  measure: total_anora {
    label: "Attributed New Orders (aNoRA)"
    group_label: "Revenue"
    type: sum
    sql: ${aNoRA} ;;
    value_format_name: decimal_0
  }

  measure: total_inora {
    label: "Incremental New Orders (iNoRA)"
    group_label: "Revenue"
    type: sum
    sql: ${iNoRA} ;;
    value_format_name: decimal_0
  }

  # ---- Efficiency / rate measures (ratio-of-sums, calculated in SQL) ---
  measure: ctr_pct {
    label: "CTR %"
    group_label: "Efficiency"
    description: "Click-through rate = Total Clicks / Total Sends"
    type: number
    sql: SAFE_DIVIDE(1.0 * ${total_clicks}, NULLIF(${total_sends}, 0)) ;;
    value_format_name: percent_2
  }

  measure: unsub_rate_pct {
    label: "Unsubscribe Rate %"
    group_label: "Efficiency"
    description: "Unsubscribes / Total Sends"
    type: number
    sql: SAFE_DIVIDE(1.0 * ${total_unsubscribes}, NULLIF(${total_sends}, 0)) ;;
    value_format_name: percent_2
  }

  measure: buyer_conversion_rate_pct {
    label: "QV-to-Buyer Conversion %"
    group_label: "Efficiency"
    description: "Buyer Qualified Visits / Total Qualified Visits"
    type: number
    sql: SAFE_DIVIDE(1.0 * ${total_buyer_qv}, NULLIF(${total_qualified_visits}, 0)) ;;
    value_format_name: percent_2
  }

  measure: gmb_per_send {
    label: "iGMB per Send ($)"
    group_label: "Efficiency"
    description: "Revenue efficiency of a single send"
    type: number
    sql: SAFE_DIVIDE(${total_igmb}, NULLIF(${total_sends}, 0)) ;;
    value_format_name: usd
  }

  measure: cost_per_incremental_dollar {
    label: "Opt-Out Cost per $1 iGMB"
    group_label: "Efficiency"
    description: "How much opt-out cost is generated per incremental revenue dollar - lower is better"
    type: number
    sql: SAFE_DIVIDE(${total_optout_cost}, NULLIF(${total_igmb}, 0)) ;;
    value_format_name: usd
  }

  parameter: dimension_picker {
    label: "Explore by"
    type: unquoted
    default_value: "channel"

    allowed_value: { label: "Channel"          value: "channel" }
    allowed_value: { label: "Buyer segment"     value: "buyer_segment" }
    allowed_value: { label: "Program group"     value: "program_group" }
    allowed_value: { label: "Comm type"         value: "comm_type" }
    allowed_value: { label: "Lifecycle stage"   value: "lifecycle_stage" }
  }

  # This is the ONE dimension the visualization actually plots.
  # Its label and its SQL both change depending on what was picked.
  dimension: dynamic_dimension {
    label_from_parameter: dimension_picker
    type: string
    sql:
      {% if dimension_picker._parameter_value == 'channel' %} ${channel}
      {% elsif dimension_picker._parameter_value == 'buyer_segment' %} ${buyer_value_segment}
      {% elsif dimension_picker._parameter_value == 'program_group' %} ${program_group_name}
      {% elsif dimension_picker._parameter_value == 'comm_type' %} ${comm_type}
      {% elsif dimension_picker._parameter_value == 'lifecycle_stage' %} ${lifecycle_segment}
      {% else %} ${channel}
      {% endif %} ;;
  }

  parameter: measure_picker {
    label: "Measure"
    type: unquoted
    default_value: "sends"

    allowed_value: { label: "Sends"     value: "sends" }
    allowed_value: { label: "Clicks"    value: "clicks" }
    allowed_value: { label: "CTR %"     value: "ctr" }
    allowed_value: { label: "GMV"       value: "gmv" }
    allowed_value: { label: "Net GMB"   value: "net_gmb" }
  }
  measure: dynamic_measure {
    label_from_parameter: measure_picker
    type: number
    sql:
      {% if measure_picker._parameter_value == 'sends' %} ${total_sends}
      {% elsif measure_picker._parameter_value == 'clicks' %} ${total_clicks}
      {% elsif measure_picker._parameter_value == 'ctr' %} ${ctr_pct}
      {% elsif measure_picker._parameter_value == 'gmv' %} ${total_agmv}
      {% elsif measure_picker._parameter_value == 'net_gmb' %} ${total_net_gmb}
      {% else %} ${total_sends}
      {% endif %} ;;
    value_format_name: decimal_0
  }



  # NOTE ON SYMMETRIC AGGREGATES:
  # All ratio measures above are built as ratio-of-sums (sum/sum), not avg-of-ratios,
  # so they stay mathematically correct no matter which dimensions they're sliced by -
  # this is the standard LookML pattern for safely aggregating rates/percentages.

  measure: row_count {
    hidden: yes
    type: count
  }

 }

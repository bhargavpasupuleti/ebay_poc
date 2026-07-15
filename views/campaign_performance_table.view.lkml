view: campaign_performance_table {
  sql_table_name: `ebay_looker_poc.campaign_performance_table` ;;

  dimension_group: actn_dt {
    label: "Action Date"
    type: time
    datatype: date
    convert_tz: no
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.actn_dt ;;
    description: "Action date for the aggregated row. Treat this as the primary date for engagement and outcome analysis because the table is action-date oriented."
  }

  dimension: retail_week {
    type: number
    sql: ${TABLE}.retail_week ;;
    value_format: "0"
    description: "Retail calendar week number for the record."
  }

  dimension_group: rtl_week_beg_dt {
    label: "Retail Week Begin Date"
    type: time
    datatype: date
    convert_tz: no
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.rtl_week_beg_dt ;;
    description: "Start date of the retail week tied to the record. Helpful when users ask for week start trend views or retail calendar alignment."
  }

  dimension_group: retail_wk_end_date {
    label: "Retail Week End Date"
    type: time
    datatype: date
    convert_tz: no
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.retail_wk_end_date ;;
    description: "End date of the retail week tied to the record. Helpful for retail calendar windows and weekly summaries."
  }

  dimension: retail_week_label {
    type: string
    sql: CONCAT(CAST(${TABLE}.retail_week AS STRING), ' | ', CAST(${TABLE}.rtl_week_beg_dt AS STRING), ' to ', CAST(${TABLE}.retail_wk_end_date AS STRING)) ;;
    description: "Readable retail week label that combines week number and week date range. Good for conversation-agent style summaries."
  }

  dimension: chnl_nm {
    label: "Channel Name"
    type: string
    sql: ${TABLE}.chnl_nm ;;
    description: "CRM delivery channel, such as PUSH_NOTIFICATION, HUB_NOTIFICATION, SITE_EMAIL, or SITE_MESSAGE_CENTER. One of the main slicing dimensions for campaign insight questions."
  }

  dimension: comm_type {
    label: "Communication Type"
    type: string
    sql: ${TABLE}.comm_type ;;
    description: "Business communication classification, such as Lifecycle, Conversion, Transactional, or Others. Useful for separating message intent and KPI expectations."
  }

  dimension: crm_flag {
    label: "CRM Flag"
    type: string
    sql: ${TABLE}.crm_flag ;;
    description: "High-level CRM ownership or routing marker, for example Central or Others. Useful for ownership-level performance cuts."
  }

  dimension: cross_chnl_grp_nm {
    label: "Cross Channel Group"
    type: string
    sql: ${TABLE}.cross_chnl_grp_nm ;;
    description: "Cross-channel program family or broader campaign grouping. Use it for rollups above the individual campaign/program level."
  }

  dimension: cross_chnl_nm {
    label: "Cross Channel Name"
    type: string
    sql: ${TABLE}.cross_chnl_nm ;;
    description: "Cross-channel program or campaign name used for mid-level grouping across executions. Useful when users ask about a campaign theme across channels."
  }

  dimension: prgm_grp_nm {
    label: "Program Group Name"
    type: string
    sql: ${TABLE}.prgm_grp_nm ;;
    description: "Program group name. Good for grouping related campaign executions under a broader program umbrella."
  }

  dimension: program_name {
    label: "Program Name"
    type: string
    sql: ${TABLE}.program_name ;;
    description: "Program or campaign name at the reporting grain in the aggregate table. This is one of the most important dimensions for campaign insight questions."
  }

  dimension: sent_event_type_desc {
    label: "Sent Event Type Description"
    type: string
    sql: ${TABLE}.sent_event_type_desc ;;
    description: "Send-side event classification from the campaign mapping layer. Useful when users want to distinguish message families or sending motion."
  }

  dimension: prgm_event_type_desc {
    label: "Program Event Type Description"
    type: string
    sql: ${TABLE}.prgm_event_type_desc ;;
    description: "Program event classification tied to the campaign or execution. Helpful for distinguishing subtypes within a program."
  }

  dimension: class_l1 {
    label: "Class L1"
    type: string
    sql: ${TABLE}.class_l1 ;;
    description: "Top taxonomy/classification level for the CRM campaign. Use with class_l2-class_l6 for hierarchical content or use-case analysis."
  }

  dimension: class_l2 {
    label: "Class L2"
    type: string
    sql: ${TABLE}.class_l2 ;;
    description: "Second taxonomy/classification level for the CRM campaign."
  }

  dimension: class_l3 {
    label: "Class L3"
    type: string
    sql: ${TABLE}.class_l3 ;;
    description: "Third taxonomy/classification level for the CRM campaign."
  }

  dimension: class_l4 {
    label: "Class L4"
    type: string
    sql: ${TABLE}.class_l4 ;;
    description: "Fourth taxonomy/classification level for the CRM campaign."
  }

  dimension: class_l5 {
    label: "Class L5"
    type: string
    sql: ${TABLE}.class_l5 ;;
    description: "Fifth taxonomy/classification level for the CRM campaign."
  }

  dimension: class_l6 {
    label: "Class L6"
    type: string
    sql: ${TABLE}.class_l6 ;;
    description: "Sixth taxonomy/classification level for the CRM campaign."
  }

  dimension: suppress_flg {
    label: "Suppress Flag"
    type: yesno
    sql: CASE
      WHEN LOWER(CAST(${TABLE}.suppress_flg AS STRING)) IN ('true','1','y','yes') THEN TRUE
      ELSE FALSE
    END ;;
    description: "Indicates whether the audience slice is flagged as suppressed in the source mapping. Useful for QA or excluded-audience questions."
  }

  dimension: buyer_value_segment {
    label: "Buyer Value Segment"
    type: string
    sql: ${TABLE}.buyer_value_segment ;;
    description: "Buyer value segment, such as High Enthusiasts, Mid Value Buyer, Low Value Buyer, or Unsegmented. One of the core audience dimensions for CRM performance analysis."
  }

  dimension: lifecycle_lo_seg_nm {
    label: "Lifecycle Segment"
    type: string
    sql: ${TABLE}.lifecycle_lo_seg_nm ;;
    description: "Lifecycle segment of the user, such as Loyal, Developing, Long Term Infrequent, or Inactive variants. Useful for lifecycle-targeting performance questions."
  }

  dimension: user_status_nm {
    label: "User Status"
    type: string
    sql: ${TABLE}.user_status_nm ;;
    description: "Current user status, such as Active or another operating status. Helpful for filtering or segmenting campaign impact."
  }

  dimension: campaign_program_key {
    type: string
    sql: CONCAT(
      COALESCE(CAST(${TABLE}.actn_dt AS STRING), ''), '|',
      COALESCE(${TABLE}.chnl_nm, ''), '|',
      COALESCE(${TABLE}.cross_chnl_grp_nm, ''), '|',
      COALESCE(${TABLE}.cross_chnl_nm, ''), '|',
      COALESCE(${TABLE}.prgm_grp_nm, ''), '|',
      COALESCE(${TABLE}.program_name, ''), '|',
      COALESCE(${TABLE}.sent_event_type_desc, ''), '|',
      COALESCE(${TABLE}.prgm_event_type_desc, '')
    ) ;;
    description: "Derived compound key for grouping a campaign/program slice when there is no single campaign identifier in the aggregate table. Useful for distinct-slice counts and drill paths."
  }

  dimension: campaign_taxonomy_path {
    type: string
    sql: CONCAT(
      COALESCE(${TABLE}.class_l1, 'Unclassified'), ' > ',
      COALESCE(${TABLE}.class_l2, 'Unclassified'), ' > ',
      COALESCE(${TABLE}.class_l3, 'Unclassified'), ' > ',
      COALESCE(${TABLE}.class_l4, 'Unclassified'), ' > ',
      COALESCE(${TABLE}.class_l5, 'Unclassified'), ' > ',
      COALESCE(${TABLE}.class_l6, 'Unclassified')
    ) ;;
    description: "Derived readable hierarchy showing the full class_l1-class_l6 path. Good for conversation outputs that need a single taxonomy label."
  }

  dimension: audience_segment_key {
    type: string
    sql: CONCAT(
      COALESCE(${TABLE}.buyer_value_segment, 'Unknown'), ' | ',
      COALESCE(${TABLE}.lifecycle_lo_seg_nm, 'Unknown'), ' | ',
      COALESCE(${TABLE}.user_status_nm, 'Unknown')
    ) ;;
    description: "Derived audience segment rollup combining buyer value, lifecycle, and user status. Useful for natural-language questions about audience mix and best-performing segments."
  }

  measure: rows_in_result {
    type: count
    drill_fields: [actn_dt_date, retail_week, chnl_nm, program_name, buyer_value_segment, lifecycle_lo_seg_nm]
    description: "Count of aggregate rows returned. This is not a count of sends, users, or campaigns; it is only the number of grouped records."
  }

  measure: distinct_campaign_program_slices {
    type: count_distinct
    sql: ${campaign_program_key} ;;
    description: "Distinct count of derived campaign/program slices in the query result. Useful for questions like how many campaign slices are represented."
  }

  measure: total_sends {
    type: sum
    sql: ${TABLE}.send_cnt ;;
    value_format: "#,##0"
    drill_fields: [campaign_drill_depth*]
    description: "Total sends from the aggregate table. This is the core delivery-volume metric and should be the denominator for most weighted rate calculations."
  }

  measure: total_clicks {
    type: sum
    sql: ${TABLE}.click_cnt ;;
    value_format: "#,##0"
    drill_fields: [campaign_drill_depth*]
    description: "Total clicks attributed in the aggregate table. Use with total_sends to calculate weighted click-through rate."
  }

  measure: total_unsub_cnt_raw {
    type: sum
    sql: ${TABLE}.unsub_cnt_raw ;;
    value_format: "#,##0"
    drill_fields: [campaign_drill_depth*]
    description: "Total raw unsubscribe count from source. Use when raw unsub signals matter before business-specific adjustments or deduping."
  }

  measure: total_unsub_cnt {
    type: sum
    sql: ${TABLE}.unsub_cnt ;;
    value_format: "#,##0"
    description: "Total adjusted/deduplicated unsubscribe count. Use this as the standard unsubscribe metric for campaign reporting."
  }

  measure: total_agmb {
    type: sum
    sql: ${TABLE}.agmb ;;
    drill_fields: [campaign_drill_depth*]
    value_format: "#,##0.00"
    description: "Total attributed GMB. Use for questions about attributed business value driven by CRM touchpoints."
  }

  measure: total_igmb {
    type: sum
    sql: ${TABLE}.igmb ;;
    value_format: "#,##0.00"
    drill_fields: [campaign_drill_depth*]
    description: "Total incremental GMB. Use for uplift-style business impact questions where incremental value is preferred over attributed value."
  }

  measure: total_bi {
    type: sum
    sql: ${TABLE}.bi ;;
    drill_fields: [campaign_drill_depth*]
    value_format: "#,##0.00"
    description: "Total BI metric carried from the upstream aggregate. Treat as a business-owned KPI from the source model; validate the acronym meaning before external-facing use."
  }

  measure: total_qv {
    type: sum
    sql: ${TABLE}.qv ;;
    value_format: "#,##0.00"
    description: "Total quality visits. This is a core engagement metric for campaign effectiveness beyond clicks."
  }

  measure: total_qv_bbowacss {
    type: sum
    sql: ${TABLE}.qv_bbowacss ;;
    value_format: "#,##0.00"
    description: "Total quality visits that meet the BBOWACSS definition from the upstream CRM data model. Use for more qualified visit analysis."
  }

  measure: total_qv_new2cat {
    type: sum
    sql: ${TABLE}.qv_new2cat ;;
    value_format: "#,##0.00"
    description: "Total quality visits classified as new-to-category. Useful for expansion and discovery-oriented campaign analysis."
  }

  measure: total_qv_validpage {
    type: sum
    sql: ${TABLE}.qv_validpage ;;
    value_format: "#,##0.00"
    description: "Total quality visits on valid pages. Useful when campaign questions focus on high-intent or valid landing-page engagement."
  }

  measure: total_buyer_qv_cnt {
    type: sum
    sql: ${TABLE}.buyer_qv_cnt ;;
    value_format: "#,##0"
    description: "Total buyer quality visit count. This is a user-count style engagement KPI rather than a raw visit total."
  }

  measure: total_buyer_qv_cnt_bbowacss {
    type: sum
    sql: ${TABLE}.buyer_qv_cnt_bbowacss ;;
    value_format: "#,##0"
    description: "Total buyer quality visit count under the BBOWACSS definition. Use for more qualified buyer-engagement cuts."
  }

  measure: total_buyer_qv_cnt_new2cat {
    type: sum
    sql: ${TABLE}.buyer_qv_cnt_new2cat ;;
    value_format: "#,##0"
    description: "Total buyer quality visit count for new-to-category behavior. Good for acquisition/expansion campaign questions."
  }

  measure: total_buyer_qv_cnt_validpage {
    type: sum
    sql: ${TABLE}.buyer_qv_cnt_validpage ;;
    value_format: "#,##0"
    description: "Total buyer quality visit count on valid pages. Use when focusing on cleaner downstream engagement."
  }

  measure: total_anora {
    type: sum
    sql: ${TABLE}.aNoRA ;;
    value_format: "#,##0"
    description: "Total attributed New or Reactivated Attempts (aNoRA). Use when analyzing attributed new/reactivated user attempts driven by CRM campaigns."
  }

  measure: total_inora {
    type: sum
    sql: ${TABLE}.iNoRA ;;
    value_format: "#,##0"
    description: "Total incremental New or Reactivated Attempts (iNoRA). Use when users ask for incremental reactivation-style outcomes rather than attributed totals."
  }

  measure: total_agmv {
    type: sum
    sql: ${TABLE}.aGMV ;;
    value_format: "#,##0.00"
    description: "Total attributed GMV. Use for attributed gross merchandise value questions at campaign, program, or segment level."
  }

  measure: total_app_reengage_user_cnt {
    type: sum
    sql: ${TABLE}.app_reengage_user_cnt ;;
    value_format: "#,##0"
    description: "Total app reengaged users. Useful for app-return and reactivation-oriented CRM questions."
  }

  measure: total_opt_out_cost {
    type: sum
    sql: ${TABLE}.opt_out_cost ;;
    value_format: "#,##0.00"
    description: "Total opt-out cost. Useful as a guardrail or penalty metric when evaluating business efficiency of campaigns."
  }

  measure: total_net_gmb {
    type: sum
    sql: ${TABLE}.net_GMB ;;
    value_format: "#,##0.00"
    description: "Total net GMB after the upstream netting logic. Use when users want a business-impact measure that already factors cost adjustments."
  }

  measure: total_igmb_minus_optout {
    type: sum
    sql: ${TABLE}.iGMB_minus_Optout ;;
    value_format: "#,##0.00"
    description: "Total incremental GMB excluding opt-out cost. Good for net incremental-value questions."
  }

  measure: avg_source_ctr {
    type: average
    sql: ${TABLE}.ctr ;;
    value_format: "0.00%"
    description: "Average of the source CTR field across returned rows. Prefer click_through_rate for rolled-up reporting because that measure recomputes CTR from total clicks and total sends."
  }

  measure: click_through_rate {
    type: number
    sql: 1.0 * ${total_clicks} / NULLIF(${total_sends}, 0) ;;
    value_format: "0.00%"
    description: "Weighted click-through rate calculated as total clicks divided by total sends. This should usually be the default CTR used by the conversation agent."
  }

  measure: unsubscribe_rate {
    type: number
    sql: 1.0 * ${total_unsub_cnt} / NULLIF(${total_sends}, 0) ;;
    value_format: "0.00%"
    description: "Weighted unsubscribe rate using adjusted unsubscribe count divided by total sends. Good for guardrail and audience-fatigue questions."
  }

  measure: raw_unsubscribe_rate {
    type: number
    sql: 1.0 * ${total_unsub_cnt_raw} / NULLIF(${total_sends}, 0) ;;
    value_format: "0.00%"
    description: "Weighted raw unsubscribe rate using raw unsubscribe count divided by sends. Use when users explicitly want raw unsub behavior."
  }

  measure: qv_per_send {
    type: number
    sql: 1.0 * ${total_qv} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Quality visits per send. Useful for comparing engagement efficiency across channels, programs, or audience segments."
  }

  measure: validpage_qv_per_send {
    type: number
    sql: 1.0 * ${total_qv_validpage} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Valid-page quality visits per send. Useful for comparing cleaner downstream engagement efficiency."
  }

  measure: buyer_qv_rate {
    type: number
    sql: 1.0 * ${total_buyer_qv_cnt} / NULLIF(${total_sends}, 0) ;;
    value_format: "0.00%"
    description: "Buyer quality visit count per send. Helpful for user-level engagement efficiency analysis."
  }

  measure: qv_bbowacss_share {
    type: number
    sql: 1.0 * ${total_qv_bbowacss} / NULLIF(${total_qv}, 0) ;;
    value_format: "0.00%"
    description: "Share of quality visits that meet the BBOWACSS definition. Useful for understanding quality mix, not just total volume."
  }

  measure: qv_new2cat_share {
    type: number
    sql: 1.0 * ${total_qv_new2cat} / NULLIF(${total_qv}, 0) ;;
    value_format: "0.00%"
    description: "Share of quality visits that are new-to-category. Good for expansion and category-discovery analysis."
  }

  measure: qv_validpage_share {
    type: number
    sql: 1.0 * ${total_qv_validpage} / NULLIF(${total_qv}, 0) ;;
    value_format: "0.00%"
    description: "Share of quality visits that land on valid pages. Useful for landing-quality and journey-quality analysis."
  }

  measure: buyer_qv_bbowacss_share {
    type: number
    sql: 1.0 * ${total_buyer_qv_cnt_bbowacss} / NULLIF(${total_buyer_qv_cnt}, 0) ;;
    value_format: "0.00%"
    description: "Share of buyer quality visit count that meets the BBOWACSS definition. Useful for qualified buyer-engagement comparisons."
  }

  measure: buyer_qv_new2cat_share {
    type: number
    sql: 1.0 * ${total_buyer_qv_cnt_new2cat} / NULLIF(${total_buyer_qv_cnt}, 0) ;;
    value_format: "0.00%"
    description: "Share of buyer quality visit count that is new-to-category. Useful for identifying programs that drive broader discovery."
  }

  measure: buyer_qv_validpage_share {
    type: number
    sql: 1.0 * ${total_buyer_qv_cnt_validpage} / NULLIF(${total_buyer_qv_cnt}, 0) ;;
    value_format: "0.00%"
    description: "Share of buyer quality visit count that reached valid pages. Useful for quality-of-traffic analysis."
  }

  measure: agmb_per_send {
    type: number
    sql: 1.0 * ${total_agmb} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Attributed GMB per send. Good for comparing business-value efficiency across campaigns and channels."
  }

  measure: igmb_per_send {
    type: number
    sql: 1.0 * ${total_igmb} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Incremental GMB per send. Useful for comparing net lift efficiency across campaign groups."
  }

  measure: net_gmb_per_send {
    type: number
    sql: 1.0 * ${total_net_gmb} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Net GMB per send after the upstream netting logic. Useful for efficiency ranking where costs matter."
  }

  measure: igmb_minus_optout_per_send {
    type: number
    sql: 1.0 * ${total_igmb_minus_optout} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Incremental GMB minus opt-out cost per send. Good for net incremental efficiency comparisons."
  }

  measure: agmv_per_send {
    type: number
    sql: 1.0 * ${total_agmv} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Attributed GMV per send. Good for comparing monetization efficiency across campaign dimensions."
  }

  measure: opt_out_cost_per_send {
    type: number
    sql: 1.0 * ${total_opt_out_cost} / NULLIF(${total_sends}, 0) ;;
    value_format: "#,##0.0000"
    description: "Opt-out cost per send. Useful as a guardrail efficiency metric when comparing audience fatigue and downstream cost."
  }

  measure: app_reengagement_rate {
    type: number
    sql: 1.0 * ${total_app_reengage_user_cnt} / NULLIF(${total_sends}, 0) ;;
    value_format: "0.00%"
    description: "App reengaged users per send. Useful for app-return and mobile reactivation campaigns."
  }

  measure: clicks_to_qv_ratio {
    type: number
    sql: 1.0 * ${total_qv} / NULLIF(${total_clicks}, 0) ;;
    value_format: "#,##0.0000"
    description: "Quality visits per click. Useful for understanding post-click quality, not just top-of-funnel engagement."
  }

  measure: agmb_per_click {
    type: number
    sql: 1.0 * ${total_agmb} / NULLIF(${total_clicks}, 0) ;;
    value_format: "#,##0.0000"
    description: "Attributed GMB per click. Useful for evaluating value density of engaged traffic."
  }

  measure: net_gmb_per_click {
    type: number
    sql: 1.0 * ${total_net_gmb} / NULLIF(${total_clicks}, 0) ;;
    value_format: "#,##0.0000"
    description: "Net GMB per click. Useful for comparing post-click monetization quality across campaign groups."
  }

  measure: incremental_share_of_attributed_gmb {
    type: number
    sql: 1.0 * ${total_igmb} / NULLIF(${total_agmb}, 0) ;;
    value_format: "0.00%"
    description: "Incremental GMB as a share of attributed GMB. Useful when users want to understand how much of attributed value appears incremental."
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
      {% if dimension_picker._parameter_value == 'channel' %} ${chnl_nm}
      {% elsif dimension_picker._parameter_value == 'buyer_segment' %} ${buyer_value_segment}
      {% elsif dimension_picker._parameter_value == 'program_group' %} ${program_name}
      {% elsif dimension_picker._parameter_value == 'comm_type' %} ${comm_type}
      {% elsif dimension_picker._parameter_value == 'lifecycle_stage' %} ${lifecycle_lo_seg_nm}
      {% else %} ${chnl_nm}
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
      {% elsif measure_picker._parameter_value == 'ctr' %} ${click_through_rate}
      {% elsif measure_picker._parameter_value == 'gmv' %} ${total_agmv}
      {% elsif measure_picker._parameter_value == 'net_gmb' %} ${total_net_gmb}
      {% else %} ${total_sends}
      {% endif %} ;;
    value_format_name: decimal_0
  }

  measure: opt_out_cost_share_of_igmb {
    type: number
    sql: 1.0 * ${total_opt_out_cost} / NULLIF(${total_igmb}, 0) ;;
    value_format: "0.00%"
    description: "Opt-out cost as a share of incremental GMB. Useful for balancing growth against fatigue or opt-out penalties."
  }
  set: campaign_drill_depth {
    fields: [
      actn_dt_date,
      chnl_nm,
      program_name,
      buyer_value_segment,
      lifecycle_lo_seg_nm,
      total_sends,
      total_clicks,
      total_agmv
    ]
  }
}

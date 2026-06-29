view: search_table {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.search` ;;

  dimension: brand_nm {
    type: string
    sql: ${TABLE}.brand_nm ;;
  }
  dimension_group: cal_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.cal_dt ;;
  }
  dimension: exprnc_lvl_id {
    type: number
    sql: ${TABLE}.exprnc_lvl_id ;;
  }
  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
  }
  dimension_group: item_prchs_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.item_prchs_dt ;;
  }
  dimension: item_price {
    type: number
    sql: ${TABLE}.item_price ;;
  }
  dimension: item_site_id {
    type: number
    sql: ${TABLE}.item_site_id ;;
  }
  dimension: leaf_categ_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }
  dimension: prdct_nm {
    type: string
    sql: ${TABLE}.prdct_nm ;;
  }
  dimension: site_id {
    type: number
    sql: ${TABLE}.site_id ;;
  }
  dimension: srch_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.srch_cnt ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: vi_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.vi_cnt ;;
  }
  dimension: vi_dwell_time {
    type: number
    hidden: yes
    sql: ${TABLE}.vi_dwell_time ;;
  }
  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }
  dimension: category_desc {
    type: string
    sql: ${TABLE}.category_desc ;;
  }
  measure: count {
    type: count
  }

  # --- SUM MEASURES ---

  measure: total_srch_cnt {
    type: sum
    sql: ${srch_cnt} ;;
    description: "Total search count"
  }

  measure: total_vi_cnt {
    type: sum
    sql: ${vi_cnt} ;;
    description: "Total View-Item (VI) count"
  }

  measure: total_vi_dwell_time {
    type: sum
    sql: ${vi_dwell_time} ;;
    description: "Total View-Item (VI) dwell time in seconds/milliseconds"
  }

  # --- AVERAGE MEASURES ---

  measure: average_item_price {
    type: average
    sql: ${item_price} ;;
    value_format_name: usd
    description: "Average price of items"
  }

  measure: average_vi_dwell_time {
    type: average
    sql: ${vi_dwell_time} ;;
    value_format_name: decimal_2
    description: "Average View-Item (VI) dwell time"
  }

  # --- COUNT DISTINCT MEASURES (IDs) ---

  measure: count_distinct_users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Total unique users searching or interacting"
  }

  measure: count_distinct_items {
    type: count_distinct
    sql: ${item_id} ;;
    description: "Total unique items represented"
  }

  measure: count_distinct_leaf_categories {
    type: count_distinct
    sql: ${leaf_categ_id} ;;
    description: "Total unique leaf categories browsed"
  }


}

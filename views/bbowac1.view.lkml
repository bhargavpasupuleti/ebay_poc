view: bbowac {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.bbowac1` ;;

  dimension: add_to_cart_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.add_to_cart_cnt ;;
  }
  dimension: asq_cnt {
    type: number
    sql: ${TABLE}.asq_cnt ;;
    hidden: yes
  }
  dimension: bid_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.bid_cnt ;;
  }
  dimension: bin_sold_ind {
    type: number
    sql: ${TABLE}.bin_sold_ind ;;
  }
  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }
  dimension: byng_trans_cnt {
    type: number
    sql: ${TABLE}.byng_trans_cnt ;;
  }
  dimension_group: cal_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.cal_dt ;;
  }
  dimension: cbt_byng_trans_cnt {
    type: number
    sql: ${TABLE}.cbt_byng_trans_cnt ;;
  }
  dimension: cbt_gmb_lc_amt {
    type: number
    sql: ${TABLE}.cbt_gmb_lc_amt ;;
  }
  dimension: cbt_gmb_lstg_curncy_amt {
    type: number
    sql: ${TABLE}.cbt_gmb_lstg_curncy_amt ;;
  }
  dimension: cbt_gmb_usd_amt {
    type: number
    sql: ${TABLE}.cbt_gmb_usd_amt ;;
  }
  dimension: cbt_item_prchsd_cnt {
    type: number
    sql: ${TABLE}.cbt_item_prchsd_cnt ;;
  }
  dimension: cndtn_rollup_id {
    type: number
    sql: ${TABLE}.cndtn_rollup_id ;;
  }
  dimension: curncy_id {
    type: number
    sql: ${TABLE}.curncy_id ;;
  }
  dimension: dd_byng_trans_cnt {
    type: number
    sql: ${TABLE}.dd_byng_trans_cnt ;;
  }
  dimension: dd_gmb_lc_amt {
    type: number
    sql: ${TABLE}.dd_gmb_lc_amt ;;
  }
  dimension: dd_gmb_lstg_curncy_amt {
    type: number
    sql: ${TABLE}.dd_gmb_lstg_curncy_amt ;;
  }
  dimension: dd_gmb_usd_amt {
    type: number
    sql: ${TABLE}.dd_gmb_usd_amt ;;
  }
  dimension: dd_item_prchsd_cnt {
    type: number
    sql: ${TABLE}.dd_item_prchsd_cnt ;;
  }
  dimension: gmb_lc_amt {
    type: number
    sql: ${TABLE}.gmb_lc_amt ;;
  }
  dimension: gmb_lstg_curncy_amt {
    type: number
    sql: ${TABLE}.gmb_lstg_curncy_amt ;;
  }
  dimension: gmb_usd_amt {
    type: number
    sql: ${TABLE}.gmb_usd_amt ;;
  }
  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
  }
  dimension: item_prchsd_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.item_prchsd_cnt ;;
  }
  dimension: leaf_categ_id {
    type: number
    sql: ${TABLE}.leaf_categ_id ;;
  }
  dimension: lstg_site_id {
    type: number
    sql: ${TABLE}.lstg_site_id ;;
  }
  dimension: lstg_type_cd {
    type: number
    sql: ${TABLE}.lstg_type_cd ;;
  }
  dimension: offer_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.offer_cnt ;;
  }
  dimension: prod_name {
    type: string
    sql: ${TABLE}.prod_name ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
  dimension: watch_cnt {
    type: number
    hidden: yes
    sql: ${TABLE}.watch_cnt ;;
  }
  measure: count {
    type: count
    drill_fields: [brand_name, prod_name]
  }
  # --- SUM MEASURES FOR COUNTS & AMOUNTS ---

  measure: total_add_to_cart_cnt {
    type: sum
    sql: ${add_to_cart_cnt} ;;
    description: "Total Add to Cart Count"
  }

  measure: total_asq_cnt {
    type: sum
    sql: ${asq_cnt} ;;
  }

  measure: total_bid_cnt {
    type: sum
    sql: ${bid_cnt} ;;
  }

  measure: total_bin_sold_ind {
    type: sum
    sql: ${bin_sold_ind} ;;
    description: "Total Buy It Now Sold Indicator"
  }

  # measure: total_byng_trans_cnt {
  #   type: sum
  #   sql: ${byng_trans_cnt} ;;
  # }

  # measure: total_cbt_byng_trans_cnt {
  #   type: sum
  #   sql: ${cbt_byng_trans_cnt} ;;
  # }

  # measure: total_cbt_gmb_lc_amt {
  #   type: sum
  #   sql: ${cbt_gmb_lc_amt} ;;
  #   value_format_name: decimal_2
  # }

  # measure: total_cbt_gmb_lstg_curncy_amt {
  #   type: sum
  #   sql: ${cbt_gmb_lstg_curncy_amt} ;;
  #   value_format_name: decimal_2
  # }

  # measure: total_cbt_gmb_usd_amt {
  #   type: sum
  #   sql: ${cbt_gmb_usd_amt} ;;
  #   value_format_name: usd
  # }

  # measure: total_cbt_item_prchsd_cnt {
  #   type: sum
  #   sql: ${cbt_item_prchsd_cnt} ;;
  # }

  # measure: total_dd_byng_trans_cnt {
  #   type: sum
  #   sql: ${dd_byng_trans_cnt} ;;
  # }

  # measure: total_dd_gmb_lc_amt {
  #   type: sum
  #   sql: ${dd_gmb_lc_amt} ;;
  #   value_format_name: decimal_2
  # }

  # measure: total_dd_gmb_lstg_curncy_amt {
  #   type: sum
  #   sql: ${dd_gmb_lstg_curncy_amt} ;;
  #   value_format_name: decimal_2
  # }

  # measure: total_dd_gmb_usd_amt {
  #   type: sum
  #   sql: ${dd_gmb_usd_amt} ;;
  #   value_format_name: usd
  # }

  # measure: total_dd_item_prchsd_cnt {
  #   type: sum
  #   sql: ${dd_item_prchsd_cnt} ;;
  # }

  # measure: total_gmb_lc_amt {
  #   type: sum
  #   sql: ${gmb_lc_amt} ;;
  #   value_format_name: decimal_2
  # }

  # measure: total_gmb_lstg_curncy_amt {
  #   type: sum
  #   sql: ${gmb_lstg_curncy_amt} ;;
  #   value_format_name: decimal_2
  # }

  measure: total_gmb_usd_amt {
    type: sum
    sql: ${gmb_usd_amt} ;;
    value_format_name: usd
  }

  measure: total_item_prchsd_cnt {
    type: sum
    sql: ${item_prchsd_cnt} ;;
  }

  measure: total_offer_cnt {
    type: sum
    sql: ${offer_cnt} ;;
  }

  measure: total_watch_cnt {
    type: sum
    sql: ${watch_cnt} ;;
  }

  # --- DISTINCT COUNTS FOR IDs ---

  measure: count_distinct_users {
    type: count_distinct
    sql: ${user_id} ;;
    description: "Count of unique users"
  }

  measure: count_distinct_items {
    type: count_distinct
    sql: ${item_id} ;;
    description: "Count of unique items"
  }

}

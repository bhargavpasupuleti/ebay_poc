view: message_metadata_v2 {
  sql_table_name: `gcp-crate-barrel-poc.ebay_looker_poc.message_metadata_v2` ;;

  dimension: ab_variant {
    type: string
    sql: ${TABLE}.ab_variant ;;
  }
  dimension: attributed_revenue_usd {
    type: number
    sql: ${TABLE}.attributed_revenue_usd ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: clicked {
    type: number
    sql: ${TABLE}.clicked ;;
  }
  dimension: converted {
    type: number
    sql: ${TABLE}.converted ;;
  }
  dimension: engagement_tag {
    type: string
    sql: ${TABLE}.engagement_tag ;;
  }
  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
  }
  dimension: opened {
    type: number
    sql: ${TABLE}.opened ;;
  }
  dimension: send_tag {
    type: string
    sql: ${TABLE}.send_tag ;;
  }
  dimension_group: sent {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.sent_date ;;
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension: zeta_send_id {
    type: string
    sql: ${TABLE}.zeta_send_id ;;
  }
  measure: count {
    type: count
  }
}

view: message_agg {

  derived_table: {
    sql:
      SELECT
        campaign_id,
        user_id,
        COUNT(*) as messages_sent,
        SUM(CASE WHEN open_status = 'opened' THEN 1 ELSE 0 END) as opens,
        SUM(CASE WHEN click_status = 'clicked' THEN 1 ELSE 0 END) as clicks,
        SUM(CASE WHEN conversion_status = 'converted' THEN 1 ELSE 0 END) as conversions
      FROM `gcp-crate-barrel-poc.ebay_looker_poc.message_metadata_new`
      GROUP BY 1,2 ;;
  }

  dimension: campaign_id { primary_key: yes }
  dimension: user_id { primary_key: yes }

  measure: messages_sent { type: sum }
  measure: opens { type: sum }
  measure: clicks { type: sum }
  measure: conversions { type: sum }
}

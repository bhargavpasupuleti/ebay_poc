view: behavioral_agg {

  derived_table: {
    sql:
      SELECT
        user_id,
        DATE(event_timestamp) as event_date,
        AVG(scroll_depth_pct) as avg_scroll_depth,
        AVG(time_on_page_sec) as avg_time_on_page,
        AVG(propensity_to_buy_score) as avg_propensity,
        AVG(churn_risk_score) as avg_churn_risk,
        COUNT(DISTINCT session_id) as sessions
      FROM `gcp-crate-barrel-poc.ebay_looker_poc.behavioral_signals_new`
      GROUP BY 1,2 ;;
  }

  dimension: user_id { primary_key: yes }

  dimension_group: event_date {
    type: time
    timeframes: [date, week, month]
  }

  measure: avg_scroll_depth { type: average }
  measure: avg_time_on_page { type: average }
  measure: avg_propensity { type: average }
  measure: avg_churn_risk { type: average }
  measure: sessions { type: sum }
}

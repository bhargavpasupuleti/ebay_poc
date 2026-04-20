connection: "ebay_test_agents_poc"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: ebay_conversational_analytics_poc_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ebay_conversational_analytics_poc_default_datagroup

explore: user_behavior {

  from: user_profile_new
  label: "User Behavior Analysis"

  join: behavioral_signals_new {
    type: left_outer
    sql_on: ${user_behavior.user_id} = ${behavioral_signals_new.user_id} ;;
    relationship: one_to_many
  }

}


explore: user_behavior_with_desc {

  from: user_profile_desc
  label: "User Activity"

  join: behavioral_signals_desc {
    type: left_outer
    sql_on: ${user_behavior_with_desc.user_id} = ${behavioral_signals_desc.user_id} ;;
    relationship: one_to_many
  }

}


include: "/views/campaign_dim_v2.view"
include: "/views/campaign_performance_v2.view"
include: "/views/message_metadata_v2.view"
include: "/views/events_v2.view"
include: "/views/purchase_trans_v2.view"
include: "/views/user_profile_v2.view"

explore: ebay_crm_agent {
  label:       "eBay CRM – Full Diagnostic Explorer"
  description: "Single explore covering campaigns, messaging, site events, purchases and user profiles. Use for RCA, channel diagnostics, funnel analysis, cohort comparisons and audience deep-dives."

  # ── Base table: Campaign Dimension ────────────────────────────────
  # Small lookup table; joining facts to it avoids fan-out on the base.
  from:  campaign_dim_v2
  view_name: campaign_dim_v2

  # ── Access filter stub (uncomment and adapt for your row-level security)
  # access_filter: {
  #   field: campaign_dim_v2.target_segment
  #   user_attribute: crm_segment_access
  # }

  # ── Always-on filters to keep BigQuery scans cheap ─────────────────
  # Adjust partition column names as needed for your tables.
  # sql_always_where:
  #   ${campaign_performance_v2.date_date} >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) ;;

  ####################################################################
  # JOIN 1 – Campaign Performance (aggregated daily roll-up)
  # Relationship: one campaign → many daily perf rows
  ####################################################################
  join: campaign_performance_v2 {
    type:         left_outer
    relationship: one_to_many
    sql_on: ${campaign_dim_v2.campaign_id} = ${campaign_performance_v2.campaign_id} ;;

    # Fields the agent will most commonly surface
    fields: [
      campaign_performance_v2.date_date,
      campaign_performance_v2.date_week,
      campaign_performance_v2.date_month,
      campaign_performance_v2.channel,
      campaign_performance_v2.target_segment,
      campaign_performance_v2.target_category,
      campaign_performance_v2.messages_sent,
      campaign_performance_v2.messages_opened,
      campaign_performance_v2.clicks,
      campaign_performance_v2.conversions,
      campaign_performance_v2.attributed_revenue_usd,
      campaign_performance_v2.cost_usd,
      campaign_performance_v2.open_rate,
      campaign_performance_v2.ctr,
      campaign_performance_v2.conversion_rate,
      campaign_performance_v2.roi
    ]
  }

  ####################################################################
  # JOIN 2 – Message-level metadata (individual send events)
  # Relationship: one campaign → many messages
  # Use required_joins so this expensive table is only scanned when
  # message-level fields are actually selected.
  ####################################################################
  join: message_metadata_v2 {
    type:         left_outer
    relationship: one_to_many
    sql_on: ${campaign_dim_v2.campaign_id} = ${message_metadata_v2.campaign_id} ;;

    fields: [
      message_metadata_v2.message_id,
      message_metadata_v2.user_id,
      message_metadata_v2.zeta_send_id,
      message_metadata_v2.ab_variant,
      message_metadata_v2.channel,
      message_metadata_v2.send_tag,
      message_metadata_v2.engagement_tag,
      message_metadata_v2.sent_date_date,
      message_metadata_v2.sent_date_week,
      message_metadata_v2.sent_date_month,
      message_metadata_v2.is_opened,
      message_metadata_v2.is_clicked,
      message_metadata_v2.is_converted,
      message_metadata_v2.is_high_intent_message,
      message_metadata_v2.attributed_revenue_usd,
      message_metadata_v2.messages_sent,
      message_metadata_v2.messages_opened,
      message_metadata_v2.messages_clicked,
      message_metadata_v2.messages_converted,
      message_metadata_v2.users_reached,
      message_metadata_v2.converters,
      message_metadata_v2.attributed_revenue,
      message_metadata_v2.open_rate,
      message_metadata_v2.ctr,
      message_metadata_v2.conversion_rate
    ]
  }

  ####################################################################
  # JOIN 3 – User profile (dimension – one row per user)
  # Joined via message_metadata → user_id bridge.
  # required_joins ensures message_metadata is in scope first so the
  # user_id FK is unambiguous and no cross-product occurs.
  ####################################################################
  join: user_profile_v2 {
    type:         left_outer
    relationship: many_to_one
    required_joins: [message_metadata_v2]
    sql_on: ${message_metadata_v2.user_id} = ${user_profile_v2.user_id} ;;

    fields: [
      user_profile_v2.user_id,
      user_profile_v2.segment,
      user_profile_v2.lifecycle_stage,
      user_profile_v2.preferred_channel,
      user_profile_v2.preferred_category,
      user_profile_v2.state,
      user_profile_v2.platform_primary,
      user_profile_v2.is_seller,
      user_profile_v2.email_opt_in,
      user_profile_v2.push_opt_in,
      user_profile_v2.sms_opt_in,
      user_profile_v2.registration_date_date,
      user_profile_v2.last_purchase_date_date,
      user_profile_v2.last_purchase_date_month,
      user_profile_v2.ltv_usd,
      user_profile_v2.total_orders_90d,
      user_profile_v2.predicted_churn_propensity,
      user_profile_v2.predicted_clv_next_90d,
      user_profile_v2.predicted_return_rate,
      user_profile_v2.rfm_score,
      user_profile_v2.bbowac_activity_90d,
      user_profile_v2.heavy_browse_2b_90d,
      user_profile_v2.ltv_bucket,
      user_profile_v2.recency_bucket,
      user_profile_v2.is_active_user,
      user_profile_v2.is_high_value_user,
      user_profile_v2.is_high_intent_user,
      user_profile_v2.users,
      user_profile_v2.active_users,
      user_profile_v2.buyers_90d,
      user_profile_v2.high_value_users,
      user_profile_v2.high_intent_users,
      user_profile_v2.avg_ltv_usd,
      user_profile_v2.avg_predicted_clv_90d
    ]
  }

  ####################################################################
  # JOIN 4 – Site / behavioural events
  # Joined on user_id; required_joins gates on message_metadata so we
  # stay within the campaign-touched audience and avoid a full table scan.
  # If you need all site events regardless of campaign exposure, remove
  # required_joins here (at query-cost).
  ####################################################################
  join: events_v2 {
    type:         left_outer
    relationship: one_to_many
    required_joins: [message_metadata_v2]
    sql_on: ${message_metadata_v2.user_id} = ${events_v2.user_id} ;;

    fields: [
      events_v2.event_id,
      events_v2.user_id,
      events_v2.session_id,
      events_v2.event_date_date,
      events_v2.event_date_week,
      events_v2.event_date_month,
      events_v2.event_type,
      events_v2.category,
      events_v2.search_keyword,
      events_v2.device,
      events_v2.platform,
      events_v2.is_high_intent,
      events_v2.is_search,
      events_v2.is_heavy_browse,
      events_v2.cart_value_usd,
      events_v2.event_count,
      events_v2.users,
      events_v2.sessions,
      events_v2.high_intent_events,
      events_v2.high_intent_users,
      events_v2.high_intent_event_rate,
      events_v2.avg_cart_value_usd,
      events_v2.heavy_browse_users
    ]
  }

  ####################################################################
  # JOIN 5 – Purchase transactions
  # Joined on user_id; required_joins chains through message_metadata
  # so we only scan buyers touched by a campaign send.
  # If the analyst wants all purchases (baseline), the agent should
  # note that required_joins can be relaxed with a separate explore.
  ####################################################################
  join: purchase_transaction_v2 {
    type:         left_outer
    relationship: one_to_many
    sql_on: ${ user_profile_v2.user_id} = ${purchase_transaction_v2.user_id} ;;

    fields: [
      purchase_transaction_v2.transaction_id,
      purchase_transaction_v2.user_id,
      purchase_transaction_v2.item_id,
      purchase_transaction_v2.transaction_date_date,
      purchase_transaction_v2.transaction_date_week,
      purchase_transaction_v2.transaction_date_month,
      purchase_transaction_v2.transaction_date_quarter,
      purchase_transaction_v2.item_title,
      purchase_transaction_v2.category,
      purchase_transaction_v2.category_group,
      purchase_transaction_v2.item_condition,
      purchase_transaction_v2.platform,
      purchase_transaction_v2.device,
      purchase_transaction_v2.is_return,
      purchase_transaction_v2.item_price_usd,
      purchase_transaction_v2.quantity,
      purchase_transaction_v2.shipping_cost_usd,
      purchase_transaction_v2.transactions,
      purchase_transaction_v2.users,
      purchase_transaction_v2.total_quantity,
      purchase_transaction_v2.gmv_usd,
      purchase_transaction_v2.shipping_usd,
      purchase_transaction_v2.total_paid_usd,
      purchase_transaction_v2.return_rate,
      purchase_transaction_v2.transactions_per_user
    ]
  }


}
  # explore: ebay_crm_agent_test {
  #   label:       "eBay CRM – Full Diagnostic Explorer"
  #   description: "Single explore covering campaigns, messaging, site events, purchases and user profiles. Use for RCA, channel diagnostics, funnel analysis, cohort comparisons and audience deep-dives."

  #   # ── Base table: Campaign Dimension ────────────────────────────────
  #   # Small lookup table; joining facts to it avoids fan-out on the base.
  #   from:  campaign_performance_v2

  #   # ── Access filter stub (uncomment and adapt for your row-level security)
  #   # access_filter: {
  #   #   field: campaign_dim_v2.target_segment
  #   #   user_attribute: crm_segment_access
  #   # }

  #   # ── Always-on filters to keep BigQuery scans cheap ─────────────────
  #   # Adjust partition column names as needed for your tables.
  #   # sql_always_where:
  #   #   ${campaign_performance_v2.date_date} >= DATE_SUB(CURRENT_DATE(), INTERVAL 365 DAY) ;;

  #   ####################################################################
  #   # JOIN 1 – Campaign Performance (aggregated daily roll-up)
  #   # Relationship: one campaign → many daily perf rows
  #   ####################################################################
  #   join: campaign_dim_v2 {
  #     type:         left_outer
  #     relationship: many_to_one
  #     sql_on: ${campaign_dim_v2.campaign_id} = ${campaign_performance_v2.campaign_id} ;;

  #     # Fields the agent will most commonly surface
  #     fields: [
  #       campaign_performance_v2.date_date,
  #       campaign_performance_v2.date_week,
  #       campaign_performance_v2.date_month,
  #       campaign_performance_v2.channel,
  #       campaign_performance_v2.target_segment,
  #       campaign_performance_v2.target_category,
  #       campaign_performance_v2.messages_sent,
  #       campaign_performance_v2.messages_opened,
  #       campaign_performance_v2.clicks,
  #       campaign_performance_v2.conversions,
  #       campaign_performance_v2.attributed_revenue_usd,
  #       campaign_performance_v2.cost_usd,
  #       campaign_performance_v2.open_rate,
  #       campaign_performance_v2.ctr,
  #       campaign_performance_v2.conversion_rate,
  #       campaign_performance_v2.roi
  #     ]
  #   }

  #   ####################################################################
  #   # JOIN 2 – Message-level metadata (individual send events)
  #   # Relationship: one campaign → many messages
  #   # Use required_joins so this expensive table is only scanned when
  #   # message-level fields are actually selected.
  #   ####################################################################
  #   join: message_metadata_v2 {
  #     type:         left_outer
  #     relationship: one_to_many
  #     sql_on: ${campaign_dim_v2.campaign_id} = ${message_metadata_v2.campaign_id} ;;

  #     fields: [
  #       message_metadata_v2.message_id,
  #       message_metadata_v2.user_id,
  #       message_metadata_v2.zeta_send_id,
  #       message_metadata_v2.ab_variant,
  #       message_metadata_v2.channel,
  #       message_metadata_v2.send_tag,
  #       message_metadata_v2.engagement_tag,
  #       message_metadata_v2.sent_date_date,
  #       message_metadata_v2.sent_date_week,
  #       message_metadata_v2.sent_date_month,
  #       message_metadata_v2.is_opened,
  #       message_metadata_v2.is_clicked,
  #       message_metadata_v2.is_converted,
  #       message_metadata_v2.is_high_intent_message,
  #       message_metadata_v2.attributed_revenue_usd,
  #       message_metadata_v2.messages_sent,
  #       message_metadata_v2.messages_opened,
  #       message_metadata_v2.messages_clicked,
  #       message_metadata_v2.messages_converted,
  #       message_metadata_v2.users_reached,
  #       message_metadata_v2.converters,
  #       message_metadata_v2.attributed_revenue,
  #       message_metadata_v2.open_rate,
  #       message_metadata_v2.ctr,
  #       message_metadata_v2.conversion_rate
  #     ]
  #   }

  #   ####################################################################
  #   # JOIN 3 – User profile (dimension – one row per user)
  #   # Joined via message_metadata → user_id bridge.
  #   # required_joins ensures message_metadata is in scope first so the
  #   # user_id FK is unambiguous and no cross-product occurs.
  #   ####################################################################
  #   join: user_profile_v2 {
  #     type:         left_outer
  #     relationship: many_to_one
  #     required_joins: [message_metadata_v2]
  #     sql_on: ${message_metadata_v2.user_id} = ${user_profile_v2.user_id} ;;

  #     fields: [
  #       user_profile_v2.user_id,
  #       user_profile_v2.segment,
  #       user_profile_v2.lifecycle_stage,
  #       user_profile_v2.preferred_channel,
  #       user_profile_v2.preferred_category,
  #       user_profile_v2.state,
  #       user_profile_v2.platform_primary,
  #       user_profile_v2.is_seller,
  #       user_profile_v2.email_opt_in,
  #       user_profile_v2.push_opt_in,
  #       user_profile_v2.sms_opt_in,
  #       user_profile_v2.registration_date_date,
  #       user_profile_v2.last_purchase_date_date,
  #       user_profile_v2.last_purchase_date_month,
  #       user_profile_v2.ltv_usd,
  #       user_profile_v2.total_orders_90d,
  #       user_profile_v2.predicted_churn_propensity,
  #       user_profile_v2.predicted_clv_next_90d,
  #       user_profile_v2.predicted_return_rate,
  #       user_profile_v2.rfm_score,
  #       user_profile_v2.bbowac_activity_90d,
  #       user_profile_v2.heavy_browse_2b_90d,
  #       user_profile_v2.ltv_bucket,
  #       user_profile_v2.recency_bucket,
  #       user_profile_v2.is_active_user,
  #       user_profile_v2.is_high_value_user,
  #       user_profile_v2.is_high_intent_user,
  #       user_profile_v2.users,
  #       user_profile_v2.active_users,
  #       user_profile_v2.buyers_90d,
  #       user_profile_v2.high_value_users,
  #       user_profile_v2.high_intent_users,
  #       user_profile_v2.avg_ltv_usd,
  #       user_profile_v2.avg_predicted_clv_90d
  #     ]
  #   }

  #   ####################################################################
  #   # JOIN 4 – Site / behavioural events
  #   # Joined on user_id; required_joins gates on message_metadata so we
  #   # stay within the campaign-touched audience and avoid a full table scan.
  #   # If you need all site events regardless of campaign exposure, remove
  #   # required_joins here (at query-cost).
  #   ####################################################################
  #   join: events_v2 {
  #     type:         left_outer
  #     relationship: one_to_many
  #     required_joins: [message_metadata_v2]
  #     sql_on: ${message_metadata_v2.user_id} = ${events_v2.user_id} ;;

  #     fields: [
  #       events_v2.event_id,
  #       events_v2.user_id,
  #       events_v2.session_id,
  #       events_v2.campaign_id,
  #       events_v2.event_date_date,
  #       events_v2.event_date_week,
  #       events_v2.event_date_month,
  #       events_v2.event_type,
  #       events_v2.category,
  #       events_v2.search_keyword,
  #       events_v2.device,
  #       events_v2.platform,
  #       events_v2.is_high_intent,
  #       events_v2.is_search,
  #       events_v2.is_heavy_browse,
  #       events_v2.cart_value_usd,
  #       events_v2.event_count,
  #       events_v2.users,
  #       events_v2.sessions,
  #       events_v2.high_intent_events,
  #       events_v2.high_intent_users,
  #       events_v2.high_intent_event_rate,
  #       events_v2.avg_cart_value_usd,
  #       events_v2.heavy_browse_users
  #     ]
  #   }

  #   ####################################################################
  #   # JOIN 5 – Purchase transactions
  #   # Joined on user_id; required_joins chains through message_metadata
  #   # so we only scan buyers touched by a campaign send.
  #   # If the analyst wants all purchases (baseline), the agent should
  #   # note that required_joins can be relaxed with a separate explore.
  #   ####################################################################
  #   join: purchase_transaction_v2 {
  #     type:         left_outer
  #     relationship: one_to_many
  #     required_joins: [message_metadata_v2]
  #     sql_on: ${message_metadata_v2.user_id} = ${purchase_transaction_v2.user_id} ;;

  #     fields: [
  #       purchase_transaction_v2.transaction_id,
  #       purchase_transaction_v2.user_id,
  #       purchase_transaction_v2.item_id,
  #       purchase_transaction_v2.transaction_date_date,
  #       purchase_transaction_v2.transaction_date_week,
  #       purchase_transaction_v2.transaction_date_month,
  #       purchase_transaction_v2.transaction_date_quarter,
  #       purchase_transaction_v2.item_title,
  #       purchase_transaction_v2.category,
  #       purchase_transaction_v2.category_group,
  #       purchase_transaction_v2.item_condition,
  #       purchase_transaction_v2.platform,
  #       purchase_transaction_v2.device,
  #       purchase_transaction_v2.is_return,
  #       purchase_transaction_v2.item_price_usd,
  #       purchase_transaction_v2.quantity,
  #       purchase_transaction_v2.shipping_cost_usd,
  #       purchase_transaction_v2.transactions,
  #       purchase_transaction_v2.users,
  #       purchase_transaction_v2.total_quantity,
  #       purchase_transaction_v2.gmv_usd,
  #       purchase_transaction_v2.shipping_usd,
  #       purchase_transaction_v2.total_paid_usd,
  #       purchase_transaction_v2.return_rate,
  #       purchase_transaction_v2.transactions_per_user
  #     ]
  #   }

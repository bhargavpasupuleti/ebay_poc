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


explore: campaign_dim_v2 {
  label: "camp_analytics_ebay_poc"
  description: "Campaign‑centric analytics with controlled fanout and correct cardinality"

  ############################
  # CAMPAIGN PERFORMANCE FACT
  ############################
  join: campaign_performance_v2 {
    type: left_outer
    sql_on: ${campaign_dim_v2.campaign_id} = ${campaign_performance_v2.campaign_id} ;;
    relationship: one_to_many
  }

  ############################
  # MESSAGE METADATA FACT
  ############################
  join: message_metadata_v2 {
    type: left_outer
    sql_on: ${campaign_dim_v2.campaign_id} = ${message_metadata_v2.campaign_id} ;;
    relationship: one_to_many
  }

  ############################
  # EVENT BEHAVIOR FACT
  ############################
  join: events_v2 {
    type: left_outer
    sql_on: ${campaign_dim_v2.campaign_id} = ${events_v2.campaign_id} ;;
    relationship: one_to_many
  }

  ############################
  # USER DIMENSION (SAFE MANY→ONE)
  ############################
  join: user_profile_v2 {
    type: left_outer
    sql_on: ${events_v2.user_id} = ${user_profile_v2.user_id} ;;
    relationship: many_to_one
  }

  ############################
  # PURCHASE FACT (DOWNSTREAM)
  ############################
  join: purchase_transaction_v2 {
    type: left_outer
    sql_on: ${events_v2.user_id} = ${purchase_transaction_v2.user_id} ;;
    relationship: one_to_many
  }


  join: campaign_dim {
    type: left_outer
    sql_on: ${events_v2.campaign_id} = ${campaign_dim_v2.campaign_id} ;;
    relationship: many_to_one
  }


}

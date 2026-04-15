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


explore: user_analytics_v2 {

  from: user_profile_v2


  ###################################
  # EVENTS (User → Events)
  ###################################

  join: events_v2 {
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_analytics_v2.user_id} = ${events_v2.user_id} ;;
  }


  # ####################################
  # # PURCHASES (User → Transactions)
  # ####################################

  join: purchase_transaction_v2 {
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_analytics_v2.user_id} =
      ${purchase_transaction_v2.user_id} ;;
  }


}

explore: campaign_performance_v2 {

  join: campaign_dim_v2 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${campaign_dim_v2.campaign_id} = ${campaign_performance_v2.campaign_id} ;;
  }


}

# explore: message_metadata {}

# explore: campaign_performance {}

# explore: user_profile {}

# explore: behavioral_signals {}

# explore: campaign_dim {}

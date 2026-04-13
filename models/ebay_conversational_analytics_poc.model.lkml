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

# explore: message_metadata {}

# explore: campaign_performance {}

# explore: user_profile {}

# explore: behavioral_signals {}

# explore: campaign_dim {}

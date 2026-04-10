connection: "ebay_test_agents_poc"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: ebay_conversational_analytics_poc_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ebay_conversational_analytics_poc_default_datagroup

explore: message_metadata {}

explore: campaign_performance {}

explore: user_profile {}

explore: behavioral_signals {}

explore: campaign_dim {}


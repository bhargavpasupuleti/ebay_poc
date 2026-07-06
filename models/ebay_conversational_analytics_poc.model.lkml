connection: "ebay_test_agents_poc"

# include all the views
include: "/views/**/*.view.lkml"
include: "/views/old_views/**/*.view.lkml"

datagroup: ebay_conversational_analytics_poc_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ebay_conversational_analytics_poc_default_datagroup


explore: user_segm_dim {
  label: "Aggregated explore for User info + Search + BBOWAC table "
  join : bbowac {
    type: inner
    relationship: one_to_many
    sql_on: ${user_segm_dim.dw_user_id} = ${bbowac.user_id};;
  }
  join:transaction{
    type: inner
    relationship: one_to_many
    sql_on: ${user_segm_dim.dw_user_id} = ${transaction.buyer_id};;
  }
  join : search{
    type: inner
    relationship: one_to_many
    sql_on: ${user_segm_dim.dw_user_id} = ${search.user_id};;
  } }



explore: transaction {
  label: "Transactions data"
  join : user_segm_dim {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${user_segm_dim.dw_user_id} = ${transaction.buyer_id};;
  }
}



explore: bbowac {
  label: "BBOWAC table"
  join: user_segm_dim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${user_segm_dim.dw_user_id} = ${bbowac.user_id};;
  }
}



explore: search {
  label: "User search related data"
  join: user_segm_dim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${user_segm_dim.dw_user_id} = ${search.user_id};;
  }
}

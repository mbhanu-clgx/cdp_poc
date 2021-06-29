connection: "cdg_gcp_bigquery_poc"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: g2_order_reporting {
  sql_always_where: ${consumer_partner_id} in ('FANNIEMAE','FANNIEMAEV2') ;;
}

explore: g2_order_messages_reporting {}
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: dimension_table {
  join: message_table {
    type: inner
    sql_on: ${dimension_table.sla_order_id}=${message_table.sla_order_id} ;;
    relationship: one_to_many
  }
  join: message_table2 {
    type: full_outer
    sql_on: ${dimension_table.sla_order_id}=${message_table2.sla_order_id} ;;
    relationship: one_to_many
  }
}


 explore: CDGDashboard_Dimension_Table {

  join : CDGDashboard_Order_MaxDate {
    type: full_outer
    sql_on: ${CDGDashboard_Dimension_Table.orderId}=${CDGDashboard_Order_MaxDate.order_Id} ;;
    relationship: one_to_many
  }

 }

view: g2_order_messages_reporting {
  sql_table_name: `clgx-das-cdp-glb-dev-a907.looker_lookup.G2OrderMessagesReporting`
    ;;

  dimension: _id {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: manual_retry {
    type: string
    sql: ${TABLE}.manualRetry ;;
  }

  dimension: message_form {
    type: string
    sql: ${TABLE}.messageForm ;;
  }

  dimension: message_state {
    type: string
    sql: ${TABLE}.messageState ;;
  }

  dimension_group: order_creation {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.orderCreationDate ;;
  }

  measure: min_order_date {
    type: date
    sql: min(cast(${TABLE}.orderCreationDate as date)) ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.orderId ;;
  }

  dimension_group: order_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.orderUpdatedDate ;;
  }

  dimension: request_action {
    type: string
    sql: ${TABLE}.requestAction ;;
  }

  dimension: service_type {
    type: string
    sql: ${TABLE}.serviceType ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: g2_order_reporting {
  sql_table_name: `clgx-das-cdp-glb-dev-a907.looker_lookup.G2OrderReporting`
    ;;

  dimension: orderId {
    type: string
    sql: ${TABLE}._id ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: business_line_structure_type {
    type: string
    sql: ${TABLE}.businessLineStructureType ;;
  }

  dimension: business_line_type {
    type: string
    sql: ${TABLE}.businessLineType ;;
  }

  dimension: consumer_partner_id {
    type: string
    sql: ${TABLE}.consumerPartnerId ;;
  }

  dimension: consumer_ref_id {
    type: string
    sql: ${TABLE}.consumerRefId ;;
  }

  dimension: consumer_service_alias {
    type: string
    sql: ${TABLE}.consumerServiceAlias ;;
  }

  dimension: fulfillment_partner_id {
    type: string
    sql: ${TABLE}.fulfillmentPartnerId ;;
  }

  dimension: fulfillment_service_alias {
    type: string
    sql: ${TABLE}.fulfillmentServiceAlias ;;
  }

  dimension: gg_lender_identifier {
    type: string
    sql: ${TABLE}.ggLenderIdentifier ;;
  }

  dimension: line_of_business {
    type: string
    sql: ${TABLE}.lineOfBusiness ;;
  }

  dimension: loan_number {
    type: string
    sql: ${TABLE}.loanNumber ;;
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

  dimension: order_state {
    type: string
    sql: ${TABLE}.orderState ;;
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

  dimension: origination_system_name {
    type: string
    sql: ${TABLE}.originationSystemName ;;
  }

  dimension: pre_flood_client {
    type: string
    sql: ${TABLE}.preFloodClient ;;
  }

  dimension: previous_order_state {
    type: string
    sql: ${TABLE}.previousOrderState ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: service_type {
    type: string
    sql: ${TABLE}.serviceType ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.userId ;;
  }

  measure: count {
    type: count
    drill_fields: [origination_system_name]
  }
}

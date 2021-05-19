view: consumer_partner_mapping {
  sql_table_name: `clgx-das-cdp-glb-dev-a907.looker_lookup.Consumer_Partner_Mapping`
    ;;

  dimension: client {
    type: string
    sql: ${TABLE}.Client ;;
  }

  dimension: consumer_partner {
    type: string
    sql: ${TABLE}.Consumer_partner ;;
  }

  dimension: gg_lender_identifier {
    type: string
    sql: ${TABLE}.ggLenderIdentifier ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

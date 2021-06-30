view: message_table2 {
  derived_table: {
    sql: select Distinct
                orderId as SLA_orderId ,
     source as Source2,
     requestAction as RA2,
     serviceType as ST2,
     messageForm as MF2,
                 min(orderCreationDate) as Created_DateTB02
      FROM  looker_lookup.G2OrderMessagesReporting

   where requestAction= 'Reissue.reply'
   and source = 'CLG2'
   Group by orderId ,
     source ,
     requestAction ,
     serviceType ,
     messageForm
 ;;
  }

  dimension: sla_order_id {
    type: string
    sql: ${TABLE}.SLA_orderId ;;
  }

  dimension: source2 {
    type: string
    sql: ${TABLE}.Source2 ;;
  }

  dimension: ra2 {
    type: string
    sql: ${TABLE}.RA2 ;;
  }

  dimension: st2 {
    type: string
    sql: ${TABLE}.ST2 ;;
  }

  dimension: mf2 {
    type: string
    sql: ${TABLE}.MF2 ;;
  }

  dimension_group: created_date_tb02 {
    type: time
    sql: ${TABLE}.Created_DateTB02 ;;
  }
measure: order_id_count {
  type: number
  sql: count(${sla_order_id}) ;;
}

measure: sla_month_date1 {
  label: "SLA Month Datetime"
  type: date_millisecond
  sql: MIN(${TABLE}.Created_DateTB02) ;;
  convert_tz: no
}
}

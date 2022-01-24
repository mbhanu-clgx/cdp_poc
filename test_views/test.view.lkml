view: test {
derived_table: {
  sql: with message_table1 as ( select distinct
     orderId as SLA_orderId,
     source as Source1,
     requestAction as RA1,
     serviceType as ST1,
     messageForm as MF1,
    -- 'Count_id' as Count_Id ,
     min(orderCreationDate)as SLA_Month_Date,
     max(orderCreationDate)as SLA_Month_Date_max
    -- min(orderCreationDate) as Created_DateTB1
    -- ,
    -- filename() as Fname

      FROM looker_lookup.G2OrderMessagesReporting
   where  requestAction= 'Reissue'
   and source = 'CONSUMER'
   Group by orderId ,
     source ,
     requestAction ,
     serviceType ,
     messageForm)
    ,  message_table2 as (select Distinct
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
     messageForm)
     select message_table1.SLA_orderId asSLA_orderId1,
     message_table1.SLA_Month_Date as Created_DateTB01,
     message_table2.SLA_orderId as SLA_orderId2,
     message_table2.Created_DateTB02 as Created_DateTB02,
     message_table1.SLA_Month_Date_max as sla_max_date,
     sum(case when cast(message_table1.SLA_Month_Date as date)>= cast(date_sub(message_table1.SLA_Month_Date_max,INTERVAL 30 DAY) as date) and cast(message_table1.SLA_Month_Date as date) < cast(current_date as date) then  DATE_DIFF(cast(message_table2.Created_DateTB02 as timestamp),cast(message_table1.SLA_Month_Date as timestamp),millisecond) else Null end) as casefunction,
    count( distinct message_table2.SLA_orderId) as orderidcount

     from message_table1
     full outer join message_table2
     on message_table1.SLA_orderId= message_table2.SLA_orderId
     group by 1,2,3,4,5 ;;
}
  dimension: as_sla_order_id1 {
    type: string
    sql: ${TABLE}.asSLA_orderId1 ;;
  }

  dimension_group: created_date_tb01 {
    type: time
    sql: ${TABLE}.Created_DateTB01 ;;
  }

  dimension: sla_order_id2 {
    type: string
    sql: ${TABLE}.SLA_orderId2 ;;
  }

  dimension_group: created_date_tb02 {
    type: time
    sql: ${TABLE}.Created_DateTB02 ;;
  }

  dimension: casefunction {
    type: number
    sql: ${TABLE}.casefunction ;;
  }

  dimension: orderidcount {
    type: number
    sql: ${TABLE}.orderidcount ;;
  }

  ######Measures
  dimension: sla_date1 {
    type: date_millisecond
    sql: ${TABLE}.Created_DateTB01 ;;
    convert_tz: no
  }
  dimension: sla_date2 {
    type: date_millisecond
    sql: ${TABLE}.Created_DateTB02 ;;
    convert_tz: no
  }
  dimension: sla_datdiff {
    type: number
    sql:DATE_DIFF(cast(${sla_date2} as timestamp),cast(${sla_date1}as timestamp),millisecond);;
  }
  measure: average_response_time {
    type: number
    sql: ${casefunction} ;;
  }
  dimension: casefunction1 {
    type: number
    sql: ${TABLE}.casefunction ;;
  }
}

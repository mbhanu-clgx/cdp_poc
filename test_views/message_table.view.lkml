view: message_table {
  derived_table: {
        sql: select distinct
    orderId as SLA_orderId,
    source as Source1,
    requestAction as RA1,
    serviceType as ST1,
    messageForm as MF1,
    -- 'Count_id' as Count_Id ,
    min(orderCreationDate)as SLA_Month_Date
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
    messageForm
;;
  }
  dimension: sla_order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.SLA_orderId ;;
  }

  dimension: source1 {
    type: string
    sql: ${TABLE}.Source1 ;;
  }

  dimension: ra1 {
    type: string
    sql: ${TABLE}.RA1 ;;
  }

  dimension: st1 {
    type: string
    sql: ${TABLE}.ST1 ;;
  }

  dimension: mf1 {
    type: string
    sql: ${TABLE}.MF1 ;;
  }

  dimension_group: sla_month_date {
    type: time
    sql: ${TABLE}.SLA_Month_Date ;;
    html:{{ rendered_value | '%x%X'}} ;;
  }
  measure: last_updated_date {
    label: "SLA Month Date"
    type: date
    sql: MIN(${TABLE}.SLA_Month_Date) ;;
    convert_tz: no
  }
  measure: sla_month_date1 {
    label: "SLA Month Datetime"
    type: date_millisecond
    sql: MIN(${TABLE}.SLA_Month_Date) ;;
    convert_tz: no
  }
  measure: sla_datediff {
    type: number
    sql: DATE_DIFF(cast(${message_table2.sla_month_date1} as timestamp),cast(${sla_month_date1}as timestamp),millisecond);;
  }



  ########## Variables
 measure: vSLAStartDate {
  # hidden: yes
   type: number
  sql: date_sub(max(${TABLE}.SLA_Month_Date),INTERVAL 30 DAY) ;;
 }
  dimension: vToday{
    hidden: yes
    type: string
    sql:extract( month from current_date)||'/'||extract( day from current_date)||'/'||extract( year from current_date) ;;
  }

  measure:vSLAMonth  {
    hidden: yes
    type: string
    # sql: DATE_TRUNC(date_add(${v_slamonth_max},INTERVAL -23 MONTH),MONTH) ;;
    sql:extract(month from DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH))||'/'||extract(day from DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH))||'/'||extract(year from DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH)) ;;
  }
  ########## Measure created for average
  measure: slamonthdate_max {
    type: date
    sql: max(${TABLE}.SLA_Month_Date) ;;
  }
 measure: vslastart_dateformat {
    type: date
    sql: date_sub(${slamonthdate_max},INTERVAL 30 DAY) ;;
  }

  dimension:vtoday_dateformat  {
    type: date
    sql: current_date ;;
  }

measure: vsla_month_dateformat {
  type: date
  sql: DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH) ;;
}


  measure: response_time {
    type: number
    sql: case when cast(MIN(${TABLE}.SLA_Month_Date) as date)>= cast(${vSLAStartDate} as date) and cast(MIN(${TABLE}.SLA_Month_Date)as date) < cast(${vtoday_dateformat} as date) then ${sla_datediff} else Null end ;;
  }
 measure: order_id_count {
   type: number
  sql: count(${sla_order_id}) ;;
 }
measure: response_time_sum {
  type: number
  sql: sum(${response_time}) ;;
}
  # sum(if((${message_table.sla_datediff})<= 2000,1,0))
  # /count(if(${message_table.last_updated_date}>= ${message_table.vslastart_dateformat} AND ${message_table.last_updated_date} <${message_table.vtoday_dateformat},${order_id_count},0 ))
  # CASE WHEN SLA_Month_Date >= vSLAStartDate AND < vToday THEN
  # SUM ( TIME ( Created_DateTB02-Created_DateTB1)) * 86400000 /count(SLA_orderId)
 ######testing
  dimension: dummy_three {
    case: {
      when: {
        label: "Average Response Time"
        sql: 1=1 ;;
      }
      when: {
        label: "% Within 2000ms"
        sql: 1=1 ;;
      }

    }
  }
}

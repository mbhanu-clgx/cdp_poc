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
  hidden: yes
   type: string
  sql: extract(month from date_sub(max(${TABLE}.SLA_Month_Date),INTERVAL 30 DAY))||'/'||extract(day from date_sub(max(${TABLE}.SLA_Month_Date),INTERVAL 30 DAY))||'/'||extract(year from date_sub(max(${TABLE}.SLA_Month_Date),INTERVAL 30 DAY)) ;;
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
    type: date_time
    sql: current_timestamp ;;
  }

measure: vsla_month_dateformat {
  type: date
  sql: DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH) ;;
}

  measure: response_time {
    type: number
    sql: case when ${last_updated_date}>=${vslastart_dateformat} and ${last_updated_date}<cast(${vtoday_dateformat} as date) then
    1 end;;
  }
  measure: response_time_sum {
    type: number
    sql: case when ${response_time} =1 then sum(${response_time}) end ;;
  }
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

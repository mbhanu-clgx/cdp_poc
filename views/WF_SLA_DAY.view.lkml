view: WF_SLA_DAY {

    derived_table: {



      sql: with message_table1 as ( select distinct
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
         where  requestAction= 'Submit'
         and source = 'CONSUMER' and messageForm = 'ORIGINAL'
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

         where (requestAction= 'Submit.Ack' or requestAction='Submit.Nack')
         and source = 'CLG2' and messageForm = 'TARGET'
         Group by orderId ,
           source ,
           requestAction ,
           serviceType ,
           messageForm)
  ,  Dimension_Table as    ( select  distinct
            _id as SLA_orderId,
            loanNumber as SLA_LoanNumber,
            serviceType as SLA_serviceType,
            address as SLA_address,
            originationSystemName as SLA_originationSystemName,
            consumerPartnerId as consumerPartnerId
              FROM looker_lookup.G2OrderReporting
                Where
                  consumerPartnerId in('WELLSFARGO_VPS')
 and COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
     and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%TST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%LOANID%'
and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'



    )
  ,Aggr_Sub as ( select message_table1.SLA_orderId asSLA_orderId1,
     message_table1.SLA_Month_Date as Created_DateTB01,
     message_table2.SLA_orderId as SLA_orderId2,
     message_table2.Created_DateTB02 as Created_DateTB02,
     case when cast(message_table1.SLA_Month_Date as date)>= cast(date_sub(max(message_table1.SLA_Month_Date),INTERVAL 30 DAY) as date) and cast(message_table1.SLA_Month_Date as date) < cast(current_date as date) then  DATE_DIFF(cast(min(message_table2.Created_DateTB02) as timestamp),cast(min(message_table1.SLA_Month_Date) as timestamp),millisecond) else Null end as casefunction,
        ( case when cast(message_table1.SLA_Month_Date as date)>= cast(date_sub(max(message_table1.SLA_Month_Date),INTERVAL 30 DAY) as date) and cast(message_table1.SLA_Month_Date as date) < cast(current_date as date) then   count(message_table2.SLA_orderId) else 0 end) as Ttl_Request_Messages,

 ( CASE WHEN DATE_DIFF(cast(message_table2.Created_DateTB02 as timestamp),cast(message_table1.SLA_Month_Date as timestamp),millisecond) <= 2000 then 1 else 0 end)  AS Within2000ms,
 ( CASE WHEN DATE_DIFF(cast(message_table2.Created_DateTB02 as timestamp),cast(message_table1.SLA_Month_Date as timestamp),millisecond) <= 5000 then 1 else 0 end)  AS Within5000ms,


    count( distinct message_table2.SLA_orderId) as orderidcount

     from

          message_table2
           full outer join message_table1
           on message_table2.SLA_orderId= message_table1.SLA_orderId

           INNER JOIN dimension_table ON
          dimension_table.SLA_orderId = message_table1.SLA_orderId
           group by 1,2,3,4 )

          select CAST(Created_DateTB01 AS DATE) as SLA_Date ,
          MIN(Created_DateTB01 ) as SLA_Days_Date ,
          SUM( casefunction )/SUM(orderidcount)  as Avg_Resp_Time,
          SUM( Ttl_Request_Messages) AS Total_Request_Messages,
         ( SUM(Within2000ms)/SUM( Ttl_Request_Messages))*100 AS Within2000ms,

          (SUM(Within5000ms)/SUM( Ttl_Request_Messages))*100 AS Within5000ms
          from Aggr_Sub
          group by CAST(Created_DateTB01 AS DATE) ;;

      }
      # dimension: as_sla_order_id1 {
      #   type: string
      #   sql: ${TABLE}.asSLA_orderId1 ;;
      # }

      # dimension_group: created_date_tb01 {
      #   type: time
      #   sql: ${TABLE}.Created_DateTB01 ;;
      # }

      # dimension: sla_order_id2 {
      #   type: string
      #   sql: ${TABLE}.SLA_orderId2 ;;
      # }

      # dimension_group: created_date_tb02 {
      #   type: time
      #   sql: ${TABLE}.Created_DateTB02 ;;
      # }

      dimension_group: SLA_Days_Date {
        type: time
        sql: ${TABLE}.SLA_Days_Date ;;
      }


      # dimension: casefunction {
      #   type: number
      #   sql: ${TABLE}.casefunction ;;
      # }

      dimension: orderidcount {
        type: number
        sql: ${TABLE}.orderidcount ;;
      }

      ######Measures
      # dimension: sla_date1 {
      #   type: date_millisecond
      #   sql: ${TABLE}.Created_DateTB01 ;;
      #   convert_tz: no
      # }
      # dimension: sla_date2 {
      #   type: date_millisecond
      #   sql: ${TABLE}.Created_DateTB02 ;;
      #   convert_tz: no
      # }
      # dimension: sla_datdiff {
      #   type: number
      #   sql:DATE_DIFF(cast(${sla_date2} as timestamp),cast(${sla_date1}as timestamp),millisecond);;
      # }
      # measure: average_response_time {
      #   type: number
      #   sql: sum(${casefunction}) ;;
      # }
      measure: order_count_id {
        type: number
        sql: sum(${orderidcount}) ;;
      }

      # dimension: SLA_Date {
      #   label: "SLA Date"
      #   type: date
      #   sql: ${TABLE}.SLA_Date ;;
      #   convert_tz: no
      # }

      dimension: SLA_Date {
        label: "WF SLA Date Dim"
        type: date
        sql: cast(${TABLE}.SLA_Date as timestamp) ;;
      }

      # measure: vSLAStartDate {
      #   # hidden: yes
      #   type: number
      #   sql: date_sub(max(${TABLE}.SLA_Month_Date),INTERVAL 30 DAY) ;;
      # }

      # dimension:vtoday  {
      #   type: date
      #   sql: current_date ;;
      # }

      # measure: SLA_Month_Date {
      #   label: "SLA Month Date"
      #   type: date
      #   sql: MIN(${TABLE}.SLA_Month_Date) ;;
      #   convert_tz: no
      # }
      # measure: slamonthdate_max {
      #   type: date
      #   sql: max(${TABLE}.SLA_Month_Date) ;;
      # }
      # measure: vslastart_dateformat {
      #   type: date
      #   sql: date_sub(${slamonthdate_max},INTERVAL 30 DAY) ;;
      # }

      # dimension:vtoday_dateformat  {
      #   type: date
      #   sql: current_date ;;
      # }

      # measure: vsla_month_dateformat {
      #   type: date
      #   sql: DATE_TRUNC(date_add(${slamonthdate_max},INTERVAL -23 MONTH),MONTH) ;;
      # }


      measure: Total_Request_Messages {
        type: number
        sql: SUM(${TABLE}.Total_Request_Messages) ;;
      }



      # measure: Within2000ms_TOP {
      #   type: number
      #   sql: sum(${TABLE}.Within2000ms) ;;
      # }

      # measure: Within5000ms_TOP {
      #   type: number
      #   sql: sum(${TABLE}.Within5000ms) ;;
      # }


      # measure: Within2000ms {
      #   type: number
      #   sql: (sum(${TABLE}.Within2000ms)/count(${TABLE}.Ttl_Request_Messages))*100 ;;
      # }


      # measure: Within5000ms {
      #   type: number
      #   sql: (sum(${TABLE}.Within5000ms)/count(${TABLE}.Ttl_Request_Messages))*100 ;;
      # }

      # measure: Average_Response {
      #   type: number
      #   sql: sum(${casefunction})/count(${orderidcount}) ;;
      # }

      measure: Average_Response {
        type: number
        sql: SUM(${TABLE}.Avg_Resp_Time) ;;
      }

      # measure: Within5000ms {
      #   type: number
      #   sql: SUM(${TABLE}.Within5000ms) ;;
      # }

      measure: Within2000ms {
        type: number
        sql: SUM(${TABLE}.Within2000ms) ;;
      }


    }

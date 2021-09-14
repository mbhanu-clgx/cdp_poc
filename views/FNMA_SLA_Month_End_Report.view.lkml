view: FNMA_SLA_Month_End_Report {
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
         where  requestAction= 'Reissue'
         and source = 'CONSUMER'
                and cast(orderCreationDate as date) < DATE_TRUNC( cast( CURRENT_DATE() as date), MONTH)

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
                and cast(orderCreationDate as date) < DATE_TRUNC( cast( CURRENT_DATE() as date), MONTH)

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
                  consumerPartnerId in('FANNIEMAE','FANNIEMAEV2')
                  -- and
                  --( loanNumber  not like '%TEST%'  or loanNumber  not like '%TST%' or loanNumber   not like '%LOANID%' or loanNumber  not like  '%test%' or loanNumber not like '%Test%')
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

          select
FORMAT_DATE("%b %Y", Created_DateTB01 ) as SLA_Month ,
         MIN(Created_DateTB01 ) as SLA_Days_Date ,
          SUM( casefunction )/SUM(orderidcount)  as Avg_Resp_Time,
          SUM( Ttl_Request_Messages) AS Total_Request_Messages,
         ( SUM(Within2000ms)/SUM( Ttl_Request_Messages))*100 AS Within2000ms,

          (SUM(Within5000ms)/SUM( Ttl_Request_Messages))*100 AS Within5000ms
          from Aggr_Sub
          group by FORMAT_DATE("%b %Y", Created_DateTB01 )
        --  ORDER BY FORMAT_DATE("%b %Y", Created_DateTB01 ) DESC
          ;;

    }


    dimension: orderidcount {
      type: number
      sql: ${TABLE}.orderidcount ;;
    }

     measure: order_count_id {
      type: number
      sql: sum(${orderidcount}) ;;
    }


    dimension: SLA_Month {
      label: "FNMA SLA MONTH"
      sql: ${TABLE}.SLA_Month ;;
      description: "used as filter for month"
    }

    dimension_group: sla_days_date {
      type: time
      sql: ${TABLE}.SLA_Days_Date ;;
    }
    measure: Total_Request_Messages {
      type: number
      sql: SUM(${TABLE}.Total_Request_Messages) ;;
    }

    measure: Average_Response_Time{
      type: number
      sql: SUM(${TABLE}.Avg_Resp_Time) ;;
    }

    measure: Within5000ms {
      type: number
      sql: SUM(${TABLE}.Within5000ms) ;;
    }

    measure: Within2000ms {
      type: number
      sql: SUM(${TABLE}.Within2000ms) ;;
    }


  }

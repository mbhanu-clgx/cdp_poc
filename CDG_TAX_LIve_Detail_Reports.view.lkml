view: cdg_tax_live_detail_reports {

  derived_table: {



    sql:  select Tax_live.SLA_orderId , Source1,
    DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) as TAT_Milli_secs,
    ( CASE WHEN DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) >15000 then 'Yes' else 'No' end)  AS  Greater_15_Sec,

            RA1,
            ST1,
            MF1,
          -- 'Count_id' as Count_Id ,
            SLA_Month_Date,

             SLA_LoanNumber,
             SLA_serviceType,
             SLA_address,
             SLA_originationSystemName,
             orderStatus,
             orderUpdatedDate,
             Line_of_Business,
consumerPartnerId,

Source2,
            RA2,
ST2,
MF2,
Flag,
Created_DateTB02,
Created_DateTB1,
TB_1,
Max_orderUpdatedDate
from

( select

      message_table1. SLA_orderId,
      message_table1.Source1,
            message_table1.RA1,
            message_table1.ST1,
            message_table1.MF1,
          -- 'Count_id' as Count_Id ,
            message_table1.SLA_Month_Date,

             SLA_LoanNumber,
             SLA_serviceType,
             SLA_address,
             SLA_originationSystemName,
             orderStatus,
             orderUpdatedDate,
             Line_of_Business,
consumerPartnerId,

message_table2.Source2,
            message_table2.RA2,
message_table2.ST2,
message_table2.MF2,
message_table2.Flag,
Created_DateTB02,
message_table1.Created_DateTB1,

CASE WHEN Created_DateTB02 IS NULL THEN 'T' ELSE 'F' END as TB_1


     from

         (select Distinct
                      orderId as SLA_orderId ,
           source as Source2,
           requestAction as RA2,
           serviceType as ST2,
           messageForm as MF2,
'Yes' as Flag,
                       min(orderCreationDate) as Created_DateTB02
            FROM  looker_lookup.G2OrderMessagesReporting

        where (requestAction= '1999')
         and source = 'FULFILLMENT' and messageForm = 'ORIGINAL'
and serviceType = 'TAXSSOT'
         Group by orderId ,
           source ,
           requestAction ,
           serviceType ,
           messageForm) as  message_table2
           full outer join   ( select distinct
           orderId as SLA_orderId,
           source as Source1,
           requestAction as RA1,
           serviceType as ST1,
           messageForm as MF1,
          -- 'Count_id' as Count_Id ,
           min(orderCreationDate)as SLA_Month_Date,
           min(orderCreationDate) as Created_DateTB1
          -- ,
          -- filename() as Fname

            FROM looker_lookup.G2OrderMessagesReporting
         where  requestAction= 'Submit'
         and source = 'CONSUMER' and messageForm = 'ORIGINAL'
  and serviceType = 'TAXSSOT'
         Group by orderId ,
           source ,
           requestAction ,
           serviceType ,
           messageForm ) message_table1
           on message_table2.SLA_orderId= message_table1.SLA_orderId

           INNER JOIN  ( select  distinct
            _id as SLA_orderId,
            loanNumber as SLA_LoanNumber,
            serviceType as SLA_serviceType,
            address as SLA_address,
            originationSystemName as SLA_originationSystemName,
orderState as orderStatus,
orderUpdatedDate as orderUpdatedDate,

--num(timestamp#(orderUpdatedDate)) as TM,
( CASE WHEN LENGTH(COALESCE(G2OrderReporting.lineOfBusiness,'0')) = 0  AND LENGTH(COALESCE(G2OrderReporting.businessLineType,'0')) = 0 AND LENGTH(COALESCE(G2OrderReporting.businessLineStructureType,'0')) = 0
      THEN
            (
        CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'CORE'
          THEN 'WFHM Retail'

          ELSE  (


          CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'COREP'
                  THEN 'WFHM'
                  ELSE '' END
          ) END

          ) ELSE ( concat( COALESCE(G2OrderReporting.lineOfBusiness,''), "", COALESCE(G2OrderReporting.businessLineType,''), "", COALESCE(G2OrderReporting.businessLineStructureType,'')

                   )  ) END

                   ) AS Line_of_Business,


            consumerPartnerId as consumerPartnerId
              FROM looker_lookup.G2OrderReporting
                Where
                 consumerPartnerId in('WELLSFARGO_VPS', 'ORDERPORTAL')
 and COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
     and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%TST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%LOANID%'
and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'
and serviceType = 'TAXSSOT'


                  )dimension_table ON
          dimension_table.SLA_orderId = message_table1.SLA_orderId  ) Tax_live ,



(
select    SLA_orderId ,
max ( orderUpdatedDate ) as Max_orderUpdatedDate

from
(
select

      message_table1. SLA_orderId,
      message_table1.Source1,
            message_table1.RA1,
            message_table1.ST1,
            message_table1.MF1,
          -- 'Count_id' as Count_Id ,
            message_table1.SLA_Month_Date,

             SLA_LoanNumber,
             SLA_serviceType,
             SLA_address,
             SLA_originationSystemName,
             orderStatus,
             orderUpdatedDate,
             Line_of_Business,
consumerPartnerId,

message_table2.Source2,
            message_table2.RA2,
message_table2.ST2,
message_table2.MF2,
message_table2.Flag,
Created_DateTB02,
message_table1.Created_DateTB1,

CASE WHEN Created_DateTB02 IS NULL THEN 'T' ELSE 'F' END as TB_1


     from

         (select Distinct
                      orderId as SLA_orderId ,
           source as Source2,
           requestAction as RA2,
           serviceType as ST2,
           messageForm as MF2,
'Yes' as Flag,
                       min(orderCreationDate) as Created_DateTB02
            FROM  looker_lookup.G2OrderMessagesReporting

        where (requestAction= '1999')
         and source = 'FULFILLMENT' and messageForm = 'ORIGINAL'
and serviceType = 'TAXSSOT'
         Group by orderId ,
           source ,
           requestAction ,
           serviceType ,
           messageForm) as  message_table2
           full outer join   ( select distinct
           orderId as SLA_orderId,
           source as Source1,
           requestAction as RA1,
           serviceType as ST1,
           messageForm as MF1,
          -- 'Count_id' as Count_Id ,
           min(orderCreationDate)as SLA_Month_Date,
           min(orderCreationDate) as Created_DateTB1
          -- ,
          -- filename() as Fname

            FROM looker_lookup.G2OrderMessagesReporting
         where  requestAction= 'Submit'
         and source = 'CONSUMER' and messageForm = 'ORIGINAL'
  and serviceType = 'TAXSSOT'
         Group by orderId ,
           source ,
           requestAction ,
           serviceType ,
           messageForm ) message_table1
           on message_table2.SLA_orderId= message_table1.SLA_orderId

           INNER JOIN  ( select  distinct
            _id as SLA_orderId,
            loanNumber as SLA_LoanNumber,
            serviceType as SLA_serviceType,
            address as SLA_address,
            originationSystemName as SLA_originationSystemName,
orderState as orderStatus,
orderUpdatedDate as orderUpdatedDate,

--num(timestamp#(orderUpdatedDate)) as TM,
( CASE WHEN LENGTH(COALESCE(G2OrderReporting.lineOfBusiness,'0')) = 0  AND LENGTH(COALESCE(G2OrderReporting.businessLineType,'0')) = 0 AND LENGTH(COALESCE(G2OrderReporting.businessLineStructureType,'0')) = 0
      THEN
            (
        CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'CORE'
          THEN 'WFHM Retail'

          ELSE  (


          CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'COREP'
                  THEN 'WFHM'
                  ELSE '' END
          ) END

          ) ELSE ( concat( COALESCE(G2OrderReporting.lineOfBusiness,''), "", COALESCE(G2OrderReporting.businessLineType,''), "", COALESCE(G2OrderReporting.businessLineStructureType,'')

                   )  ) END

                   ) AS Line_of_Business,


            consumerPartnerId as consumerPartnerId
              FROM looker_lookup.G2OrderReporting
                Where
                 consumerPartnerId in('WELLSFARGO_VPS', 'ORDERPORTAL')
 and COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
     and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%TST%'
 and  COALESCE(upper(loanNumber),'NULL') not like '%LOANID%'
and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'
and serviceType = 'TAXSSOT'


                  )dimension_table ON
          dimension_table.SLA_orderId = message_table1.SLA_orderId )
group by SLA_orderId )  Max_Temp

where Max_Temp.SLA_orderId = tax_live.SLA_orderId and
Max_Temp.Max_orderUpdatedDate = tax_live.orderUpdatedDate

    ;;
    }

  dimension: SLA_LoanNumber {
    label: "LoanNumber"
    type: string
    sql: ${TABLE}.SLA_LoanNumber ;;
  }

  dimension: SLA_orderId {
    label: "Order Id"
    type: string
    sql: ${TABLE}.SLA_orderId ;;
  }

  dimension: Line_of_Business {
    label: "Line of Business"
    type: string
    sql: ${TABLE}.SLA_LoanNumber ;;
  }

  # dimension_group: created_date_test {
  #   type: time
  #   timeframes: [millisecond4]
  #   sql: ${TABLE}.Created_DateTB1 ;;
  #   # sql: datetime(${TABLE}.Created_DateTB1, "America/Los_Angeles") ;;
  #   # sql: convert_tz(${TABLE}.Created_DateTB1,'America/Phoenix','America/Los_Angeles') ;;
  #   convert_tz: no
  # }

    dimension_group: created_date {
      type: time
      timeframes: [millisecond4]
      # sql: ${TABLE}.Created_DateTB1 ;;
      sql: datetime(${TABLE}.Created_DateTB1, "America/Los_Angeles") ;;
      # sql: convert_tz(${TABLE}.Created_DateTB1,'America/Phoenix','America/Los_Angeles') ;;
      convert_tz: yes
    }

    dimension: Created_DateTB1 {
    label: "Created Date"
    type: date_time
    sql: ${TABLE}.Created_DateTB1 ;;
    convert_tz: yes
  }

  dimension_group: fulfillment_date {
    type: time
    timeframes: [millisecond4]
    sql: datetime(${TABLE}.Created_DateTB02, "America/Los_Angeles") ;;
    convert_tz: yes
  }

  dimension: Created_DateTB02 {
    label: "Fulfillment Date"
    type: date_time
    sql: ${TABLE}.Created_DateTB02 ;;
    convert_tz: yes
  }

  dimension: orderStatus {
    label: "Order Status"
    type: string
    sql: ${TABLE}.orderStatus ;;
  }


  dimension: TAT_Milli_secs {
    label: "TAT(Milli Secs)"
    type: number
    sql: ${TABLE}.TAT_Milli_secs ;;
  }


  dimension: TB_1 {
    label: "No 1999"
    type: string
    sql: ${TABLE}.TB_1 ;;
  }

# '15 Sec'

  dimension: Greater_15_Sec {
    label: "15 Sec"
    type: string
    sql: ${TABLE}.Greater_15_Sec ;;
  }




  dimension: orderUpdatedDate {
    label: "TM"
    type: date
    sql: ${TABLE}.orderUpdatedDate ;;
    convert_tz: no
  }

  # # }
  # measure: order_count_id {
  #   type: number
  #   sql:  ${TABLE}.orderidcount ;;
  # }






    }

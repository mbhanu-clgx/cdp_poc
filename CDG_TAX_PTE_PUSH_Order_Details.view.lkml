view: cdg_tax_pte_push_order_details {

  derived_table: {



    sql:

    select
    FORMAT_DATE("%b %Y", Created_DateTB1 ) as SLA_Month,
    Tax_live.SLA_orderId , Source1,
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
    Max_orderUpdatedDate,
    TB_1
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
                FROM  clgx_gateway_archive.G2OrderMessagesReporting

            where (requestAction= '1999')
             and source = 'FULFILLMENT' and messageForm = 'ORIGINAL'
    and serviceType in ( 'TAXPTE', 'TAXSSOT')
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

                FROM clgx_gateway_archive.G2OrderMessagesReporting
             where  requestAction= 'Submit'
             and source = 'CONSUMER' and messageForm = 'ORIGINAL'
      and  serviceType in ( 'TAXPTE', 'TAXSSOT')
             Group by orderId ,
               source ,
               requestAction ,
               serviceType ,
               messageForm) message_table1
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
                  FROM clgx_gateway_archive.G2OrderReporting
                    Where
    --                 consumerPartnerId in('WELLSFARGO_VPS', 'ORDERPORTAL')
    -- and
    COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
         and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'
     and  COALESCE(upper(loanNumber),'NULL') not like '%TST%'
     and  COALESCE(upper(loanNumber),'NULL') not like '%LOANID%'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12083-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12082-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12080-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12081-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12096-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*T2L*'


    and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'
    and serviceType in ( 'TAXPTE', 'TAXSSOT')

     and  COALESCE(upper(ggLenderIdentifier),'NULL') not like '*12083*'

    and fulfillmentServiceAlias in ('TAXPTE_CL_PUSH', 'TAXSSOT_CL_WF','TAXPTE_CL_PUSH_AUTH')
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
                FROM  clgx_gateway_archive.G2OrderMessagesReporting

            where (requestAction= '1999')
             and source = 'FULFILLMENT' and messageForm = 'ORIGINAL'
    and serviceType in ( 'TAXPTE', 'TAXSSOT')
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

                FROM clgx_gateway_archive.G2OrderMessagesReporting
             where  requestAction= 'Submit'
             and source = 'CONSUMER' and messageForm = 'ORIGINAL'
      and  serviceType in ( 'TAXPTE', 'TAXSSOT')
             Group by orderId ,
               source ,
               requestAction ,
               serviceType ,
               messageForm  ) message_table1
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
                  FROM clgx_gateway_archive.G2OrderReporting
                    Where
    --                 consumerPartnerId in('WELLSFARGO_VPS', 'ORDERPORTAL')
    -- and
    COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
         and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'
     and  COALESCE(upper(loanNumber),'NULL') not like '%TST%'
     and  COALESCE(upper(loanNumber),'NULL') not like '%LOANID%'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12083-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12082-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12080-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12081-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*12096-*'

     and  COALESCE(upper(loanNumber),'NULL') not like '*T2L*'


    and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'
    and serviceType in ( 'TAXPTE', 'TAXSSOT')

     and  COALESCE(upper(ggLenderIdentifier),'NULL') not like '*12083*'

    and fulfillmentServiceAlias in ('TAXPTE_CL_PUSH', 'TAXSSOT_CL_WF','TAXPTE_CL_PUSH_AUTH')

                      )dimension_table ON
              dimension_table.SLA_orderId = message_table1.SLA_orderId )
    group by SLA_orderId )  Max_Temp

    where Max_Temp.SLA_orderId = tax_live.SLA_orderId and
    Max_Temp.Max_orderUpdatedDate = tax_live.orderUpdatedDate
        ;;
  }



  dimension: SLA_consumerPartnerId {
    label: "SLA_consumerPartnerId"
    type: string
    sql: ${TABLE}.consumerPartnerId ;;
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

  dimension_group: created_date {
    type: time
    timeframes: [millisecond4]
    sql: ${TABLE}.Created_DateTB1 ;;
    # sql: datetime(cast(${TABLE}.Created_DateTB1 as timestamp), "America/Los_Angeles") ;;
    # convert_tz: yes
  }

  dimension: Created_DateTB1 {
    label: "Created Date"
    type: date
    sql:${TABLE}.Created_DateTB1  ;;
    # sql: TIMESTAMP(date(${TABLE}.Created_DateTB1,"America/Los_Angeles")) ;;
    # convert_tz: no
  }

  dimension_group: fulfillment_date {
    type: time
    timeframes: [millisecond4]
    sql: ${TABLE}.Created_DateTB02 ;;
    # sql: datetime(cast(${TABLE}.Created_DateTB02 as timestamp), "America/Los_Angeles") ;;
    # convert_tz: yes
  }

  dimension: Created_DateTB02 {
    label: "Fulfillment Date"
    type: date
    sql: cast(${TABLE}.Created_DateTB02 as timestamp) ;;
    # convert_tz: no
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
    # convert_tz: no
  }

  dimension: SLA_Month_Date {
    label: "SLA_Month_Date"
    type: date
    sql: ${TABLE}.SLA_Month_Date ;;
    # convert_tz: no
  }




  dimension: SLA_Month {
    label: "SLA_Month"
    sql: ${TABLE}.SLA_Month ;;
    description: "used as filter for month"
  }



}

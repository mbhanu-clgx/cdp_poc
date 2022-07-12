view: cdg_tax_live_Daily {

  derived_table: {



    sql:        select

            --FORMAT_DATE("%b %Y", Created_DateTB1 ) as Tax_Date_Dimension,
            CAST(Created_DateTB1 AS DATE) as Tax_Days_Date ,
            --         MIN(Created_DateTB1 ) as Tax_Days_Date ,
            --Created_DateTB1  as Tax_Days_Date ,
            --          SUM( casefunction )/SUM(orderidcount)  as Avg_Resp_Time,
              --        SUM( Ttl_Request_Messages) AS Total_Request_Messages,
                     ( SUM(LESSTHAN_OR_EQUAL_12_SECS)/SUM( ORDER_COUNT_Div))*100 AS LESSTHAN_OR_EQUAL_12_SECS,

                      (SUM(GREATERTHAN_15_SECS)/SUM( ORDER_COUNT_Div))*100 AS GREATERTHAN_15_SECS,

                      (SUM(BETWEEN_12_15_SECS)/SUM( ORDER_COUNT_Div))*100 AS BETWEEN_12_15_SECS,


            ((SUM(AVG_TIME_IN_SECS )/SUM( AVG_TIME_IN_SECS_Count_Div)))*6000 AS AVG_TIME_IN_SECS ,

            count( ORDER_COUNT_Div ) AS Tax_Order_Count,
            SUM(NO_RESPONSE ) as NO_RESPONSE

            from





            ( select Tax_live.SLA_orderId1 ,
            Tax_live.SLA_orderId2,
             SLA_Month_Date,
            Created_DateTB02,
            Created_DateTB1,

            --    case when cast(SLA_Month_Date as date)>= cast(date_sub(max(SLA_Month_Date),INTERVAL 30 DAY) as date) and cast(SLA_Month_Date as date) < cast(current_date as --date) then  DATE_DIFF(cast(min(Created_DateTB02) as timestamp),cast(min(SLA_Month_Date) as timestamp),millisecond) else Null end as casefunction,

            --Count({<SLA_Month_Date={">=$(=vSLAStartDate)<=$(=vToday) "}, Created_DateTB03={'*'} >}SLA_orderId)

             ( CASE WHEN DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) <= 12000 then 1 else 0 end)  AS LESSTHAN_OR_EQUAL_12_SECS,

             ( CASE WHEN
              ( DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) > 12000 and
                DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) <= 15000 )

             then 1 else 0 end)  AS BETWEEN_12_15_SECS,


             ( CASE WHEN DATE_DIFF(cast(Created_DateTB02 as timestamp),cast(SLA_Month_Date as timestamp),millisecond) > 15000 then 1 else 0 end)  AS  GREATERTHAN_15_SECS,



                case when cast(SLA_Month_Date as date)>= cast(date_sub(max(SLA_Month_Date),INTERVAL 30 DAY) as date) and cast(SLA_Month_Date as date) <= cast(current_date as date) then  DATE_DIFF(cast(min(Created_DateTB02) as timestamp),cast(min(SLA_Month_Date) as timestamp),minute) else Null end as AVG_TIME_IN_SECS ,

                    ( case when cast(SLA_Month_Date as date)>= cast(date_sub(max(SLA_Month_Date),INTERVAL 30 DAY) as date) and cast(SLA_Month_Date as date) <= cast(current_date as date) then   count(SLA_orderId2) else 0 end) as ORDER_COUNT_Div,



              (  case when Created_DateTB02 is  null then 1 else 0 end) as NO_RESPONSE ,

            count(  distinct SLA_orderId2 ) as AVG_TIME_IN_SECS_Count_Div



            --Source1,

            --            RA1,
              --          ST1,
                --        MF1,
                      -- 'Count_id' as Count_Id ,


            --             SLA_LoanNumber,
              --           SLA_serviceType,
                --         SLA_address,
                  --       SLA_originationSystemName,
                    --     orderStatus,
            --             orderUpdatedDate
                      --   Line_of_Business,
            --consumerPartnerId,

            --Source2,
              --          RA2,
            --ST2,
            --MF2,
            --Flag,

            --Max_orderUpdatedDate
            from

            ( select

                  message_table1. SLA_orderId as SLA_orderId1,
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
            message_table2.SLA_orderId as SLA_orderId2,

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

                        FROM clgx_gateway_archive.G2OrderMessagesReporting
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
                          FROM clgx_gateway_archive.G2OrderReporting
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
                        FROM  clgx_gateway_archive.G2OrderMessagesReporting

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

                        FROM clgx_gateway_archive.G2OrderMessagesReporting
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
                          FROM clgx_gateway_archive.G2OrderReporting
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

            where Max_Temp.SLA_orderId = tax_live.SLA_orderId1 and
            Max_Temp.Max_orderUpdatedDate = tax_live.orderUpdatedDate
            group by 1,2,3,4,5  )
            group by --FORMAT_DATE("%b %Y", Created_DateTB1 )
            CAST(Created_DateTB1 AS DATE)
            --order by CAST(Created_DateTB1 AS DATE) asc


                      ;;

    }


    measure: LESSTHAN_OR_EQUAL_12_SECS{
      type: number
      sql: SUM(${TABLE}.LESSTHAN_OR_EQUAL_12_SECS) ;;
    }

    measure: GREATERTHAN_15_SECS {
      type: number
      sql: SUM(${TABLE}.GREATERTHAN_15_SECS) ;;
    }

    measure: BETWEEN_12_15_SECS {
      type: number
      sql: SUM(${TABLE}.BETWEEN_12_15_SECS) ;;
    }


    measure: AVG_TIME_IN_SECS {
      type: number
      sql: SUM(${TABLE}.AVG_TIME_IN_SECS) ;;
    }

    measure: NO_RESPONSE {
      type: number
      sql: SUM(${TABLE}.NO_RESPONSE) ;;
    }

    measure: Tax_Order_Count {
      type: number
      sql: SUM(${TABLE}.Tax_Order_Count);;
    }

    dimension: Tax_Days_Date {
      label: "Tax Date"
      sql: ${TABLE}.Tax_Days_Date ;;
      description: "used as filter for Date"
    }

    # dimension_group: Tax_Days_Date {
    #   type: time
    #   sql: ${TABLE}.Tax_Days_Date ;;
    # }


  }

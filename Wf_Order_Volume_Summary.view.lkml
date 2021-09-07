view: Wf_Order_Volume_Summary_old {

  derived_table: {
    sql:

    with Dimension as
    (select distinct
    _id as orderId,
    loanNumber,
    serviceType,
    address,
     originationSystemName,
    -- G2OrderReporting.lineOfBusiness,
    -- G2OrderReporting.businessLineType,
    -- G2OrderReporting.businessLineStructureType,

    (

    CASE WHEN LENGTH(COALESCE(G2OrderReporting.lineOfBusiness,'0')) = 0  AND LENGTH(COALESCE(G2OrderReporting.businessLineType,'0')) = 0 AND LENGTH(COALESCE(G2OrderReporting.businessLineStructureType,'0')) = 0
           THEN
     ( CASE WHEN G2OrderReporting.serviceType ='FLOOD' AND (G2OrderReporting.originationSystemName) = 'CLG2-OrderCenter'
        THEN 'WF BREF' ELSE

        ( CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'CORE'
              THEN 'WFHM Retail' ELSE (
              CASE WHEN G2OrderReporting.serviceType = 'TAXSSOT' AND (G2OrderReporting.originationSystemName) = 'COREP'
                      THEN 'WFHM' ELSE (

                      CASE WHEN G2OrderReporting.serviceType = 'LSFM' AND (G2OrderReporting.originationSystemName) = 'PFUND'
                    THEN ''
                      ELSE '' END

                      ) END
     ) END ) END

     ) ELSE
     concat( COALESCE(G2OrderReporting.lineOfBusiness,''), "", COALESCE(G2OrderReporting.businessLineType,''), "", COALESCE(G2OrderReporting.businessLineStructureType,'')    ) END ) as lineOfBusiness

    FROM looker_lookup.G2OrderReporting

    Where
    COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
    AND
    COALESCE(upper(loanNumber),'NULL') not like '%TEST%' and COALESCE(loanNumber,'NULL') not like '%TST%' and COALESCE(loanNumber,'NULL') not like '%LOANID%'
    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%' and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'
    and consumerPartnerId in ( 'WELLSFARGO_VPS','ORDERPORTAL')

    --and _id = 'CLGGP18433958'
     )  ,

     Order_Table as(

    select A.OrderId,A.consumerPartnerId, A.Source, A.requestAction, A.Updated_date,A.Month_Date, A.Measure , A.completed_status
    , A.Created_Status
    from

    (

      select

         orderId,
        "" as consumerPartnerId,
         source,

          requestAction,

          min(  cast(orderUpdatedDate as timestamp) ) as Updated_date,

          date(min(orderUpdatedDate)) as Month_Date,

               "Completed" as Measure,
               "1" as completed_status,
               "" as Created_Status
          FROM  looker_lookup.G2OrderMessagesReporting
      Where source = "FULFILLMENT" and requestAction = "1999"
      -- and orderId = "CLGGP20232758"
        Group by orderId, source,requestAction

    union all


    select
          _id as orderId,
          consumerPartnerId,
          "" as source,
          "" as requestAction,

    "1111-11-11" as Updated_date,
            (date(min(orderCreationDate))) as Month_Date,

                "Created" as Measure,
                "" as completed_status,
        "1" as Created_Status

      FROM looker_lookup.G2OrderReporting

    where consumerPartnerId in ( "WELLSFARGO_VPS","ORDERPORTAL")

      and COALESCE(originationSystemName,"NULL") != "myLoanOriginationSystemName"  and

      COALESCE(upper(loanNumber),'NULL') not like '%TEST%' and COALESCE(loanNumber,'NULL') not like '%TST%' and COALESCE(loanNumber,'NULL') not like '%LOANID%'
    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%' and COALESCE(address,'NULL')  not like '108 Sandburg%'
     --and  _id = 'CLGGP20232758'

      Group by _id,consumerPartnerId
      ) A
      order by  A.OrderId asc,A.Updated_date desc,A.Month_Date desc
    ),

    Agg_Daily as (Select

    D.lineOfBusiness,
    D.originationSystemName,


        D.orderId,
    --D.loanNumber,
    D.serviceType,
    --D.address,
    --O.consumerPartnerId,
    --O.Source,
    --O.requestAction,
    --O.Updated_date,
    O.Month_Date,
    O.Measure
    ,
    -- O.completed_status,
    -- O.Created_Status,


    ( case when cast(O.Month_Date as date)>= DATE_TRUNC(cast(date_sub(max(O.Month_Date),INTERVAL 1 DAY) as date) , MONTH)
    and cast(O.Month_Date as date) < cast(current_date as date) then   count(D.orderId) else 0 end)  as Day_Total_Count


    --  case when cast(O.Month_Date as date)>= cast(
    -- DATE_ADD(date,1,EOMONTH(date_sub(max(O.Month_Date),INTERVAL 1 DAY),-1)) as date) and cast(O.Month_Date as date) < cast(current_date as date) then   count(D.orderId) else 0 end) as Total_Count
    --( case when cast(O.Month_Date as date)>= cast(date_sub(max(O.Month_Date),INTERVAL 1 DAY) as date) and cast(O.Month_Date as date) < cast(current_date as date) then   count(D.orderId) else 0 end) as Total_Count,
        From Dimension D
        full outer join Order_Table O
        on D.orderId = O.orderId
    Group by
        D.orderId,
    --D.loanNumber,
    D.serviceType,
    --D.address,
    --O.consumerPartnerId,
    -- O.Source,
    -- O.requestAction,
    --O.Updated_date,
    O.Month_Date,
    O.Measure ,
    -- O.completed_status,
    -- O.Created_Status,
    D.lineOfBusiness,
    D.originationSystemName)

    Select
    FORMAT_DATE("%b %Y", Month_Date ) as WF_Order_Month ,
    lineOfBusiness,
    originationSystemName,
    serviceType,
    Month_Date,
    Measure,
    SUM( Day_Total_Count ) as Day_Total_Count
    from Agg_Daily
    where ( lineOfBusiness is not null and originationSystemName is not null and serviceType is not null)

    group by
    lineOfBusiness,
    originationSystemName,
    serviceType,
    Month_Date,
    Measure,
    FORMAT_DATE("%b %Y", Month_Date )
    --HAVING SUM( Day_Total_Count ) <> 0
            ;;


    }

    # dimension: orderId {
    #   type: string
    #   sql: ${TABLE}.orderId ;;
    # }

    # dimension: loanNumber {
    #   type: string
    #   sql: ${TABLE}.loanNumber ;;
    # }

    dimension: Product_Type {
      type: string
      sql: ${TABLE}.serviceType ;;
    }

    # dimension: address {
    #   type: string
    #   sql: ${TABLE}.address ;;
    # }

    # dimension: consumerPartnerId {
    #   type: string
    #   sql: ${TABLE}.consumerPartnerId ;;
    # }

    # dimension: Source {
    #   type: string
    #   sql: ${TABLE}.Source ;;
    # }

    # dimension: requestAction {
    #   type: string
    #   sql: ${TABLE}.requestAction ;;
    # }

    # dimension: Updated_date {
    #   type: date
    #   sql: ${TABLE}.Updated_date ;;
    # }


    dimension_group: Order_Month_Dimension {
      type: time
      sql: ${TABLE}.Month_Date ;;
    }

    dimension: Order_Month_Date {
      type: date

      sql:cast(${TABLE}.Month_Date as timestamp) ;;
    }

    dimension: Measure {
      type: string
      sql: ${TABLE}.Measure ;;
    }



    dimension: Line_Of_Business {
      type: string
      sql: ${TABLE}.LineOfBusiness ;;
    }

    dimension: System_Of_Origin {
      type: string
      sql: ${TABLE}.originationSystemName ;;
    }

    measure: Total_Order_Count{
      type: sum
      sql: ${TABLE}.Day_Total_Count ;;
    }




    dimension: WF_Order_Month {
      label: "WF Order MONTH"
      sql: ${TABLE}.WF_Order_Month ;;
      description: "Used as filter for Month"
    }





  }

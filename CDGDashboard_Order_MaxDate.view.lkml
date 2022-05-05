view: CDGDashboard_Order_MaxDate {
  derived_table: {
    sql:

    with Temp As ( select
    --Autonumber(Key) as OU_Key;
          _id as orderId_Temp,
          consumerPartnerId as CPID2,
    Max(orderUpdatedDate) as Order_Upd_DT

    FROM looker_lookup.G2OrderReporting

    Where  COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
    and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%' and COALESCE(loanNumber,'NULL') not like '%TST%' and COALESCE(loanNumber,'NULL') not like '%LOANID%'
    and COALESCE(loanNumber,'NULL') not like '%12083-%' and COALESCE(loanNumber,'NULL') not like '%12082-%' and COALESCE(loanNumber,'NULL') not like '%12080-%' and
    COALESCE(loanNumber,'NULL') not like '%12081-%' and COALESCE(loanNumber,'NULL') not like '%12096-%' and COALESCE(loanNumber,'NULL') not like '%T2L%'

    and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'
    and COALESCE(upper(serviceType),'NULL')  not like '%FLOODAUTOHIT%'
    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'

    and COALESCE(ggLenderIdentifier,'NULL') not like '%12083%' and COALESCE(ggLenderIdentifier,'NULL') not like '%12082%'  and
     COALESCE(ggLenderIdentifier,'NULL')   not like '%12081%'

    and COALESCE(consumerPartnerId,'NULL') not like  '%LOSJSON%' and COALESCE(consumerPartnerId,'NULL') not like '%LOSJSON_PUSH%'
    and COALESCE(consumerPartnerId,'NULL') not like '%LOSM34%'
    Group by _id,consumerPartnerId
    ) ,


     Max_Update As (select distinct
         _id as OrderId_MaxUpdate,
          consumerPartnerId as CPID1,
          orderState,
           date(min(orderCreationDate)) as Month_Date,
    min(orderCreationDate) as OrderCreationDate,
          max(orderUpdatedDate) as orderUpdatedDate,

        max(  cast(orderUpdatedDate as timestamp) ) as UpDate,

    -- Date(num(max(timestamp#(orderUpdatedDate,'YYYY-MM-DDThh:mm:ss.fffK'))),'YYYY-MM-DD hh:mm:ss.fff') as UpDate,
    row_number() OVER(ORDER BY _id)  as Order_Key

     --,row_number() OVER(ORDER BY ( max(orderUpdatedDate) '-' _id )) as OU_Key

    FROM looker_lookup.G2OrderReporting

    Where
    COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
    and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%' and COALESCE(loanNumber,'NULL') not like '%TST%' and COALESCE(loanNumber,'NULL') not like '%LOANID%'
    and COALESCE(loanNumber,'NULL') not like '%12083-%' and COALESCE(loanNumber,'NULL') not like '%12082-%' and COALESCE(loanNumber,'NULL') not like '%12080-%' and
    COALESCE(loanNumber,'NULL') not like '%12081-%' and COALESCE(loanNumber,'NULL') not like '%12096-%' and COALESCE(loanNumber,'NULL') not like '%T2L%'
    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'
    and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'
    and COALESCE(upper(serviceType),'NULL')  not like '%FLOODAUTOHIT%'

    and COALESCE(ggLenderIdentifier,'NULL') not like '%12083%' and COALESCE(ggLenderIdentifier,'NULL') not like '%12082%'  and
     COALESCE(ggLenderIdentifier,'NULL')   not like '%12081%'

    and COALESCE(consumerPartnerId,'NULL') not like  '%LOSJSON%' and COALESCE(consumerPartnerId,'NULL') not like '%LOSJSON_PUSH%'
    and COALESCE(consumerPartnerId,'NULL') not like '%LOSM34%'

    Group by _id,consumerPartnerId,orderState )

     Select


          U.orderState,
          U.Month_Date,
          U.OrderCreationDate,
           U.orderUpdatedDate as Order_Update_DT,
    U.CPID1 as consumerPartnerId,
    T.orderId_Temp as order_Id

    From Temp T, Max_Update U

    where
    T.orderId_Temp = U.OrderId_MaxUpdate
    AND T.Order_Upd_DT = U.orderUpdatedDate
    ;;
  }

  dimension: orderState {
    type: string
    sql: ${TABLE}.orderState ;;
  }

  dimension: consumerPartnerId {
    type: string
    sql: ${TABLE}.consumerPartnerId ;;
  }

  dimension: order_Id {
    type: string
    sql: ${TABLE}.order_Id ;;
  }

  dimension_group: Month_Date {
    type: time
    sql: cast(${TABLE}.Month_Date as timestamp) ;;
  }

  dimension: Order_Created_Date {
    type: date
    sql: ${TABLE}.OrderCreationDate ;;
  }

  dimension_group: Order_Created_Date {
    type: time
    timeframes: [date,millisecond4]
    sql: datetime(${TABLE}.OrderCreationDate, "America/Los_Angeles") ;;
  }

  dimension: Order_Update_DT {
    type: date
    sql: ${TABLE}.Order_Update_DT ;;
  }

  measure: Order_Total {
    type: count_distinct
    sql: ${TABLE}.order_Id ;;
  }

  measure: Month_Date_Count {
    type: number
    sql: COUNT(${TABLE}.Month_Date) ;;
  }

  dimension: CDG_Details {
    type: string
    sql: "CDG_Details" ;;
    html: <font size=5><b>CDG Details</b></font> ;;
  }


  dimension: CDG_Summary {
    type: string
    sql: "CDG_Summary" ;;
    html: <font size=5><b>CDG Summary</b></font> ;;
  }


  dimension: CDG_Summary_link {
    type: string
    sql: "CDG_Summary" ;;
    html: <a href="./2333"><u><font size=5>CDG Summary</font></u></a> ;;
  }

  dimension: CDG_Details_link {
    type: string
    sql: "CDG_Details" ;;
    html: <a href="./2331"><u><font size=5>CDG Details</font></u></a> ;;
  }

}

view: CDGDashboard_Dimension_Table {
  derived_table: {
    sql:

    Select
    A.Order_Key as Order_Key,
    A.orderId as OrderId,
    A.loanNumber as LoanNumber,

    A.fulfillmentServiceAlias as FulfillmentServiceAlias,
    A.originationSystemName  as OriginationSystemName,
    A.serviceType_Exist as serviceType_Exist,
    A.preFloodClient as preFloodClient,
    A.consumerPartnerId_Exist as consumerPartnerId_Exist,
    A.ggLenderIdentifier_Exist as ggLenderIdentifier_Exist,
    A.serviceType as serviceType,
    A.ggLenderIdentifier as ggLenderIdentifier,
    A.consumerPartnerId as consumerPartnerId,

    case when A.ggLenderIdentifier = CDG_Clients_v4.ggLenderIdentifier then CDG_Clients_v4.Client
    ELSE A.ggLenderIdentifier END AS End_Client,

    case when A.ggLenderIdentifier = Consumer_Partner_Mapping.ggLenderIdentifier then Consumer_Partner_Mapping.Consumer_partner ELSE
    A.consumerPartnerId END AS End_Client_Consumer_partner,

    CDG_Clients_v4.ggLenderIdentifier as CDG_Clients_v4_ggLenderIdentifier ,
    A.ggLenderIdentifier as A_ggLenderIdentifier,
    Consumer_Partner_Mapping.ggLenderIdentifier as Consumer_Partner_Mapping_ggLenderIdentifier

    from

    (
    select
    row_number() OVER(ORDER BY _id) as Order_Key,
    -- row_number(_id) as Order_Key,
    _id as orderId,
    loanNumber,

    fulfillmentServiceAlias,
    originationSystemName ,
    _id,
    serviceType as serviceType_Exist,
    preFloodClient,
    G2OrderReporting.consumerPartnerId as consumerPartnerId_Exist,
    G2OrderReporting.ggLenderIdentifier as ggLenderIdentifier_Exist,

    ( CASE WHEN fulfillmentServiceAlias IN ( 'VOI_BPV_FANNIEMAE','VOI_V2_BPV_FANNIEMAE') THEN '4506-T_Reissue'  ELSE

       ( CASE WHEN serviceType = 'VOI' THEN '4506-T' ELSE  ( CASE WHEN serviceType = 'TAXSSOT' THEN 'TAXPTE' ELSE ( CASE WHEN preFloodClient = 'Y'
     THEN 'PTEPLUSFLOOD' ELSE ( CASE WHEN serviceType IN ( 'LSFM' , 'LSFMCDE' ) THEN  'LSFM'  ELSE serviceType END)
      END )  END       ) END ) END )   AS serviceType,

    ( CASE WHEN fulfillmentServiceAlias IN ( 'VOI_BPV_FANNIEMAE','VOI_V2_BPV_FANNIEMAE') THEN 'FANNIEMAE'  ELSE


    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'WELLSFARGO_VPS'  THEN 'WELLSFARGO'  ELSE (

    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'ORDERPORTAL'  THEN 'WELLSFARGO'  ELSE (


    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'NETWORKCAPITAL' THEN 'Network Capital Funding'  ELSE (


    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'VETERANS_UNITED' THEN 'Veterans United'  ELSE (

    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'BYTE' THEN 'BYTE'  ELSE (

    ( CASE WHEN G2OrderReporting.consumerPartnerId IN ( 'FREDDIE','FREDDIEMAC' )  THEN 'FREDDIE MAC'  ELSE (

    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'EAGLEHOMEMORTGAGE'  THEN 'LENNAR MORTGAGE'  ELSE (

    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'WORKFLOW'  THEN 'EQUIFAX_TWN'  ELSE (

    ( CASE WHEN  ( serviceType = 'CHASETITLE' and G2OrderReporting.consumerPartnerId = 'FNC_CMS' and fulfillmentServiceAlias ='CHASETITLE_FNC_PULL')
    THEN 'GG000471'  ELSE (
    ( CASE WHEN  LENGTH(COALESCE(G2OrderReporting.ggLenderIdentifier,'0')) <=1 THEN G2OrderReporting.consumerPartnerId  ELSE G2OrderReporting.ggLenderIdentifier END )

    ) END )

    ) END )


    ) END )


    ) END )


    ) END )



    ) END )

    ) END )


    ) END )

    ) END ) END ) AS ggLenderIdentifier

    ,




    ( CASE WHEN G2OrderReporting.consumerPartnerId = 'CORELOGICTAXUI' THEN 'PORTAL'  ELSE (

    CASE WHEN G2OrderReporting.consumerPartnerId IN ( 'FANNIEMAE','FANNIEMAEV2')  THEN 'FANNIEMAE'  ELSE (

    CASE WHEN G2OrderReporting.consumerPartnerId IN ( 'FREDDIE','FREDDIEMAC')  THEN 'FREDDIE MAC'  ELSE (

    CASE WHEN G2OrderReporting.consumerPartnerId = 'EAGLEHOMEMORTGAGE'  THEN 'LENNAR MORTGAGE'  ELSE (

    CASE WHEN G2OrderReporting.consumerPartnerId = 'WORKFLOW'  THEN 'EQUIFAX_TWN'  ELSE (G2OrderReporting.consumerPartnerId) END

    ) END

    ) END

    ) END


    ) END ) as consumerPartnerId




    FROM G2OrderReporting


    WHERE

     COALESCE(originationSystemName,'NULL') != 'myLoanOriginationSystemName'
    and  COALESCE(upper(loanNumber),'NULL') not like '%TEST%'

    and  COALESCE(loanNumber,'NULL') not like '%TEST%' and COALESCE(loanNumber,'NULL') not like '%TST%' and COALESCE(loanNumber,'NULL') not like '%LOANID%'
    and COALESCE(loanNumber,'NULL') not like '%12083-%' and COALESCE(loanNumber,'NULL') not like '%12082-%' and COALESCE(loanNumber,'NULL') not like '%12080-%' and
    COALESCE(loanNumber,'NULL') not like '%12081-%' and COALESCE(loanNumber,'NULL') not like '%12096-%' and COALESCE(loanNumber,'NULL') not like '%T2L%'

    and COALESCE(address,'NULL')  not like '108 Sandburg%' and COALESCE(address,'NULL') not like '123 Main St%'

    and COALESCE(upper(address),'NULL') not like '123 MAIN ST%'

    and COALESCE(upper(serviceType),'NULL')  not like '%FLOODAUTOHIT%'

    and COALESCE(G2OrderReporting.ggLenderIdentifier,'NULL') not like '%12083%' and COALESCE(G2OrderReporting.ggLenderIdentifier,'NULL') not like '%12082%'  and
     COALESCE(G2OrderReporting.ggLenderIdentifier,'NULL')   not like '%12081%'

    and COALESCE(G2OrderReporting.consumerPartnerId,'NULL') not like  '%LOSJSON%' and COALESCE(G2OrderReporting.consumerPartnerId,'NULL') not like '%LOSJSON_PUSH%'
    and COALESCE(G2OrderReporting.consumerPartnerId,'NULL') not like '%LOSM34%' ) A

    left join
    CDG_Clients_v4 on A.ggLenderIdentifier = CDG_Clients_v4.ggLenderIdentifier


    left join
    Consumer_Partner_Mapping on A.ggLenderIdentifier = Consumer_Partner_Mapping.ggLenderIdentifier

    ;;
  }

  dimension: serviceType {
    type: string
    sql: ${TABLE}.serviceType ;;
  }

  dimension: ggLenderIdentifier {
    type: string
    sql: ${TABLE}.ggLenderIdentifier ;;
  }

  dimension: consumerPartnerId {
    type: string
    sql: ${TABLE}.consumerPartnerId ;;
  }

  dimension: End_Client {
    type: string
    sql: ${TABLE}.End_Client ;;
  }

  dimension: End_Client_Consumer_partner {
    type: string
    sql: ${TABLE}.End_Client_Consumer_partner ;;
  }

  dimension: Order_Key {
    type: string
    sql: ${TABLE}.Order_Key ;;
  }

  dimension: orderId {
    type: string
    sql: ${TABLE}.orderId ;;
  }
  dimension: loanNumber {
    type: string
    sql: ${TABLE}.loanNumber ;;
  }

  dimension: fulfillmentServiceAlias {
    type: string
    sql: ${TABLE}.fulfillmentServiceAlias ;;
  }

  dimension: originationSystemName {
    type: string
    sql: ${TABLE}.originationSystemName ;;
  }

  dimension: Original_serviceType {
    type: string
    sql: ${TABLE}.serviceType_Exist ;;
  }

  dimension: preFloodClient {
    type: string
    sql: ${TABLE}.preFloodClient ;;
  }

  dimension: Original_consumerPartnerId {
    type: string
    sql: ${TABLE}.consumerPartnerId_Exist ;;
  }

  dimension: Original_ggLenderIdentifier {
    type: string
    sql: ${TABLE}.ggLenderIdentifier_Exist ;;
  }

  measure: Order_Total {
    type: count_distinct
    sql: ${TABLE}.orderId;;
  }



}

# and if(wildmatch(orderCreationDate,'2018-09-21*','2018-09-20*','2018-09-19*') and consumerPartnerId='CLOSINGCORP',False(),True())

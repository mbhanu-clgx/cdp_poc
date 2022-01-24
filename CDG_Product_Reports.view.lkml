view: cdg_product_reports {

  derived_table: {



    sql:

    select
FORMAT_DATE("%b %Y", Month_Date ) as Order_Month ,
--lineOfBusiness,
--originationSystemName,
Product_Integration,
Client,
End_Client,
Month_Date,
--Measure,
SUM( Total_Count ) as Total_Count


from (

Select

D.serviceType as Product_Integration,
D.consumerPartnerId as Client,
D.Client as End_Client,
cast(D.Month_Date as date) as Month_Date,
 ( case when cast(D.Month_Date as date)>= cast(date_sub(max(D.Month_Date),INTERVAL 30 DAY) as date) and cast(D.Month_Date as date) < cast(current_date as date) then   count(D.orderId) else 0 end) as Total_Count



From

(
Select
--A.Order_Key as Order_Key,
A.orderId as OrderId,
A.loanNumber as LoanNumber,

-- A.fulfillmentServiceAlias as FulfillmentServiceAlias,
A.originationSystemName  as OriginationSystemName,
-- A.serviceType_Exist as serviceType_Exist,
-- A.preFloodClient as preFloodClient,
-- A.consumerPartnerId_Exist as consumerPartnerId_Exist,
-- A.ggLenderIdentifier_Exist as ggLenderIdentifier_Exist,
A.serviceType as serviceType,
A.ggLenderIdentifier as ggLenderIdentifier,
A.consumerPartnerId as consumerPartnerId,
A.Month_Date,
A.Updated_Date,
--A.serviceType,

case when A.ggLenderIdentifier = CDG_Clients_v4.ggLenderIdentifier then CDG_Clients_v4.Client
ELSE A.ggLenderIdentifier END AS Client

-- case when A.ggLenderIdentifier = Consumer_Partner_Mapping.ggLenderIdentifier then Consumer_Partner_Mapping.Consumer_partner ELSE
-- A.consumerPartnerId END AS End_Client_Consumer_partner,

-- CDG_Clients_v4.ggLenderIdentifier as CDG_Clients_v4_ggLenderIdentifier ,
-- A.ggLenderIdentifier as A_ggLenderIdentifier,
-- Consumer_Partner_Mapping.ggLenderIdentifier as Consumer_Partner_Mapping_ggLenderIdentifier

from


( select
--row_number() OVER(ORDER BY _id) as Order_Key,
-- row_number(_id) as Order_Key,
_id as orderId,
loanNumber,

CASE WHEN serviceType = 'VOI' THEN  '4506-T' ELSE (

CASE WHEN serviceType = 'TAXSSOT' THEN  'TAXPTE' ELSE (

CASE WHEN preFloodClient = 'Y' THEN  'PTEPLUSFLOOD' ELSE serviceType END

) END

) END AS  serviceType,

--fulfillmentServiceAlias,
--originationSystemName ,
--_id,
--serviceType as serviceType_Exist,
--preFloodClient,
--G2OrderReporting.consumerPartnerId as consumerPartnerId_Exist,
--G2OrderReporting.ggLenderIdentifier as ggLenderIdentifier_Exist,

-- ( CASE WHEN fulfillmentServiceAlias IN ( 'VOI_BPV_FANNIEMAE','VOI_V2_BPV_FANNIEMAE') THEN '4506-T_Reissue'  ELSE

--   ( CASE WHEN serviceType = 'VOI' THEN '4506-T' ELSE  ( CASE WHEN serviceType = 'TAXSSOT' THEN 'TAXPTE' ELSE ( CASE WHEN preFloodClient = 'Y'
-- THEN 'PTEPLUSFLOOD' ELSE ( CASE WHEN serviceType IN ( 'LSFM' , 'LSFMCDE' ) THEN  'LSFM'  ELSE serviceType END)
--   END )  END       ) END ) END )   AS serviceType,



CASE WHEN G2OrderReporting.consumerPartnerId =  'FANNIEMAE'
      THEN 'FANNIEMAE' ELSE (

            CASE WHEN G2OrderReporting.consumerPartnerId =  'WELLSFARGO_VPS'
              THEN 'WELLSFARGO' ELSE (
                     CASE WHEN G2OrderReporting.consumerPartnerId =  'ORDERPORTAL'
                      THEN 'WELLSFARGO' ELSE (
                        CASE WHEN G2OrderReporting.consumerPartnerId =  'CORELOGICTAXUI'
                      THEN 'TAXUIBATCH' ELSE (

                      CASE WHEN G2OrderReporting.consumerPartnerId =  'NETWORKCAPITAL'
                      THEN 'Network Capital Funding' ELSE (

                      CASE WHEN G2OrderReporting.consumerPartnerId =  'VETERANS_UNITED'
                      THEN 'Veterans United' ELSE (

                       CASE WHEN G2OrderReporting.consumerPartnerId =  'BYTE'
                      THEN 'BYTE' ELSE ggLenderIdentifier END

                      ) END




                      ) END

                      ) END

                      ) END




                              ) END


                            ) END AS ggLenderIdentifier,

originationSystemName,
orderCreationDate as Month_Date,
orderUpdatedDate as Updated_Date,
consumerPartnerId
,
FROM looker_lookup.G2OrderReporting

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
CDG_Clients_v4 on A.ggLenderIdentifier = CDG_Clients_v4.ggLenderIdentifier )  D ,


(


SELECT
      orderId as orderId,
      originationSystemName,
      MAX(Updated_Date) AS TEP_Updated_Date

FROM (

Select
--A.Order_Key as Order_Key,
A.orderId as OrderId,
A.loanNumber as LoanNumber,

-- A.fulfillmentServiceAlias as FulfillmentServiceAlias,
A.originationSystemName  as OriginationSystemName,
-- A.serviceType_Exist as serviceType_Exist,
-- A.preFloodClient as preFloodClient,
-- A.consumerPartnerId_Exist as consumerPartnerId_Exist,
-- A.ggLenderIdentifier_Exist as ggLenderIdentifier_Exist,
A.serviceType as serviceType,
A.ggLenderIdentifier as ggLenderIdentifier,
A.consumerPartnerId as consumerPartnerId,
A.Month_Date,
A.Updated_Date,
--A.serviceType,





case when A.ggLenderIdentifier = CDG_Clients_v4.ggLenderIdentifier then CDG_Clients_v4.Client
ELSE A.ggLenderIdentifier END AS Client

-- case when A.ggLenderIdentifier = Consumer_Partner_Mapping.ggLenderIdentifier then Consumer_Partner_Mapping.Consumer_partner ELSE
-- A.consumerPartnerId END AS End_Client_Consumer_partner,

-- CDG_Clients_v4.ggLenderIdentifier as CDG_Clients_v4_ggLenderIdentifier ,
-- A.ggLenderIdentifier as A_ggLenderIdentifier,
-- Consumer_Partner_Mapping.ggLenderIdentifier as Consumer_Partner_Mapping_ggLenderIdentifier

from


( select
--row_number() OVER(ORDER BY _id) as Order_Key,
-- row_number(_id) as Order_Key,
_id as orderId,
loanNumber,

CASE WHEN serviceType = 'VOI' THEN  '4506-T' ELSE (

CASE WHEN serviceType = 'TAXSSOT' THEN  'TAXPTE' ELSE (

CASE WHEN preFloodClient = 'Y' THEN  'PTEPLUSFLOOD' ELSE serviceType END

) END

) END AS  serviceType,

--fulfillmentServiceAlias,
--originationSystemName ,
--_id,
--serviceType as serviceType_Exist,
--preFloodClient,
--G2OrderReporting.consumerPartnerId as consumerPartnerId_Exist,
--G2OrderReporting.ggLenderIdentifier as ggLenderIdentifier_Exist,

-- ( CASE WHEN fulfillmentServiceAlias IN ( 'VOI_BPV_FANNIEMAE','VOI_V2_BPV_FANNIEMAE') THEN '4506-T_Reissue'  ELSE

--   ( CASE WHEN serviceType = 'VOI' THEN '4506-T' ELSE  ( CASE WHEN serviceType = 'TAXSSOT' THEN 'TAXPTE' ELSE ( CASE WHEN preFloodClient = 'Y'
-- THEN 'PTEPLUSFLOOD' ELSE ( CASE WHEN serviceType IN ( 'LSFM' , 'LSFMCDE' ) THEN  'LSFM'  ELSE serviceType END)
--   END )  END       ) END ) END )   AS serviceType,



CASE WHEN G2OrderReporting.consumerPartnerId =  'FANNIEMAE'
      THEN 'FANNIEMAE' ELSE (

            CASE WHEN G2OrderReporting.consumerPartnerId =  'WELLSFARGO_VPS'
              THEN 'WELLSFARGO' ELSE (
                     CASE WHEN G2OrderReporting.consumerPartnerId =  'ORDERPORTAL'
                      THEN 'WELLSFARGO' ELSE (
                        CASE WHEN G2OrderReporting.consumerPartnerId =  'CORELOGICTAXUI'
                      THEN 'TAXUIBATCH' ELSE (

                      CASE WHEN G2OrderReporting.consumerPartnerId =  'NETWORKCAPITAL'
                      THEN 'Network Capital Funding' ELSE (

                      CASE WHEN G2OrderReporting.consumerPartnerId =  'VETERANS_UNITED'
                      THEN 'Veterans United' ELSE (

                       CASE WHEN G2OrderReporting.consumerPartnerId =  'BYTE'
                      THEN 'BYTE' ELSE ggLenderIdentifier END

                      ) END




                      ) END

                      ) END

                      ) END




                              ) END


                            ) END AS ggLenderIdentifier,

originationSystemName,
orderCreationDate as Month_Date,
orderUpdatedDate as Updated_Date,
consumerPartnerId
,
FROM looker_lookup.G2OrderReporting

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




 ) Temp
group by Temp.orderId, Temp.originationSystemName ) T

where D.orderId = T.orderId and T.TEP_Updated_Date = D.Updated_Date

group by D.serviceType,
D.consumerPartnerId ,
D.Client ,
D.Month_Date,
D.orderId
)
group by
FORMAT_DATE("%b %Y", Month_Date )  ,
--lineOfBusiness,
--originationSystemName,
Product_Integration,
Client,
End_Client,
Month_Date

 ;; }


    dimension: Product_Integration {

      type: string
      sql: ${TABLE}.Product_Integration ;;
    }

    dimension: Client {

      type: string
      sql: ${TABLE}.Client ;;
    }

    dimension: End_Client {
      type: string
      sql: ${TABLE}.End_Client ;;
    }

  measure: Total_Count {
    type: number
    sql: SUM(${TABLE}.Total_Count);;
  }


  dimension: Month_Date {
    label: "Month Date"
    sql: ${TABLE}.Month_Date ;;
    description: "used as filter for Date"
  }

  dimension: Order_Month {
    label: "Order_Month"
    sql: ${TABLE}.Order_Month ;;
    description: "used as filter for Month"
  }


  dimension_group: Month_Date {
    label: "Month Dimension"
    type: time
    sql: ${TABLE}.Month_Date ;;
  }


}

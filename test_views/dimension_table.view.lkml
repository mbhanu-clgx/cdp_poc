view: dimension_table {
  derived_table: {
  sql: select  distinct
_id as SLA_orderId,
loanNumber as SLA_LoanNumber,
serviceType as SLA_serviceType,
address as SLA_address,
originationSystemName as SLA_originationSystemName,
consumerPartnerId as consumerPartnerId
FROM looker_lookup.G2OrderReporting
Where
consumerPartnerId in('FANNIEMAE','FANNIEMAEV2');;
}
# loanNumber not in ('*TEST*','*TST*','*LOANID*')
dimension: sla_order_id {
  type: string
  sql: ${TABLE}.SLA_orderId ;;
}

dimension: sla_loan_number {
  type: string
  sql: ${TABLE}.SLA_LoanNumber ;;
}

dimension: sla_service_type {
  type: string
  sql: ${TABLE}.SLA_serviceType ;;
}

dimension: sla_address {
  type: string
  sql: ${TABLE}.SLA_address ;;
}

dimension: sla_origination_system_name {
  type: string
  sql: ${TABLE}.SLA_originationSystemName ;;
}
dimension: consumerPartnerId {
  type: string
  sql: ${TABLE}.consumerPartnerId ;;
}
}

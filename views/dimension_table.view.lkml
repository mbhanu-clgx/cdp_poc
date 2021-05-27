view: dimension_table {
  derived_table: {
  sql: select  distinct
_id as SLA_orderId,
loanNumber as SLA_LoanNumber,
serviceType as SLA_serviceType,
address as SLA_address,
originationSystemName as SLA_originationSystemName
FROM looker_lookup.G2OrderReporting
Where
loanNumber not in ('*TEST*','*TST*','*LOANID*') and consumerPartnerId in('FANNIEMAE','FANNIEMAEV2');;
}
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

}

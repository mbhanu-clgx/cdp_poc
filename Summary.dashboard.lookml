- dashboard: cdg_summary
  title: CDG Summary
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: Order Volume Summary
    name: Order Volume Summary
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_area
    fields: [CDGDashboard_Order_MaxDate.Order_Total, CDGDashboard_Order_MaxDate.Order_Created_Date_date]
    fill_fields: [CDGDashboard_Order_MaxDate.Order_Created_Date_date]
    sorts: [CDGDashboard_Order_MaxDate.Order_Created_Date_date desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Total Loans, orientation: left, series: [{axisId: CDGDashboard_Order_MaxDate.Order_Total,
            id: CDGDashboard_Order_MaxDate.Order_Total, name: Order Total}], showLabels: true,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 100, type: linear}]
    x_axis_label: Date
    series_types: {}
    series_colors:
      CDGDashboard_Order_MaxDate.Order_Total: "#3399FF"
    series_labels: {}
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 0
    col: 13
    width: 11
    height: 9
  - title: Monthly Order Volume
    name: Monthly Order Volume
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_column
    fields: [CDGDashboard_Order_MaxDate.Order_Total, CDGDashboard_Dimension_Table.serviceType,
      CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    pivots: [CDGDashboard_Dimension_Table.serviceType]
    fill_fields: [CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    sorts: [CDGDashboard_Dimension_Table.serviceType, CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    limit: 500
    column_limit: 5000
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: 4506-T - CDGDashboard_Order_MaxDate.Order_Total,
            id: 4506-T - CDGDashboard_Order_MaxDate.Order_Total, name: 4506-T}, {
            axisId: 4506-T_Reissue - CDGDashboard_Order_MaxDate.Order_Total, id: 4506-T_Reissue
              - CDGDashboard_Order_MaxDate.Order_Total, name: 4506-T_Reissue}, {axisId: AUTOMATIQHUBIA
              - CDGDashboard_Order_MaxDate.Order_Total, id: AUTOMATIQHUBIA - CDGDashboard_Order_MaxDate.Order_Total,
            name: AUTOMATIQHUBIA}, {axisId: AUTOMATIQHUBIABKFS - CDGDashboard_Order_MaxDate.Order_Total,
            id: AUTOMATIQHUBIABKFS - CDGDashboard_Order_MaxDate.Order_Total, name: AUTOMATIQHUBIABKFS},
          {axisId: AUTOMATIQHUBVOIBPV - CDGDashboard_Order_MaxDate.Order_Total, id: AUTOMATIQHUBVOIBPV
              - CDGDashboard_Order_MaxDate.Order_Total, name: AUTOMATIQHUBVOIBPV},
          {axisId: AUTOMATIQVOE - CDGDashboard_Order_MaxDate.Order_Total, id: AUTOMATIQVOE
              - CDGDashboard_Order_MaxDate.Order_Total, name: AUTOMATIQVOE}, {axisId: AUTOMATIQVOEI
              - CDGDashboard_Order_MaxDate.Order_Total, id: AUTOMATIQVOEI - CDGDashboard_Order_MaxDate.Order_Total,
            name: AUTOMATIQVOEI}, {axisId: AVMCMSBKFS - CDGDashboard_Order_MaxDate.Order_Total,
            id: AVMCMSBKFS - CDGDashboard_Order_MaxDate.Order_Total, name: AVMCMSBKFS},
          {axisId: AVMONSITE - CDGDashboard_Order_MaxDate.Order_Total, id: AVMONSITE
              - CDGDashboard_Order_MaxDate.Order_Total, name: AVMONSITE}, {axisId: AVMSYNC
              - CDGDashboard_Order_MaxDate.Order_Total, id: AVMSYNC - CDGDashboard_Order_MaxDate.Order_Total,
            name: AVMSYNC}, {axisId: CCCAPPRAISAL - CDGDashboard_Order_MaxDate.Order_Total,
            id: CCCAPPRAISAL - CDGDashboard_Order_MaxDate.Order_Total, name: CCCAPPRAISAL},
          {axisId: CCCAPPRAISALCDGJSONPASSTHRU - CDGDashboard_Order_MaxDate.Order_Total,
            id: CCCAPPRAISALCDGJSONPASSTHRU - CDGDashboard_Order_MaxDate.Order_Total,
            name: CCCAPPRAISALCDGJSONPASSTHRU}, {axisId: CCCAPPRAISALDEXMA - CDGDashboard_Order_MaxDate.Order_Total,
            id: CCCAPPRAISALDEXMA - CDGDashboard_Order_MaxDate.Order_Total, name: CCCAPPRAISALDEXMA},
          {axisId: CCCAPPRAISALELLIEMAEPC2 - CDGDashboard_Order_MaxDate.Order_Total,
            id: CCCAPPRAISALELLIEMAEPC2 - CDGDashboard_Order_MaxDate.Order_Total,
            name: CCCAPPRAISALELLIEMAEPC2}, {axisId: CCCAPPRAISALFIGURETECH - CDGDashboard_Order_MaxDate.Order_Total,
            id: CCCAPPRAISALFIGURETECH - CDGDashboard_Order_MaxDate.Order_Total, name: CCCAPPRAISALFIGURETECH},
          {axisId: CCCAPPRAISALMERCURY - CDGDashboard_Order_MaxDate.Order_Total, id: CCCAPPRAISALMERCURY
              - CDGDashboard_Order_MaxDate.Order_Total, name: CCCAPPRAISALMERCURY},
          {axisId: CHASETITLE - CDGDashboard_Order_MaxDate.Order_Total, id: CHASETITLE
              - CDGDashboard_Order_MaxDate.Order_Total, name: CHASETITLE}, {axisId: CONDOSAFE
              - CDGDashboard_Order_MaxDate.Order_Total, id: CONDOSAFE - CDGDashboard_Order_MaxDate.Order_Total,
            name: CONDOSAFE}, {axisId: CONDOSAFEJSONPUSH - CDGDashboard_Order_MaxDate.Order_Total,
            id: CONDOSAFEJSONPUSH - CDGDashboard_Order_MaxDate.Order_Total, name: CONDOSAFEJSONPUSH},
          {axisId: CONDOSAFESTOREFRONT - CDGDashboard_Order_MaxDate.Order_Total, id: CONDOSAFESTOREFRONT
              - CDGDashboard_Order_MaxDate.Order_Total, name: CONDOSAFESTOREFRONT},
          {axisId: CREDIT - CDGDashboard_Order_MaxDate.Order_Total, id: CREDIT - CDGDashboard_Order_MaxDate.Order_Total,
            name: CREDIT}, {axisId: CREDITM231 - CDGDashboard_Order_MaxDate.Order_Total,
            id: CREDITM231 - CDGDashboard_Order_MaxDate.Order_Total, name: CREDITM231},
          {axisId: EARLYCHECK - CDGDashboard_Order_MaxDate.Order_Total, id: EARLYCHECK
              - CDGDashboard_Order_MaxDate.Order_Total, name: EARLYCHECK}, {axisId: EQUIFAXTWN
              - CDGDashboard_Order_MaxDate.Order_Total, id: EQUIFAXTWN - CDGDashboard_Order_MaxDate.Order_Total,
            name: EQUIFAXTWN}, {axisId: FACTCHECK - CDGDashboard_Order_MaxDate.Order_Total,
            id: FACTCHECK - CDGDashboard_Order_MaxDate.Order_Total, name: FACTCHECK},
          {axisId: FLOOD - CDGDashboard_Order_MaxDate.Order_Total, id: FLOOD - CDGDashboard_Order_MaxDate.Order_Total,
            name: FLOOD}, {axisId: FLOODEXT - CDGDashboard_Order_MaxDate.Order_Total,
            id: FLOODEXT - CDGDashboard_Order_MaxDate.Order_Total, name: FLOODEXT},
          {axisId: FLOODEXTPULL - CDGDashboard_Order_MaxDate.Order_Total, id: FLOODEXTPULL
              - CDGDashboard_Order_MaxDate.Order_Total, name: FLOODEXTPULL}, {axisId: FLOODPUSH
              - CDGDashboard_Order_MaxDate.Order_Total, id: FLOODPUSH - CDGDashboard_Order_MaxDate.Order_Total,
            name: FLOODPUSH}, {axisId: FLOODSYNC - CDGDashboard_Order_MaxDate.Order_Total,
            id: FLOODSYNC - CDGDashboard_Order_MaxDate.Order_Total, name: FLOODSYNC},
          {axisId: FMACHVEAVM - CDGDashboard_Order_MaxDate.Order_Total, id: FMACHVEAVM
              - CDGDashboard_Order_MaxDate.Order_Total, name: FMACHVEAVM}, {axisId: FNCCMSAPPRAISAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: FNCCMSAPPRAISAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: FNCCMSAPPRAISAL}, {axisId: FREDDIELOANTRANSFER - CDGDashboard_Order_MaxDate.Order_Total,
            id: FREDDIELOANTRANSFER - CDGDashboard_Order_MaxDate.Order_Total, name: FREDDIELOANTRANSFER},
          {axisId: FREDDIEULAD - CDGDashboard_Order_MaxDate.Order_Total, id: FREDDIEULAD
              - CDGDashboard_Order_MaxDate.Order_Total, name: FREDDIEULAD}, {axisId: HALOGENCMSUSBANK
              - CDGDashboard_Order_MaxDate.Order_Total, id: HALOGENCMSUSBANK - CDGDashboard_Order_MaxDate.Order_Total,
            name: HALOGENCMSUSBANK}, {axisId: HEALTHCHECK - CDGDashboard_Order_MaxDate.Order_Total,
            id: HEALTHCHECK - CDGDashboard_Order_MaxDate.Order_Total, name: HEALTHCHECK},
          {axisId: HOUSECANARY - CDGDashboard_Order_MaxDate.Order_Total, id: HOUSECANARY
              - CDGDashboard_Order_MaxDate.Order_Total, name: HOUSECANARY}, {axisId: LOANMODBATCHJSON
              - CDGDashboard_Order_MaxDate.Order_Total, id: LOANMODBATCHJSON - CDGDashboard_Order_MaxDate.Order_Total,
            name: LOANMODBATCHJSON}, {axisId: LOANMODJSON - CDGDashboard_Order_MaxDate.Order_Total,
            id: LOANMODJSON - CDGDashboard_Order_MaxDate.Order_Total, name: LOANMODJSON},
          {axisId: LOANSAFECDE - CDGDashboard_Order_MaxDate.Order_Total, id: LOANSAFECDE
              - CDGDashboard_Order_MaxDate.Order_Total, name: LOANSAFECDE}, {axisId: LOANSAFESYNC
              - CDGDashboard_Order_MaxDate.Order_Total, id: LOANSAFESYNC - CDGDashboard_Order_MaxDate.Order_Total,
            name: LOANSAFESYNC}, {axisId: LSFM - CDGDashboard_Order_MaxDate.Order_Total,
            id: LSFM - CDGDashboard_Order_MaxDate.Order_Total, name: LSFM}, {axisId: M34TOM21SYNC
              - CDGDashboard_Order_MaxDate.Order_Total, id: M34TOM21SYNC - CDGDashboard_Order_MaxDate.Order_Total,
            name: M34TOM21SYNC}, {axisId: M34ULADDUTOM21SYNC - CDGDashboard_Order_MaxDate.Order_Total,
            id: M34ULADDUTOM21SYNC - CDGDashboard_Order_MaxDate.Order_Total, name: M34ULADDUTOM21SYNC},
          {axisId: MERCURYAPPRAISAL - CDGDashboard_Order_MaxDate.Order_Total, id: MERCURYAPPRAISAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: MERCURYAPPRAISAL}, {
            axisId: MERCURYQVPOPTIVALAVM - CDGDashboard_Order_MaxDate.Order_Total,
            id: MERCURYQVPOPTIVALAVM - CDGDashboard_Order_MaxDate.Order_Total, name: MERCURYQVPOPTIVALAVM},
          {axisId: MERCURYQVPPDSRCR - CDGDashboard_Order_MaxDate.Order_Total, id: MERCURYQVPPDSRCR
              - CDGDashboard_Order_MaxDate.Order_Total, name: MERCURYQVPPDSRCR}, {
            axisId: PTEPLUSFLOOD - CDGDashboard_Order_MaxDate.Order_Total, id: PTEPLUSFLOOD
              - CDGDashboard_Order_MaxDate.Order_Total, name: PTEPLUSFLOOD}, {axisId: REISSUE
              - CDGDashboard_Order_MaxDate.Order_Total, id: REISSUE - CDGDashboard_Order_MaxDate.Order_Total,
            name: REISSUE}, {axisId: REISSUEFREDDIE - CDGDashboard_Order_MaxDate.Order_Total,
            id: REISSUEFREDDIE - CDGDashboard_Order_MaxDate.Order_Total, name: REISSUEFREDDIE}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    font_size: ''
    series_types: {}
    series_colors:
      CDGDashboard_Order_MaxDate.Order_Total: "#3399FF"
    x_axis_datetime_label: ''
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 24
    col: 0
    width: 24
    height: 10
  - title: Client/Partner
    name: Client/Partner
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_pie
    fields: [CDGDashboard_Dimension_Table.End_Client_Consumer_partner, CDGDashboard_Order_MaxDate.Order_Total]
    sorts: [CDGDashboard_Order_MaxDate.Order_Total desc]
    limit: 10
    value_labels: none
    label_type: labPer
    inner_radius: 75
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 4
    col: 0
    width: 4
    height: 5
  - title: Total Monthly Orders
    name: Total Monthly Orders
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_column
    fields: [CDGDashboard_Order_MaxDate.Order_Total, CDGDashboard_Order_MaxDate.Month_Date_month,
      CDGDashboard_Dimension_Table.serviceType]
    pivots: [CDGDashboard_Order_MaxDate.Month_Date_month]
    fill_fields: [CDGDashboard_Order_MaxDate.Month_Date_month]
    sorts: [CDGDashboard_Order_MaxDate.Month_Date_month, CDGDashboard_Order_MaxDate.Order_Total
        desc 0]
    dynamic_fields: [{table_calculation: avg_order_volume, label: Avg Order Volume,
        expression: 'count(${CDGDashboard_Order_MaxDate.OrderId_Count:total})/count_distinct(
          ${CDGDashboard_Order_MaxDate.Month_Date_month_num})', value_format: !!null '',
        value_format_name: !!null '', is_disabled: true, _kind_hint: measure, _type_hint: number}]
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#4b8072"
    color_application:
      collection_id: 143f7d9e-187b-4105-bcd3-dfec8a7f9cba
      palette_id: 13ea07e1-382e-4911-801e-58db626234f8
      options:
        steps: 5
        reverse: true
    y_axes: [{label: Totals, orientation: left, series: [{axisId: CDGDashboard_Order_MaxDate.Order_Total,
            id: CDGDashboard_Order_MaxDate.Order_Total, name: Order Total}], showLabels: true,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 100, type: linear}]
    x_axis_label: Service Type
    hide_legend: true
    font_size: small
    label_value_format: ''
    series_types: {}
    series_colors: {}
    series_labels:
      CDGDashboard_Order_MaxDate.order_Id: Order Id
      CDGDashboard_Order_MaxDate.orderState: Order State
      CDGDashboard_Dimension_Table.loanNumber: Loan Number
      CDGDashboard_Dimension_Table.serviceType: Product Type
      CDGDashboard_Order_MaxDate.Month_Date_date: Created Date
      CDGDashboard_Dimension_Table.consumerPartnerId: Consumer Partner Id
      CDGDashboard_Dimension_Table.fulfillmentServiceAlias: fulfillmentServiceAlias
      CDGDashboard_Dimension_Table.End_Client: Client
      CDGDashboard_Dimension_Table.ggLenderIdentifier: ggLenderIdentifier
    series_point_styles:
      CDGDashboard_Order_MaxDate.Order_Total: square
    reference_lines: []
    trend_lines: []
    column_spacing_ratio: 1
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      CDGDashboard_Order_MaxDate.Month_Date_date: 175
    hidden_fields: []
    hidden_points_if_no: []
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 34
    col: 0
    width: 24
    height: 9
  - title: Monthly Order Volume by Client
    name: Monthly Order Volume by Client
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_column
    fields: [CDGDashboard_Dimension_Table.End_Client_Consumer_partner, CDGDashboard_Order_MaxDate.Order_Total,
      CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    pivots: [CDGDashboard_Dimension_Table.End_Client_Consumer_partner]
    fill_fields: [CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    sorts: [CDGDashboard_Dimension_Table.End_Client_Consumer_partner desc, CDGDashboard_Order_MaxDate.Order_Created_Date_month]
    limit: 5000
    column_limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: YESLEASING - CDGDashboard_Order_MaxDate.Order_Total,
            id: YESLEASING - CDGDashboard_Order_MaxDate.Order_Total, name: YESLEASING},
          {axisId: WYNDHAMCAPITAL - CDGDashboard_Order_MaxDate.Order_Total, id: WYNDHAMCAPITAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: WYNDHAMCAPITAL}, {axisId: WSFSBANK
              - CDGDashboard_Order_MaxDate.Order_Total, id: WSFSBANK - CDGDashboard_Order_MaxDate.Order_Total,
            name: WSFSBANK}, {axisId: WELLSFARGO_VPS - CDGDashboard_Order_MaxDate.Order_Total,
            id: WELLSFARGO_VPS - CDGDashboard_Order_MaxDate.Order_Total, name: WELLSFARGO_VPS},
          {axisId: VETERANS_UNITED - CDGDashboard_Order_MaxDate.Order_Total, id: VETERANS_UNITED
              - CDGDashboard_Order_MaxDate.Order_Total, name: VETERANS_UNITED}, {
            axisId: USBANK - CDGDashboard_Order_MaxDate.Order_Total, id: USBANK -
              CDGDashboard_Order_MaxDate.Order_Total, name: USBANK}, {axisId: USAABANK
              - CDGDashboard_Order_MaxDate.Order_Total, id: USAABANK - CDGDashboard_Order_MaxDate.Order_Total,
            name: USAABANK}, {axisId: UNITED_SHORE - CDGDashboard_Order_MaxDate.Order_Total,
            id: UNITED_SHORE - CDGDashboard_Order_MaxDate.Order_Total, name: UNITED_SHORE},
          {axisId: UnionHome - CDGDashboard_Order_MaxDate.Order_Total, id: UnionHome
              - CDGDashboard_Order_MaxDate.Order_Total, name: UnionHome}, {axisId: TERRACEFINANCE
              - CDGDashboard_Order_MaxDate.Order_Total, id: TERRACEFINANCE - CDGDashboard_Order_MaxDate.Order_Total,
            name: TERRACEFINANCE}, {axisId: TCI - CDGDashboard_Order_MaxDate.Order_Total,
            id: TCI - CDGDashboard_Order_MaxDate.Order_Total, name: TCI}, {axisId: TAYCORFINANCIAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: TAYCORFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: TAYCORFINANCIAL}, {axisId: STOREFRONT - CDGDashboard_Order_MaxDate.Order_Total,
            id: STOREFRONT - CDGDashboard_Order_MaxDate.Order_Total, name: STOREFRONT},
          {axisId: SKYALLIESCAPITAL - CDGDashboard_Order_MaxDate.Order_Total, id: SKYALLIESCAPITAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: SKYALLIESCAPITAL}, {
            axisId: SIMPLENEXUS - CDGDashboard_Order_MaxDate.Order_Total, id: SIMPLENEXUS
              - CDGDashboard_Order_MaxDate.Order_Total, name: SIMPLENEXUS}, {axisId: SILVERHILL
              - CDGDashboard_Order_MaxDate.Order_Total, id: SILVERHILL - CDGDashboard_Order_MaxDate.Order_Total,
            name: SILVERHILL}, {axisId: RENOVATE_AMERICA - CDGDashboard_Order_MaxDate.Order_Total,
            id: RENOVATE_AMERICA - CDGDashboard_Order_MaxDate.Order_Total, name: RENOVATE_AMERICA},
          {axisId: RENOFI - CDGDashboard_Order_MaxDate.Order_Total, id: RENOFI - CDGDashboard_Order_MaxDate.Order_Total,
            name: RENOFI}, {axisId: REDFIN - CDGDashboard_Order_MaxDate.Order_Total,
            id: REDFIN - CDGDashboard_Order_MaxDate.Order_Total, name: REDFIN}, {
            axisId: REALEC - CDGDashboard_Order_MaxDate.Order_Total, id: REALEC -
              CDGDashboard_Order_MaxDate.Order_Total, name: REALEC}, {axisId: QUICKENLOANS_MTG
              - CDGDashboard_Order_MaxDate.Order_Total, id: QUICKENLOANS_MTG - CDGDashboard_Order_MaxDate.Order_Total,
            name: QUICKENLOANS_MTG}, {axisId: QUANTUMREVERSE - CDGDashboard_Order_MaxDate.Order_Total,
            id: QUANTUMREVERSE - CDGDashboard_Order_MaxDate.Order_Total, name: QUANTUMREVERSE},
          {axisId: PORTAL - CDGDashboard_Order_MaxDate.Order_Total, id: PORTAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: PORTAL}, {axisId: PERFECTLO - CDGDashboard_Order_MaxDate.Order_Total,
            id: PERFECTLO - CDGDashboard_Order_MaxDate.Order_Total, name: PERFECTLO},
          {axisId: PENNYMAC - CDGDashboard_Order_MaxDate.Order_Total, id: PENNYMAC
              - CDGDashboard_Order_MaxDate.Order_Total, name: PENNYMAC}, {axisId: PCLENDER
              - CDGDashboard_Order_MaxDate.Order_Total, id: PCLENDER - CDGDashboard_Order_MaxDate.Order_Total,
            name: PCLENDER}, {axisId: PATELCO - CDGDashboard_Order_MaxDate.Order_Total,
            id: PATELCO - CDGDashboard_Order_MaxDate.Order_Total, name: PATELCO},
          {axisId: NAVYFEDERAL - CDGDashboard_Order_MaxDate.Order_Total, id: NAVYFEDERAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: NAVYFEDERAL}, {axisId: MRCOOPER
              - CDGDashboard_Order_MaxDate.Order_Total, id: MRCOOPER - CDGDashboard_Order_MaxDate.Order_Total,
            name: MRCOOPER}, {axisId: MORTGAGEHIPPO - CDGDashboard_Order_MaxDate.Order_Total,
            id: MORTGAGEHIPPO - CDGDashboard_Order_MaxDate.Order_Total, name: MORTGAGEHIPPO},
          {axisId: MORTGAGECADENCE - CDGDashboard_Order_MaxDate.Order_Total, id: MORTGAGECADENCE
              - CDGDashboard_Order_MaxDate.Order_Total, name: MORTGAGECADENCE}, {
            axisId: MORTGAGEAUTOMATOR - CDGDashboard_Order_MaxDate.Order_Total, id: MORTGAGEAUTOMATOR
              - CDGDashboard_Order_MaxDate.Order_Total, name: MORTGAGEAUTOMATOR},
          {axisId: MICHIGANMUTUAL - CDGDashboard_Order_MaxDate.Order_Total, id: MICHIGANMUTUAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: MICHIGANMUTUAL}, {axisId: MERCURYQVP
              - CDGDashboard_Order_MaxDate.Order_Total, id: MERCURYQVP - CDGDashboard_Order_MaxDate.Order_Total,
            name: MERCURYQVP}, {axisId: MERCURY_NETWORK - CDGDashboard_Order_MaxDate.Order_Total,
            id: MERCURY_NETWORK - CDGDashboard_Order_MaxDate.Order_Total, name: MERCURY_NETWORK},
          {axisId: MEMBERCLOSE - CDGDashboard_Order_MaxDate.Order_Total, id: MEMBERCLOSE
              - CDGDashboard_Order_MaxDate.Order_Total, name: MEMBERCLOSE}, {axisId: MEGACAPITALFUNDING
              - CDGDashboard_Order_MaxDate.Order_Total, id: MEGACAPITALFUNDING - CDGDashboard_Order_MaxDate.Order_Total,
            name: MEGACAPITALFUNDING}, {axisId: LOANCENTER - CDGDashboard_Order_MaxDate.Order_Total,
            id: LOANCENTER - CDGDashboard_Order_MaxDate.Order_Total, name: LOANCENTER},
          {axisId: LOANCARE - CDGDashboard_Order_MaxDate.Order_Total, id: LOANCARE
              - CDGDashboard_Order_MaxDate.Order_Total, name: LOANCARE}, {axisId: LENNAR
              MORTGAGE - CDGDashboard_Order_MaxDate.Order_Total, id: LENNAR MORTGAGE
              - CDGDashboard_Order_MaxDate.Order_Total, name: LENNAR MORTGAGE}, {
            axisId: LENDWIZE - CDGDashboard_Order_MaxDate.Order_Total, id: LENDWIZE
              - CDGDashboard_Order_MaxDate.Order_Total, name: LENDWIZE}, {axisId: LENDINGSPACE
              - CDGDashboard_Order_MaxDate.Order_Total, id: LENDINGSPACE - CDGDashboard_Order_MaxDate.Order_Total,
            name: LENDINGSPACE}, {axisId: LENDINGQB - CDGDashboard_Order_MaxDate.Order_Total,
            id: LENDINGQB - CDGDashboard_Order_MaxDate.Order_Total, name: LENDINGQB},
          {axisId: LEASEPOINT - CDGDashboard_Order_MaxDate.Order_Total, id: LEASEPOINT
              - CDGDashboard_Order_MaxDate.Order_Total, name: LEASEPOINT}, {axisId: LEADERONEFINANCIAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: LEADERONEFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: LEADERONEFINANCIAL}, {axisId: LASERACCURACY - CDGDashboard_Order_MaxDate.Order_Total,
            id: LASERACCURACY - CDGDashboard_Order_MaxDate.Order_Total, name: LASERACCURACY},
          {axisId: JPMORGAN - CDGDashboard_Order_MaxDate.Order_Total, id: JPMORGAN
              - CDGDashboard_Order_MaxDate.Order_Total, name: JPMORGAN}, {axisId: INTELLIMODSPORTAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: INTELLIMODSPORTAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: INTELLIMODSPORTAL}, {axisId: FREDDIE MAC - CDGDashboard_Order_MaxDate.Order_Total,
            id: FREDDIE MAC - CDGDashboard_Order_MaxDate.Order_Total, name: FREDDIE
              MAC}, {axisId: FORWARDMORTGAGE - CDGDashboard_Order_MaxDate.Order_Total,
            id: FORWARDMORTGAGE - CDGDashboard_Order_MaxDate.Order_Total, name: FORWARDMORTGAGE},
          {axisId: FNCPORTS - CDGDashboard_Order_MaxDate.Order_Total, id: FNCPORTS
              - CDGDashboard_Order_MaxDate.Order_Total, name: FNCPORTS}, {axisId: FNC_CMS
              - CDGDashboard_Order_MaxDate.Order_Total, id: FNC_CMS - CDGDashboard_Order_MaxDate.Order_Total,
            name: FNC_CMS}, {axisId: FLOIFY - CDGDashboard_Order_MaxDate.Order_Total,
            id: FLOIFY - CDGDashboard_Order_MaxDate.Order_Total, name: FLOIFY}, {
            axisId: FIGURETECHNOLOGIES - CDGDashboard_Order_MaxDate.Order_Total, id: FIGURETECHNOLOGIES
              - CDGDashboard_Order_MaxDate.Order_Total, name: FIGURETECHNOLOGIES},
          {axisId: FANNIEMAE - CDGDashboard_Order_MaxDate.Order_Total, id: FANNIEMAE
              - CDGDashboard_Order_MaxDate.Order_Total, name: FANNIEMAE}, {axisId: EVOLVEMORTGAGESERVICES
              - CDGDashboard_Order_MaxDate.Order_Total, id: EVOLVEMORTGAGESERVICES
              - CDGDashboard_Order_MaxDate.Order_Total, name: EVOLVEMORTGAGESERVICES},
          {axisId: EQUIFAX_TWN - CDGDashboard_Order_MaxDate.Order_Total, id: EQUIFAX_TWN
              - CDGDashboard_Order_MaxDate.Order_Total, name: EQUIFAX_TWN}, {axisId: ELLIEMAEPC
              - CDGDashboard_Order_MaxDate.Order_Total, id: ELLIEMAEPC - CDGDashboard_Order_MaxDate.Order_Total,
            name: ELLIEMAEPC}, {axisId: ELLIEMAE - CDGDashboard_Order_MaxDate.Order_Total,
            id: ELLIEMAE - CDGDashboard_Order_MaxDate.Order_Total, name: ELLIEMAE},
          {axisId: DOMINIONFINANCIALSVCS - CDGDashboard_Order_MaxDate.Order_Total,
            id: DOMINIONFINANCIALSVCS - CDGDashboard_Order_MaxDate.Order_Total, name: DOMINIONFINANCIALSVCS},
          {axisId: CUDIRECT - CDGDashboard_Order_MaxDate.Order_Total, id: CUDIRECT
              - CDGDashboard_Order_MaxDate.Order_Total, name: CUDIRECT}, {axisId: CRMP
              - CDGDashboard_Order_MaxDate.Order_Total, id: CRMP - CDGDashboard_Order_MaxDate.Order_Total,
            name: CRMP}, {axisId: CREDALYZER - CDGDashboard_Order_MaxDate.Order_Total,
            id: CREDALYZER - CDGDashboard_Order_MaxDate.Order_Total, name: CREDALYZER},
          {axisId: CORELOGIC_TOMS - CDGDashboard_Order_MaxDate.Order_Total, id: CORELOGIC_TOMS
              - CDGDashboard_Order_MaxDate.Order_Total, name: CORELOGIC_TOMS}, {axisId: CORELOGIC_C2D
              - CDGDashboard_Order_MaxDate.Order_Total, id: CORELOGIC_C2D - CDGDashboard_Order_MaxDate.Order_Total,
            name: CORELOGIC_C2D}, {axisId: COMMERCEHOMEMORTGAGE - CDGDashboard_Order_MaxDate.Order_Total,
            id: COMMERCEHOMEMORTGAGE - CDGDashboard_Order_MaxDate.Order_Total, name: COMMERCEHOMEMORTGAGE},
          {axisId: CLOSINGCORP - CDGDashboard_Order_MaxDate.Order_Total, id: CLOSINGCORP
              - CDGDashboard_Order_MaxDate.Order_Total, name: CLOSINGCORP}, {axisId: CLINTERNAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: CLINTERNAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: CLINTERNAL}, {axisId: CLARIFIRE - CDGDashboard_Order_MaxDate.Order_Total,
            id: CLARIFIRE - CDGDashboard_Order_MaxDate.Order_Total, name: CLARIFIRE},
          {axisId: CIVICFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total, id: CIVICFINANCIAL
              - CDGDashboard_Order_MaxDate.Order_Total, name: CIVICFINANCIAL}, {axisId: CITIGLOBALMARKETS
              - CDGDashboard_Order_MaxDate.Order_Total, id: CITIGLOBALMARKETS - CDGDashboard_Order_MaxDate.Order_Total,
            name: CITIGLOBALMARKETS}, {axisId: CARDINALFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total,
            id: CARDINALFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total, name: CARDINALFINANCIAL},
          {axisId: CALYX - CDGDashboard_Order_MaxDate.Order_Total, id: CALYX - CDGDashboard_Order_MaxDate.Order_Total,
            name: CALYX}, {axisId: BYTESOFTWARE - CDGDashboard_Order_MaxDate.Order_Total,
            id: BYTESOFTWARE - CDGDashboard_Order_MaxDate.Order_Total, name: BYTESOFTWARE},
          {axisId: BYTE - CDGDashboard_Order_MaxDate.Order_Total, id: BYTE - CDGDashboard_Order_MaxDate.Order_Total,
            name: BYTE}, {axisId: BLUESAGE - CDGDashboard_Order_MaxDate.Order_Total,
            id: BLUESAGE - CDGDashboard_Order_MaxDate.Order_Total, name: BLUESAGE},
          {axisId: BETTERMORTGAGE - CDGDashboard_Order_MaxDate.Order_Total, id: BETTERMORTGAGE
              - CDGDashboard_Order_MaxDate.Order_Total, name: BETTERMORTGAGE}, {axisId: APEXFINANCIAL
              - CDGDashboard_Order_MaxDate.Order_Total, id: APEXFINANCIAL - CDGDashboard_Order_MaxDate.Order_Total,
            name: APEXFINANCIAL}, {axisId: AMERISAVE - CDGDashboard_Order_MaxDate.Order_Total,
            id: AMERISAVE - CDGDashboard_Order_MaxDate.Order_Total, name: AMERISAVE},
          {axisId: ALTISOURCELENDERSONE - CDGDashboard_Order_MaxDate.Order_Total,
            id: ALTISOURCELENDERSONE - CDGDashboard_Order_MaxDate.Order_Total, name: ALTISOURCELENDERSONE}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 29, type: linear}]
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 9
    col: 0
    width: 24
    height: 15
  - title: Product Summary
    name: Product Summary
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_pie
    fields: [CDGDashboard_Order_MaxDate.Order_Total, CDGDashboard_Dimension_Table.serviceType]
    sorts: [CDGDashboard_Order_MaxDate.Order_Total desc]
    limit: 10
    value_labels: none
    label_type: labPer
    inner_radius: 75
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 4
    col: 4
    width: 5
    height: 5
  - title: End Client
    name: End Client
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: looker_pie
    fields: [CDGDashboard_Order_MaxDate.Order_Total, CDGDashboard_Dimension_Table.End_Client]
    sorts: [CDGDashboard_Order_MaxDate.Order_Total desc]
    limit: 10
    value_labels: none
    label_type: labPer
    inner_radius: 75
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 4
    col: 9
    width: 4
    height: 5
  - title: Avg Monthly Orders
    name: Avg Monthly Orders
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: single_value
    fields: [CDGDashboard_Order_MaxDate.Order_Total, yearmonthcount]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: avg_monthly_orders, label: Avg. Monthly Orders,
        expression: "${CDGDashboard_Order_MaxDate.Order_Total}/${yearmonthcount}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}, {measure: yearmonthcount, based_on: CDGDashboard_Order_MaxDate.year_month,
        type: count_distinct, label: YearMonthCount, expression: !!null '', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [CDGDashboard_Order_MaxDate.Order_Total, yearmonthcount]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 2
    col: 0
    width: 5
    height: 2
  - title: Total Orders
    name: Total Orders
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: single_value
    fields: [CDGDashboard_Order_MaxDate.Order_Total]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: avg_monthly_orders, label: Avg. Monthly Orders,
        expression: "${CDGDashboard_Order_MaxDate.Order_Total}/${yearmonthcount}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {measure: yearmonthcount, based_on: CDGDashboard_Order_MaxDate.Month_Date_month_num,
        type: count_distinct, label: YearMonthCount, expression: !!null '', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Orders
    hidden_fields:
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 2
    col: 5
    width: 4
    height: 2
  - title: ''
    name: ''
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: single_value
    fields: [CDGDashboard_Order_MaxDate.CDG_Summary]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
    row: 0
    col: 4
    width: 4
    height: 2
  - title: ''
    name: " (2)"
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: single_value
    fields: [CDGDashboard_Order_MaxDate.CDG_Details_link]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
    row: 0
    col: 8
    width: 5
    height: 2
  - name: " (3)"
    type: text
    body_text: <img src="https://www.corelogic.com/wp-content/themes/corelogic/assets/corelogic-icon.svg">
    row: 0
    col: 0
    width: 4
    height: 2
  - title: Total Orders (copy)
    name: Total Orders (copy)
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    type: single_value
    fields: [CDGDashboard_Dimension_Table.Order_Total]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: avg_monthly_orders, label: Avg. Monthly Orders,
        expression: "${CDGDashboard_Order_MaxDate.Order_Total}/${yearmonthcount}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {measure: yearmonthcount, based_on: CDGDashboard_Order_MaxDate.Month_Date_month_num,
        type: count_distinct, label: YearMonthCount, expression: !!null '', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Orders
    hidden_fields:
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Created Date: CDGDashboard_Order_MaxDate.Order_Created_Date_date
      Year Month: CDGDashboard_Order_MaxDate.year_month
      Product: CDGDashboard_Dimension_Table.serviceType
      Client: CDGDashboard_Dimension_Table.End_Client
      Client/Partner: CDGDashboard_Order_MaxDate.consumerPartnerId
      Consumer_partner: CDGDashboard_Dimension_Table.End_Client_Consumer_partner
    row: 2
    col: 9
    width: 4
    height: 2
  filters:
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Order_MaxDate.Order_Created_Date_date
  - name: Year Month
    title: Year Month
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Order_MaxDate.year_month
  - name: Product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Dimension_Table.serviceType
  - name: Client
    title: Client
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Dimension_Table.End_Client
  - name: Client/Partner
    title: Client/Partner
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Order_MaxDate.consumerPartnerId
  - name: Consumer_partner
    title: Consumer_partner
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: gateway_cdg
    explore: CDGDashboard_Dimension_Table
    listens_to_filters: []
    field: CDGDashboard_Dimension_Table.End_Client_Consumer_partner

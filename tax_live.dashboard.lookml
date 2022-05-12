- dashboard: cdg_tax_live__dashboard
  title: CDG TAX LIVE  Dashboard
  layout: newspaper
  preferred_viewer: dashboards
  elements:
  - title: TAX Turn Around Time - Monthly
    name: TAX Turn Around Time - Monthly
    model: gateway_cdg
    explore: cdg_tax_live
    type: looker_grid
    fields: [cdg_tax_live.Tax_Date_Dimension, cdg_tax_live.LESSTHAN_OR_EQUAL_12_SECS,
      cdg_tax_live.BETWEEN_12_15_SECS, cdg_tax_live.GREATERTHAN_15_SECS, cdg_tax_live.Tax_Order_Count,
      cdg_tax_live.AVG_TIME_IN_SECS, cdg_tax_live.NO_RESPONSE, cdg_tax_live.Tax_Days_Date_month_num,
      cdg_tax_live.Tax_Days_Date_month]
    sorts: [cdg_tax_live.Tax_Days_Date_month desc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: true
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [{}]
    show_totals: true
    show_row_totals: true
    series_column_widths:
      measure: 230
    series_cell_visualizations:
      cdg_tax_live.LESSTHAN_OR_EQUAL_12_SECS:
        is_active: false
    series_value_format:
      cdg_tax_live.LESSTHAN_OR_EQUAL_12_SECS:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
      cdg_tax_live.BETWEEN_12_15_SECS:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
      cdg_tax_live.GREATERTHAN_15_SECS:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
      cdg_tax_live.AVG_TIME_IN_SECS:
        name: decimal_2
        format_string: "#,##0.00"
        label: Decimals (2)
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    hidden_fields: [cdg_tax_live.Tax_Days_Date_month_num, cdg_tax_live.Tax_Days_Date_month]
    listen:
      TAX Turn Around - Monthly Filter: cdg_tax_live.Tax_Days_Date_date
    row: 0
    col: 0
    width: 24
    height: 4
  - title: TAX TurnAround Time - Daily
    name: TAX TurnAround Time - Daily
    model: gateway_cdg
    explore: cdg_tax_live_Daily
    type: looker_grid
    fields: [cdg_tax_live_Daily.LESSTHAN_OR_EQUAL_12_SECS, cdg_tax_live_Daily.BETWEEN_12_15_SECS,
      cdg_tax_live_Daily.GREATERTHAN_15_SECS, cdg_tax_live_Daily.Tax_Order_Count,
      cdg_tax_live_Daily.AVG_TIME_IN_SECS, cdg_tax_live_Daily.NO_RESPONSE, cdg_tax_live_Daily.Tax_Days_Date]
    filters: {}
    sorts: [cdg_tax_live_Daily.Tax_Days_Date desc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: true
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: {}
    show_totals: true
    show_row_totals: true
    series_column_widths:
      '2021-04-17': 133
      measure: 206
    series_cell_visualizations:
      cdg_tax_live_Daily.LESSTHAN_OR_EQUAL_12_SECS:
        is_active: false
    series_value_format:
      cdg_tax_live_Daily.LESSTHAN_OR_EQUAL_12_SECS: '00.00'
      cdg_tax_live_Daily.BETWEEN_12_15_SECS: '00.00'
      cdg_tax_live_Daily.GREATERTHAN_15_SECS: '00.00'
      cdg_tax_live_Daily.AVG_TIME_IN_SECS: '00.00'
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen:
      TAX Turn Around - Daily Filter: cdg_tax_live_Daily.Tax_Days_Date
    row: 4
    col: 0
    width: 24
    height: 5
  - title: TAX Reports
    name: TAX Reports
    model: gateway_cdg
    explore: cdg_tax_live_detail_reports
    type: looker_grid
    fields: [cdg_tax_live_detail_reports.SLA_LoanNumber, cdg_tax_live_detail_reports.SLA_orderId,
      cdg_tax_live_detail_reports.Line_of_Business, cdg_tax_live_detail_reports.created_date_millisecond4,
      cdg_tax_live_detail_reports.fulfillment_date_millisecond4, cdg_tax_live_detail_reports.orderStatus,
      cdg_tax_live_detail_reports.TAT_Milli_secs, cdg_tax_live_detail_reports.TB_1,
      cdg_tax_live_detail_reports.Greater_15_Sec, cdg_tax_live_detail_reports.orderUpdatedDate]
    sorts: [cdg_tax_live_detail_reports.created_date_millisecond4]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_types: {}
    defaults_version: 1
    series_column_widths:
      cdg_tax_live_detail_reports.created_date_millisecond4: 168
      cdg_tax_live_detail_reports.Greater_15_Sec: 75
      cdg_tax_live_detail_reports.fulfillment_date_millisecond4: 183
      cdg_tax_live_detail_reports.TB_1: 75
    listen:
      'TAX Reports Filter : Created Date': cdg_tax_live_detail_reports.Created_DateTB1
    row: 9
    col: 0
    width: 24
    height: 6
  filters:
  - name: TAX Turn Around - Monthly Filter
    title: TAX Turn Around - Monthly Filter
    type: field_filter
    default_value: 12 months
    allow_multiple_values: true
    required: false
    model: gateway_cdg
    explore: cdg_tax_live
    listens_to_filters: []
    field: cdg_tax_live.Tax_Days_Date_date
  - name: TAX Turn Around - Daily Filter
    title: TAX Turn Around - Daily Filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: gateway_cdg
    explore: cdg_tax_live_Daily
    listens_to_filters: []
    field: cdg_tax_live_Daily.Tax_Days_Date
  - name: 'TAX Reports Filter : Created Date'
    title: 'TAX Reports Filter : Created Date'
    type: field_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
    model: gateway_cdg
    explore: cdg_tax_live_detail_reports
    listens_to_filters: []
    field: cdg_tax_live_detail_reports.Created_DateTB1

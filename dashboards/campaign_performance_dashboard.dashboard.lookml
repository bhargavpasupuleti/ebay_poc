- dashboard: campaign_performance_dashboard
  title: Campaign Performance Overview
  layout: newspaper
  preferred_viewer: dashboards-next
  description:  view of CRM campaign performance across Push, Hub, and Email channels.

  # ====================================================================
  # FILTERS  (8 total - all cross-filter every tile via "listen")
  # ====================================================================
  filters:
  - name: date_range
    title: Date Range
    type: field_filter
    default_value: 90 days
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.actn_date
    allow_multiple_values: true

  - name: channel_filter
    title: Channel
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.channel
    allow_multiple_values: true

  - name: comm_type_filter
    title: Communication Type
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.comm_type
    allow_multiple_values: true

  - name: buyer_segment_filter
    title: Buyer Value Segment
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.buyer_value_segment
    allow_multiple_values: true

  - name: lifecycle_filter
    title: Lifecycle Segment
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.lifecycle_segment
    allow_multiple_values: true

  - name: user_status_filter
    title: User Status
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.user_status
    allow_multiple_values: true

  - name: suppressed_filter
    title: Suppressed?
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.suppress_flag

  - name: crm_flag_filter
    title: CRM Flag
    type: field_filter
    default_value: ''
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    field: campaign_insights.crm_flag
    allow_multiple_values: true

  # ====================================================================
  # KPI CARDS  (8 single-value tiles, row 0-8)
  # ====================================================================
  elements:
  - name: Total Sends
    title: Total Sends
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_sends]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 0
    col: 0
    width: 6
    height: 4

  - name: Total Clicks
    title: Total Clicks
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_clicks]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 0
    col: 6
    width: 6
    height: 4

  - name: CTR %
    title: Click-Through Rate
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.ctr_pct]
    # conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
    #     font_color: !!null '', color_application: {collection_id: green-yellow-red,
    #       palette_id: green-yellow-red-by-tier}}]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 0
    col: 12
    width: 6
    height: 4

  - name: Unsubscribe Rate %
    title: Unsubscribe Rate
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.unsub_rate_pct]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 0
    col: 18
    width: 6
    height: 4

  - name: Incremental GMB
    title: Incremental GMB (iGMB)
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_igmb]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 4
    col: 0
    width: 6
    height: 4

  - name: Attributed GMV
    title: Attributed GMV (aGMV)
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_agmv]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 4
    col: 6
    width: 6
    height: 4

  - name: Net GMB
    title: Net GMB
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_net_gmb]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 4
    col: 12
    width: 6
    height: 4

  - name: Opt-Out Cost
    title: Opt-Out Cost
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: single_value
    fields: [campaign_insights.total_optout_cost]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 4
    col: 18
    width: 6
    height: 4

  # ====================================================================
  # VISUALIZATIONS  (12 tiles, row 8+)
  # ====================================================================

  # 1. Sends & Clicks trend
  - name: Sends & Clicks Over Time
    title: Sends & Clicks Over Time
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_line
    fields: [campaign_insights.actn_week, campaign_insights.total_sends, campaign_insights.total_clicks]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 8
    col: 0
    width: 12
    height: 8

  # 2. CTR trend by channel
  - name: CTR % Trend by Channel
    title: CTR % Trend by Channel
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_line
    fields: [campaign_insights.actn_week, campaign_insights.channel, campaign_insights.ctr_pct]
    pivots: [campaign_insights.channel]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 8
    col: 12
    width: 12
    height: 8

  # 3. Incremental GMB by channel
  - name: Incremental GMB by Channel
    title: Incremental GMB by Channel
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_bar
    fields: [campaign_insights.channel, campaign_insights.total_igmb]
    sorts: [campaign_insights.total_igmb desc]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 16
    col: 0
    width: 8
    height: 8

  # 4. Attributed GMV by buyer value segment
  - name: Attributed GMV by Buyer Segment
    title: Attributed GMV by Buyer Segment
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_pie
    fields: [campaign_insights.buyer_value_segment, campaign_insights.total_agmv]
    sorts: [campaign_insights.buyer_value_segment_sort]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 16
    col: 8
    width: 8
    height: 8

  # 5. Sends & GMB by comm type
  - name: Sends & GMB by Comm Type
    title: Sends & Incremental GMB by Comm Type
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_column
    fields: [campaign_insights.comm_type, campaign_insights.total_sends, campaign_insights.total_igmb]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 16
    col: 16
    width: 8
    height: 8

  # 6. Engagement funnel (Sends -> Clicks -> QV -> Buyer QV)
  - name: Engagement Funnel
    title: "Engagement Funnel: Sends -> Clicks -> QV -> Buyers"
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_column
    fields: [campaign_insights.total_sends, campaign_insights.total_clicks,
      campaign_insights.total_qualified_visits, campaign_insights.total_buyer_qv]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 24
    col: 0
    width: 8
    height: 8

  # 7. Channel x Comm Type CTR heatmap (table + conditional formatting)
  - name: CTR Heatmap - Channel x Comm Type
    title: CTR % by Channel and Comm Type
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_grid
    fields: [campaign_insights.channel, campaign_insights.comm_type, campaign_insights.ctr_pct]
    pivots: [campaign_insights.comm_type]
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: green-yellow-red,
          palette_id: green-yellow-red-by-tier}}]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 24
    col: 8
    width: 16
    height: 8

  # 8. Top 10 programs by incremental GMB
  - name: Top 10 Programs by iGMB
    title: Top 10 Programs by Incremental GMB
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_bar
    fields: [campaign_insights.program_name, campaign_insights.total_igmb, campaign_insights.total_sends]
    sorts: [campaign_insights.total_igmb desc]
    limit: 10
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 32
    col: 0
    width: 12
    height: 8

  # 9. Lifecycle segment performance
  - name: Lifecycle Segment Performance
    title: Sends by Lifecycle Segment and Channel
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_bar
    fields: [campaign_insights.lifecycle_segment, campaign_insights.channel, campaign_insights.total_sends]
    pivots: [campaign_insights.channel]
    stacking: normal
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 32
    col: 12
    width: 12
    height: 8

  # 10. Unsubscribe rate by channel
  - name: Unsubscribe Rate by Channel
    title: Unsubscribe Rate by Channel
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_bar
    fields: [campaign_insights.channel, campaign_insights.unsub_rate_pct]
    sorts: [campaign_insights.unsub_rate_pct desc]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 40
    col: 0
    width: 8
    height: 8

  # 11. Opt-out cost vs incremental GMB (ROI scatter) by program
  - name: Opt-Out Cost vs Incremental GMB
    title: Opt-Out Cost vs Incremental GMB by Program
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_scatter
    fields: [campaign_insights.program_name, campaign_insights.total_optout_cost, campaign_insights.total_igmb]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 40
    col: 8
    width: 8
    height: 8

  # 12. Suppressed vs non-suppressed comparison
  - name: Suppressed vs Active Audience Performance
    title: Suppressed vs Active Audience Performance
    model: ebay_conversational_analytics_poc
    explore: campaign_insights
    type: looker_column
    fields: [campaign_insights.suppress_flag, campaign_insights.total_sends, campaign_insights.total_igmb]
    listen:
      date_range: campaign_insights.actn_date
      channel_filter: campaign_insights.channel
      comm_type_filter: campaign_insights.comm_type
      buyer_segment_filter: campaign_insights.buyer_value_segment
      lifecycle_filter: campaign_insights.lifecycle_segment
      user_status_filter: campaign_insights.user_status
      suppressed_filter: campaign_insights.suppress_flag
      crm_flag_filter: campaign_insights.crm_flag
    row: 40
    col: 16
    width: 8
    height: 8

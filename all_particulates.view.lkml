view: all_particulates {
  derived_table: {
    sql: SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_hourly_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_hourly_summary`
       ;;


    sql_trigger_value: SELECT CURRENT_DATE();;

  }

dimension: key {
  primary_key: yes
  hidden: yes
  type: string
  sql: CONCAT(${state_code}," ",${county_code}," ",${site_num},CAST(${date_gmt_date} AS string)," ",${time_gmt}," ", CAST(${poc} AS string)," ",CAST(${parameter_code} AS string)) ;;
}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  dimension: county_code {
    type: string
    sql: ${TABLE}.county_code ;;
  }

  dimension: site_num {
    type: string
    sql: ${TABLE}.site_num ;;
  }

  dimension: parameter_code {
    type: number
    sql: ${TABLE}.parameter_code ;;
  }

  dimension: poc {
    type: number
    sql: ${TABLE}.poc ;;
  }

  dimension: latitude {
    type: string
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: string
    sql: ${TABLE}.longitude ;;
  }

  dimension: datum {
    type: string
    sql: ${TABLE}.datum ;;
  }

  parameter: pullutant_type {
    type: string
    allowed_value: {
      label: "PM 10 microns"
      value: "PM10 Total 0-10um STP"
    }
    allowed_value: {
      label: "PM 2.5 microns"
      value: "PM2.5 - Local Conditions"
    }

  }

  dimension: parameter_name {
    type: string
    sql: ${TABLE}.parameter_name ;;
  }

#   dimension: pm10 {
#     type: string
#     sql: CASE WHEN ${parameter_name}="PM10 Total 0-10um STP"
#          THEN "PM10 Total 0-10um STP"
#          ELSE null
#         END
#     ;;
#   }
#
#   dimension: pm25 {
#     type: string
#     sql: CASE WHEN ${parameter_name}="PM2.5 - Local Conditions"
#          THEN "PM2.5 - Local Conditions"
#          ELSE null
#         END
#     ;;
#   }

  dimension: pollutant_type_name {
    type: string
#     sql: ${TABLE}.parameter_name ;;
    sql:CASE
         WHEN {% parameter pullutant_type %} = "PM10 Total 0-10um STP" THEN
           ${parameter_name}= "PM10 Total 0-10um STP"
         WHEN {% parameter pullutant_type %} = "PM2.5 - Local Conditions" THEN
           ${parameter_name}= "PM2.5 - Local Conditions"
         ELSE
           NULL
       END ;;

  }

  dimension_group: date_local {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.date_local AS timestamp) ;;
  }

  dimension: time_local {
    type: string
    sql: ${TABLE}.time_local ;;
  }

  dimension_group: date_gmt {
    type: time
    datatype: datetime
    timeframes:
                [raw,
                date,
                time,
                year,
                week,
                month,
                quarter,
                month_num,
                month_name]
    sql: CAST(${TABLE}.date_gmt AS timestamp);;
    drill_fields: [date_gmt_raw, date_gmt_date,date_gmt_year,date_gmt_month,date_gmt_month_num]

  }

  dimension: month_name{
    type: string
    sql: ${date_gmt_month_name} ;;
    link: {
      label: "Month Dashboard"
      url: "https://localhost:9999/dashboards/13?&f[all_particulates.date_gmt_month_num]={{ _filters['all_particulates.date_gmt_month_num'] | url_encode }}&f[all_particulates.date_gmt_month]={{ _filters['all_particulates.date_gmt_month'] | url_encode }}&f[all_particulates.parameter_name]={{ _filters['all_particulates.parameter_name'] | url_encode }}"

#       icon_url: "https://looker.com/favicon.ico"
    }
  }

# dimension: month {
#   type: string
#   sql: ${date_gmt_month};;

#   }

#[Analytic Block] Dynamic Previous Period Analysis using date_start, date_end
#   filter: previous_period_filter {
#     type: date
#     description: "Use this filter for period analysis"
#   }
#
#   dimension: previous_period {
#     type: string
#     description: "The reporting period as selected by the Previous Period Filter"
#     sql:
#         CASE
#           WHEN {% date_start previous_period_filter %} IS NOT NULL AND {% date_end previous_period_filter %} IS NOT NULL /* date ranges or in the past x days */
#             THEN
#               CASE
#                 WHEN ${date_gmt_raw} >=  {% date_start previous_period_filter %}
#                   AND ${date_gmt_raw} <= {% date_end previous_period_filter %}
#                   THEN 'This Period'
#                 WHEN ${date_gmt_raw} >= DATE_SUB(DATE_ADD({% date_start previous_period_filter %}, INTERVAL 1 DAY), INTERVAL CAST((-1*DATE_DIFF({% date_start previous_period_filter %}, {% date_end previous_period_filter %},day) + 1) AS INT64 ) DAY )
#                   AND ${date_gmt_raw} < DATE_SUB({% date_start previous_period_filter %}, INTERVAL 1 DAY)
#                   -- + 1
#                   THEN 'Previous Period'
#               END
#           WHEN {% date_start previous_period_filter %} IS NULL AND {% date_end previous_period_filter %} IS NULL /* has any value or is not null */
#             THEN CASE WHEN ${date_gmt_raw} IS NOT NULL THEN 'Has Value' ELSE 'Is Null' END
#           WHEN {% date_start previous_period_filter %} IS NULL AND {% date_end previous_period_filter %} IS NOT NULL /* on or before */
#             THEN
#               CASE
#                 WHEN  ${date_gmt_raw} <=  {% date_end previous_period_filter %} THEN 'In Period'
#                 WHEN  ${date_gmt_raw} >   {% date_end previous_period_filter %} THEN 'Not In Period'
#               END
#          WHEN {% date_start previous_period_filter %} IS NOT NULL AND {% date_end previous_period_filter %} IS NULL /* on or after */
#            THEN
#              CASE
#                WHEN  ${date_gmt_raw} >= {% date_start previous_period_filter %} THEN 'In Period'
#                WHEN  ${date_gmt_raw} < {% date_start previous_period_filter %} THEN 'Not In Period'
#             END
#         END ;;
#   }

#END BLOCK

  dimension: time_gmt {
    type: string
    sql: ${TABLE}.time_gmt  ;;
  }

  dimension: sample_measurement {
    type: number
    sql: ${TABLE}.sample_measurement ;;

  }

  dimension: units_of_measure {
    type: string
    sql: ${TABLE}.units_of_measure ;;
  }

  dimension: mdl {
    type: string
    sql: ${TABLE}.mdl ;;
  }

  dimension: uncertainty {
    type: string
    sql: ${TABLE}.uncertainty ;;
  }

  dimension: qualifier {
    type: string
    sql: ${TABLE}.qualifier ;;
  }

  dimension: method_type {
    type: string
    sql: ${TABLE}.method_type ;;
  }

  dimension: method_code {
    type: string
    sql: ${TABLE}.method_code ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
    link: {
      label: "County Information"
      url: "https://localhost:9999/dashboards/15?County={{ _filters[all_particulates_rank.county_name'] | url_encode }}"
    }
  }

  dimension: date_of_last_change {
    type: date
    sql: ${TABLE}.date_of_last_change ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  #measures for sample measurement
  measure: avg_sample_measurement {
    type: average
    sql: ${TABLE}.sample_measurement ;;
    value_format: "0.##"
    drill_fields: [min_sample_measurement,max_sample_measurement,date_gmt_month]
  }

  measure: sum_sample_measurement{
    type: sum
    sql: ${TABLE}.sample_measurement ;;
  }

  # returns the midpoint value for the values in a given field
  measure: median_sample_measurement{
    type: median
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: max_sample_measurement{
    type: max
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: min_sample_measurement{
    type: min
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: sample_measurement_25_percentile{
    type: percentile
    percentile: 25
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: sample_measurement_50_percentile{
    type: percentile
    percentile: 50
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: sample_measurement_75_percentile{
    type: percentile
    percentile: 75
    sql: ${TABLE}.sample_measurement ;;
  }

  measure: sample_measurement_90_percentile{
    type: percentile
    percentile: 90
    sql: ${TABLE}.sample_measurement ;;
  }

  # measures end



  set: detail {
    fields: [
      state_code,
      county_code,
      site_num,
      parameter_code,
      poc,
      latitude,
      longitude,
      datum,
      parameter_name,
      time_local,
      time_gmt,
      sample_measurement,
      units_of_measure,
      mdl,
      uncertainty,
      qualifier,
      method_type,
      method_code,
      method_name,
      state_name,
      county_name,
      date_of_last_change,
      location
    ]
  }
}

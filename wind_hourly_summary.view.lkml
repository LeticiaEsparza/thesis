view: wind_hourly_summary {
  sql_table_name: epa_historical_air_quality.wind_hourly_summary ;;

  dimension: key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${state_name}," ",CAST(${date_gmt_raw} AS string)," ", ${time_gmt}," ", ${county_name}," ",CAST(${site_num} AS string),
    "",CAST(${parameter_code} AS string)," ",CAST(${poc} AS string)) ;;
  }

  dimension: county_code {
    type: string
    sql: ${TABLE}.county_code ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension_group: date_gmt {
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
    sql: CAST(${TABLE}.date_gmt AS timestamp);;
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
    sql: ${TABLE}.date_local ;;
  }

  dimension_group: date_of_last_change {
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
    sql: ${TABLE}.date_of_last_change ;;
  }

  dimension: datum {
    type: string
    sql: ${TABLE}.datum ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: mdl {
    type: number
    sql: ${TABLE}.mdl ;;
  }

  dimension: method_code {
    type: number
    sql: ${TABLE}.method_code ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: method_type {
    type: string
    sql: ${TABLE}.method_type ;;
  }

  dimension: parameter_code {
    type: number
    sql: ${TABLE}.parameter_code ;;
  }

  dimension: parameter_name {
    type: string
    sql: ${TABLE}.parameter_name ;;
  }

  dimension: poc {
    type: number
    sql: ${TABLE}.poc ;;
  }

  dimension: qualifier {
    type: string
    sql: ${TABLE}.qualifier ;;
  }

  dimension: sample_measurement {
    type: number
    sql: ${TABLE}.sample_measurement ;;
  }

  dimension: sample_tier{
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90]
    style: integer
    sql: ${sample_measurement} ;;
  }

  dimension: site_num {
    type: string
    sql: ${TABLE}.site_num ;;
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: time_gmt {
    type: string
    sql: ${TABLE}.time_gmt ;;
  }

  dimension: time_local {
    type: string
    sql: ${TABLE}.time_local ;;
  }

  dimension: uncertainty {
    type: number
    sql: ${TABLE}.uncertainty ;;
  }

  dimension: units_of_measure {
    type: string
    sql: ${TABLE}.units_of_measure ;;
  }

  measure: count {
    type: count
    drill_fields: [parameter_name, county_name, method_name, state_name]
  }


  #measures for sample measurement
  measure: avg_sample_measurement {
    type: average
    sql: ${TABLE}.sample_measurement ;;
    value_format: "0.##"
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


}

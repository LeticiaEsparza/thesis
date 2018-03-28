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

  dimension: parameter_name {
    type: string
    sql: ${TABLE}.parameter_name ;;
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

  dimension: time_local {
    type: string
    sql: ${TABLE}.time_local ;;
  }

  dimension_group: date_gmt {
    type: time
    datatype: datetime
    timeframes: [raw,date,time,year,week,month,quarter]
    sql: CAST(${TABLE}.date_gmt AS timestamp);;
  }



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

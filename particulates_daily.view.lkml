view: particulates_daily {
  derived_table: {
    sql: SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_daily_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_daily_summary`
       ;;
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
    type: string
    sql: ${TABLE}.parameter_code ;;
  }

  dimension: poc {
    type: string
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

  dimension: sample_duration {
    type: string
    sql: ${TABLE}.sample_duration ;;
  }

  dimension: pollutant_standard {
    type: string
    sql: ${TABLE}.pollutant_standard ;;
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


  dimension: units_of_measure {
    type: string
    sql: ${TABLE}.units_of_measure ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: observation_count {
    type: string
    sql: ${TABLE}.observation_count ;;
  }

  dimension: observation_percent {
    type: string
    sql: ${TABLE}.observation_percent ;;
  }

  dimension: arithmetic_mean {
    type: string
    sql: ${TABLE}.arithmetic_mean ;;
  }

  dimension: first_max_value {
    type: string
    sql: ${TABLE}.first_max_value ;;
  }

  dimension: first_max_hour {
    type: string
    sql: ${TABLE}.first_max_hour ;;
  }

  dimension: aqi {
    type: number
    sql: ${TABLE}.aqi ;;
  }

measure: avg_aqi {
    type: average
    sql: ${aqi} ;;
}

  dimension: method_code {
    type: string
    sql: ${TABLE}.method_code ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: local_site_name {
    type: string
    sql: ${TABLE}.local_site_name ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }

  dimension: cbsa_name {
    type: string
    sql: ${TABLE}.cbsa_name ;;
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

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

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
      sample_duration,
      pollutant_standard,
      units_of_measure,
      event_type,
      observation_count,
      observation_percent,
      arithmetic_mean,
      first_max_value,
      first_max_hour,
      aqi,
      method_code,
      method_name,
      local_site_name,
      address,
      state_name,
      county_name,
      city_name,
      cbsa_name,
      location
    ]
  }
}

view: all_particulates_daily_past_10_years {
  derived_table: {
    sql: WITH particulates_daily AS (SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_daily_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_daily_summary`
       )
SELECT
  *
FROM particulates_daily

WHERE (particulates_daily.sample_duration = '24 HOUR') AND ((((particulates_daily.date_local ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))) AND (particulates_daily.date_local ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 10 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY))))))) AND (NOT (particulates_daily.aqi  IS NULL))

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

#   dimension: date_local {
#     type: date
#     sql: ${TABLE}.date_local ;;
#   }
#
  dimension_group: date_local {
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
    sql: ${TABLE}.date_local;;

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
    type: string
    sql: ${TABLE}.aqi ;;
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

  dimension: date_of_last_change {
    type: date
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
      date_of_last_change,
      location
    ]
  }
}

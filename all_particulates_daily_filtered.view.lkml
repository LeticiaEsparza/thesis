view: all_particulates_daily_filtered{
  derived_table: {
    sql: WITH particulates_daily AS (SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_daily_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_daily_summary`
       )
SELECT
  *
FROM particulates_daily

WHERE (particulates_daily.sample_duration = '24 HOUR')
-- AND ((((particulates_daily.date_local ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))) AND (particulates_daily.date_local ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 10 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))))))
AND (NOT (particulates_daily.aqi  IS NULL))

 ;;
    sql_trigger_value: SELECT CURRENT_DATE();;
  }

dimension: key {
#   primary_key: yes
  type: string
  sql: CONCAT(CAST(${date_local_date} AS string), ${county_name}, CAST(${site_num} AS string), CAST(${method_code} AS string),
  CAST(${poc} AS string),${city_name}, ${address}, CAST(${aqi} AS string), CAST(${arithmetic_mean} AS string),${cbsa_name}, ${county_code}, ${datum},
  CAST(${first_max_hour} AS string),CAST(${first_max_value} AS string),${local_site_name}, ${method_name}, ${parameter_name},${pollutant_standard},${state_name},
  ${event_type}) ;;
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
    sql: CAST(${TABLE}.date_local AS timestamp);;

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
    type: number
    sql: ${TABLE}.arithmetic_mean ;;
  }

  dimension: first_max_value {
    type: number
    sql: ${TABLE}.first_max_value ;;
  }

  dimension: first_max_hour {
    type: number
    sql: ${TABLE}.first_max_hour ;;
  }

  dimension: aqi {
    type: number
    sql: ${TABLE}.aqi ;;
    html:
    {% if value >= 0 and value <= 50 %}
    <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
    {% elsif value > 50 and value <= 100  %}
    <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
    {% elsif value > 100 and value <= 150  %}
    <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value > 150 and value <= 200  %}
    <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value > 200 and value <= 300  %}
    <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% else %}
    <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% endif %}
    ;;
#     value_format: "0.##"
  }

  #measures for aqi
  measure: avg_aqi {
    type: average
    sql: ${aqi} ;;
    html:
    {% if value >= 0 and value <= 50 %}
    <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
    {% elsif value > 50 and value <= 100  %}
    <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
    {% elsif value > 100 and value <= 150  %}
    <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value > 150 and value <= 200  %}
    <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value > 200 and value <= 300  %}
    <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% else %}
    <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% endif %}
    ;;
    value_format: "0.##"
  }



  # returns the midpoint value for the values in a given field
  measure: median_aqi{
    type: median
    sql: ${TABLE}.aqi ;;
  }

  measure: max_aqi{
    type: max
    sql: ${TABLE}.aqi ;;
  }

  measure: min_aqi{
    type: min
    sql: ${TABLE}.aqi ;;
  }

  measure: aqi_25_percentile{
    type: percentile
    percentile: 25
    sql: ${TABLE}.aqi ;;
  }

  measure: aqi_50_percentile{
    type: percentile
    percentile: 50
    sql: ${TABLE}.aqi;;
  }

  measure: aqi_75_percentile{
    type: percentile
    percentile: 75
    sql: ${TABLE}.aqi ;;
  }

  measure: aqi_90_percentile{
    type: percentile
    percentile: 90
    sql: ${TABLE}.aqi ;;
  }

  # measures end





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
    link: {
      label: "County Information"
      url: "https://localhost:9999/dashboards/15?County={{ _filters[all_particulates_rank.county_name'] | url_encode }}"
    }
  }

  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }

  dimension: cbsa_name {
    type: string
    sql: ${TABLE}.cbsa_name ;;
  }
#
#   dimension: date_of_last_change {
#     type: date
#     sql: ${TABLE}.date_of_last_change ;;
#   }

  dimension_group: date_of_last_change {
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
    sql: CAST(${TABLE}.date_of_last_change AS timestamp);;

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

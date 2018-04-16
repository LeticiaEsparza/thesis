view: particulates_daily_top_counties {
  derived_table: {
    sql: WITH particulates_daily AS (SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_daily_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_daily_summary`
       )
SELECT
  particulates_daily.address  AS address,
  particulates_daily.aqi  AS aqi,
  particulates_daily.arithmetic_mean  AS arithmetic_mean,
  particulates_daily.cbsa_name  AS cbsa_name,
  particulates_daily.city_name  AS city_name,
  particulates_daily.county_code  AS county_code,
  particulates_daily.county_name  AS county_name,
  CAST(CAST(particulates_daily.date_local  AS TIMESTAMP) AS DATE) AS date_local_date,
  CAST(CAST(particulates_daily.date_of_last_change  AS TIMESTAMP) AS DATE) AS date_of_last_change_date,
  particulates_daily.datum  AS datum,
  particulates_daily.event_type  AS event_type,
  particulates_daily.first_max_hour  AS first_max_hour,
  particulates_daily.first_max_value  AS first_max_value,
  particulates_daily.latitude  AS latitude,
  particulates_daily.local_site_name  AS local_site_name,
  IF(particulates_daily.latitude  IS NOT NULL AND particulates_daily.longitude  IS NOT NULL, CONCAT(IFNULL(CAST(particulates_daily.latitude  AS STRING), ''),',',IFNULL(CAST(particulates_daily.longitude  AS STRING), '')), NULL) AS location,
  particulates_daily.longitude  AS longitude,
  particulates_daily.method_code  AS method_code,
  particulates_daily.method_name  AS method_name,
  particulates_daily.observation_count  AS observation_count,
  particulates_daily.observation_percent  AS observation_percent,
  particulates_daily.parameter_code  AS parameter_code,
  particulates_daily.parameter_name  AS parameter_name,
  particulates_daily.poc  AS poc,
  particulates_daily.pollutant_standard  AS pollutant_standard,
  particulates_daily.sample_duration  AS sample_duration,
  particulates_daily.site_num  AS site_num,
  particulates_daily.state_code  AS state_code,
  particulates_daily.state_name  AS state_name,
  particulates_daily.units_of_measure  AS units_of_measure,
  COUNT(*) AS count,
  AVG(particulates_daily.aqi ) AS avg_aqi,
  RANK() OVER (PARTITION BY county_name ORDER BY  AVG(particulates_daily.aqi ) DESC) AS RANK
FROM particulates_daily

WHERE (particulates_daily.sample_duration = '24 HOUR') AND ((((particulates_daily.date_local ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))) AND (particulates_daily.date_local ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 10 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))))))
GROUP BY
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
HAVING
  NOT (AVG(particulates_daily.aqi ) IS NULL)
 ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: aqi {
    type: string
    sql: ${TABLE}.aqi ;;
  }

  dimension: arithmetic_mean {
    type: string
    sql: ${TABLE}.arithmetic_mean ;;
  }

  dimension: cbsa_name {
    type: string
    sql: ${TABLE}.cbsa_name ;;
  }

  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }

  dimension: county_code {
    type: string
    sql: ${TABLE}.county_code ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension: date_local_date {
    type: date
    sql: ${TABLE}.date_local_date ;;
  }

  dimension: date_of_last_change_date {
    type: date
    sql: ${TABLE}.date_of_last_change_date ;;
  }

  dimension: datum {
    type: string
    sql: ${TABLE}.datum ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: first_max_hour {
    type: string
    sql: ${TABLE}.first_max_hour ;;
  }

  dimension: first_max_value {
    type: string
    sql: ${TABLE}.first_max_value ;;
  }

  dimension: latitude {
    type: string
    sql: ${TABLE}.latitude ;;
  }

  dimension: local_site_name {
    type: string
    sql: ${TABLE}.local_site_name ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: longitude {
    type: string
    sql: ${TABLE}.longitude ;;
  }

  dimension: method_code {
    type: string
    sql: ${TABLE}.method_code ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: observation_count {
    type: string
    sql: ${TABLE}.observation_count ;;
  }

  dimension: observation_percent {
    type: string
    sql: ${TABLE}.observation_percent ;;
  }

  dimension: parameter_code {
    type: string
    sql: ${TABLE}.parameter_code ;;
  }

  dimension: parameter_name {
    type: string
    sql: ${TABLE}.parameter_name ;;
  }

  dimension: poc {
    type: string
    sql: ${TABLE}.poc ;;
  }

  dimension: pollutant_standard {
    type: string
    sql: ${TABLE}.pollutant_standard ;;
  }

  dimension: sample_duration {
    type: string
    sql: ${TABLE}.sample_duration ;;
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

  dimension: units_of_measure {
    type: string
    sql: ${TABLE}.units_of_measure ;;
  }

  measure: count {
    type: string
    sql: ${TABLE}.count ;;
  }

  dimension: avg_aqi {
    hidden: yes
    type: string
    sql: ${TABLE}.avg_aqi ;;
  }

  measure: average_aqi {
    type: average
    sql: ${TABLE}.aqi ;;
  }

  dimension: rank_a {
    hidden: yes
    type: string
    sql: ${TABLE}.RANK ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.RANK ;;
  }


  set: detail {
    fields: [
      address,
      aqi,
      arithmetic_mean,
      cbsa_name,
      city_name,
      county_code,
      county_name,
      date_local_date,
      date_of_last_change_date,
      datum,
      event_type,
      first_max_hour,
      first_max_value,
      latitude,
      local_site_name,
      location,
      longitude,
      method_code,
      method_name,
      observation_count,
      observation_percent,
      parameter_code,
      parameter_name,
      poc,
      pollutant_standard,
      sample_duration,
      site_num,
      state_code,
      state_name,
      units_of_measure,
      count,
      avg_aqi,
      rank
    ]
  }
}

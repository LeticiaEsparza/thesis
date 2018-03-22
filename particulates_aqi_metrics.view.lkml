view: particulates_aqi_metrics {
  derived_table: {
    sql: -- use existing all_particulates in `future-pager-187318.looker_scratch.LR_EY1VTG8B13ACOA4W44OHH_all_particulates`
      SELECT
        all_particulates.county_code  AS all_particulates_county_code,
        all_particulates.state_code  AS all_particulates_state_code,
        all_particulates.site_num  AS all_particulates_site_num,
        CAST(all_particulates.date_gmt  AS DATE) AS all_particulates_date_gmt_date,
        all_particulates.time_gmt   AS all_particulates_time_gmt,
        MAX(all_particulates.sample_measurement ) AS all_particulates_max_sample_measurement,
        MIN(all_particulates.sample_measurement ) AS all_particulates_min_sample_measurement,
        MAX(pressure_hourly_summary.sample_measurement ) AS pressure_hourly_summary_max_sample_measurement,
        MIN(pressure_hourly_summary.sample_measurement ) AS pressure_hourly_summary_min_sample_measurement,
        MAX(rh_and_dp_hourly_summary.sample_measurement ) AS rh_and_dp_hourly_summary_max_sample_measurement,
        MIN(rh_and_dp_hourly_summary.sample_measurement ) AS rh_and_dp_hourly_summary_min_sample_measurement,
        MAX(temperature_hourly_summary.sample_measurement ) AS temperature_hourly_summary_max_sample_measurement,
        MIN(temperature_hourly_summary.sample_measurement ) AS temperature_hourly_summary_min_sample_measurement,
        MAX(wind_hourly_summary.sample_measurement ) AS wind_hourly_summary_max_sample_measurement,
        MIN(wind_hourly_summary.sample_measurement ) AS wind_hourly_summary_min_sample_measurement
      FROM `future-pager-187318.looker_scratch.LR_EY1VTG8B13ACOA4W44OHH_all_particulates` AS all_particulates
      INNER JOIN looker_scratch.wind_hourly_summary  AS wind_hourly_summary ON all_particulates.state_code = wind_hourly_summary.state_code
              AND all_particulates.county_code = wind_hourly_summary.county_code
              AND all_particulates.site_num = wind_hourly_summary.site_num
              AND all_particulates.date_gmt = wind_hourly_summary.date_gmt
              AND all_particulates.time_gmt = wind_hourly_summary.time_gmt
              AND wind_hourly_summary.units_of_measure = "Knots"

      INNER JOIN looker_scratch.temperature_hourly_summary  AS temperature_hourly_summary ON all_particulates.state_code = temperature_hourly_summary.state_code
              AND all_particulates.county_code = temperature_hourly_summary.county_code
              AND all_particulates.site_num = temperature_hourly_summary.site_num
              AND all_particulates.date_gmt = temperature_hourly_summary.date_gmt
              AND all_particulates.time_gmt = temperature_hourly_summary.time_gmt

      INNER JOIN looker_scratch.pressure_hourly_summary  AS pressure_hourly_summary ON all_particulates.state_code = pressure_hourly_summary.state_code
              AND all_particulates.county_code = pressure_hourly_summary.county_code
              AND all_particulates.site_num = pressure_hourly_summary.site_num
              AND all_particulates.date_gmt = pressure_hourly_summary.date_gmt
              AND all_particulates.time_gmt = pressure_hourly_summary.time_gmt

      INNER JOIN looker_scratch.rh_and_dp_hourly_summary  AS rh_and_dp_hourly_summary ON all_particulates.state_code = rh_and_dp_hourly_summary.state_code
              AND all_particulates.county_code = rh_and_dp_hourly_summary.county_code
              AND all_particulates.site_num = rh_and_dp_hourly_summary.site_num
              AND all_particulates.date_gmt = rh_and_dp_hourly_summary.date_gmt
              AND all_particulates.time_gmt = rh_and_dp_hourly_summary.time_gmt



      GROUP BY 1,2,3,4,5
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: all_particulates_county_code {
    type: string
    sql: ${TABLE}.all_particulates_county_code ;;
  }

  dimension: all_particulates_state_code {
    type: string
    sql: ${TABLE}.all_particulates_state_code ;;
  }

  dimension: all_particulates_site_num {
    type: string
    sql: ${TABLE}.all_particulates_site_num ;;
  }

  dimension: all_particulates_date_gmt_date {
    type: date
    sql: ${TABLE}.all_particulates_date_gmt_date ;;
  }

  dimension: all_particulates_time_gmt {
    type: string
    sql: ${TABLE}.all_particulates_time_gmt ;;
  }

  dimension: all_particulates_max_sample_measurement {
    type: string
    sql: ${TABLE}.all_particulates_max_sample_measurement ;;
  }

  dimension: all_particulates_min_sample_measurement {
    type: string
    sql: ${TABLE}.all_particulates_min_sample_measurement ;;
  }

  dimension: pressure_hourly_summary_max_sample_measurement {
    type: string
    sql: ${TABLE}.pressure_hourly_summary_max_sample_measurement ;;
  }

  dimension: pressure_hourly_summary_min_sample_measurement {
    type: string
    sql: ${TABLE}.pressure_hourly_summary_min_sample_measurement ;;
  }

  dimension: rh_and_dp_hourly_summary_max_sample_measurement {
    type: string
    sql: ${TABLE}.rh_and_dp_hourly_summary_max_sample_measurement ;;
  }

  dimension: rh_and_dp_hourly_summary_min_sample_measurement {
    type: string
    sql: ${TABLE}.rh_and_dp_hourly_summary_min_sample_measurement ;;
  }

  dimension: temperature_hourly_summary_max_sample_measurement {
    type: string
    sql: ${TABLE}.temperature_hourly_summary_max_sample_measurement ;;
  }

  dimension: temperature_hourly_summary_min_sample_measurement {
    type: string
    sql: ${TABLE}.temperature_hourly_summary_min_sample_measurement ;;
  }

  dimension: wind_hourly_summary_max_sample_measurement {
    type: string
    sql: ${TABLE}.wind_hourly_summary_max_sample_measurement ;;
  }

  dimension: wind_hourly_summary_min_sample_measurement {
    type: string
    sql: ${TABLE}.wind_hourly_summary_min_sample_measurement ;;
  }

  set: detail {
    fields: [
      all_particulates_county_code,
      all_particulates_state_code,
      all_particulates_site_num,
      all_particulates_date_gmt_date,
      all_particulates_time_gmt,
      all_particulates_max_sample_measurement,
      all_particulates_min_sample_measurement,
      pressure_hourly_summary_max_sample_measurement,
      pressure_hourly_summary_min_sample_measurement,
      rh_and_dp_hourly_summary_max_sample_measurement,
      rh_and_dp_hourly_summary_min_sample_measurement,
      temperature_hourly_summary_max_sample_measurement,
      temperature_hourly_summary_min_sample_measurement,
      wind_hourly_summary_max_sample_measurement,
      wind_hourly_summary_min_sample_measurement
    ]
  }
}

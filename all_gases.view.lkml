view: all_gases {
  derived_table: {
    sql: SELECT * FROM `future-pager-187318.looker_scratch.o3_hourly_summary`
      UNION ALL
      SELECT * FROM `future-pager-187318.looker_scratch.co_hourly_summary`
      UNION ALL
      SELECT * FROM `future-pager-187318.looker_scratch.no2_hourly_summary`
      UNION ALL
      SELECT * FROM `future-pager-187318.looker_scratch.so2_hourly_summary`
       ;;
    sql_trigger_value: SELECT CURRENT_DATE();;

  }

# dimension: key {
#   type: string
#   sql: CONCAT() ;;
# }

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

  dimension: date_local {
    type: date
    sql: ${TABLE}.date_local ;;
  }

  dimension: time_local {
    type: string
    sql: ${TABLE}.time_local ;;
  }

#   dimension: date_gmt {
#     type: date
#     sql: ${TABLE}.date_gmt ;;
#   }

  dimension_group: date_gmt {
    type: time
    datatype: datetime
    timeframes: [raw,date,time,year,week,month,quarter]
    sql: ${TABLE}.date_gmt ;;
  }

  dimension: time_gmt {
    type: string
    sql: ${TABLE}.time_gmt ;;
  }

  dimension: sample_measurement {
    type: string
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
      date_local,
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

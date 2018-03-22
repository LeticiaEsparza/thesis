view: pm10_daily_summary {
  sql_table_name: looker_scratch.pm10_daily_summary ;;

  dimension: key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${state_code}," ",${county_code}," ",${site_num}," ",CAST(${date_local_date} AS string)," ", ${event_type}," ",CAST(${poc} AS string)," ",CAST(${method_code} AS string)) ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: aqi {
    type: number
    sql: ${TABLE}.aqi ;;
    html:
        {% if value >= 0 and value <= 50 %}
          <div style="background-color:#00E400">{{ rendered_value }}</div>
        {% elsif value >= 51 and value <= 100  %}
          <div style="background-color:#FFFF00">{{ rendered_value }}</div>
        {% elsif value >= 101 and value <= 150  %}
          <div style="background-color:#FF7E00">{{ rendered_value }}</div>
        {% elsif value >= 151 and value <= 200  %}
          <div style="background-color:#FF0000">{{ rendered_value }}</div>
        {% elsif value >= 201 and value <= 300  %}
          <div style="background-color:#8F3F97">{{ rendered_value }}</div>
        {% else %}
          <div style="background-color:#7E0023">{{ rendered_value }}</div>
        {% endif %}
    ;;
  }

  dimension: arithmetic_mean {
    type: number
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

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: first_max_hour {
    type: number
    sql: ${TABLE}.first_max_hour ;;
  }

  dimension: first_max_value {
    type: number
    sql: ${TABLE}.first_max_value ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: local_site_name {
    type: string
    sql: ${TABLE}.local_site_name ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: method_code {
    type: number
    sql: ${TABLE}.method_code ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: observation_count {
    type: number
    sql: ${TABLE}.observation_count ;;
  }

  dimension: observation_percent {
    type: number
    sql: ${TABLE}.observation_percent ;;
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
    type: count
    drill_fields: [detail*]
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      local_site_name,
      city_name,
      method_name,
      state_name,
      cbsa_name,
      parameter_name,
      county_name
    ]
  }
}

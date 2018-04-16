view: all_particulates_rank {
  derived_table: {
    sql: -- use existing all_particulates in `se-pbl.looker_scratch.LR_WCJRKKL9LBSUAQO1YM9M_all_particulates`
      SELECT
        all_particulates.county_name  AS county_name,
        AVG(all_particulates.sample_measurement ) AS avg_sample_measurement,
        ROW_NUMBER() OVER (ORDER BY AVG(all_particulates.sample_measurement ) DESC) AS RANK
      FROM
      (SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_hourly_summary`
            UNION ALL
            SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_hourly_summary`) AS all_particulates

      GROUP BY 1
      ORDER BY 2 DESC
       ;;
    sql_trigger_value: SELECT CURRENT_DATE();;
  }

  dimension: key{
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.RANK ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
    link: {
      label: "County Information"
      url: "https://localhost:9999/dashboards/15?County={{ _filters[all_particulates_rank.county_name'] | url_encode }}"
    }

#     link: {
#       label: "Business Pulse By State Dashboard"
#       url: "https://learn.looker.com/dashboards/694?State={{ _filters['users.state'] | url_encode }}&Date={{ _filters['orders.date'] | url_encode }}"
#     }
  }

  dimension: avg_sample_measurement {
    type: string
    sql: ${TABLE}.avg_sample_measurement ;;
  }

  dimension: avg_num {
    type: number
    sql: ${TABLE}.avg_sample_measurement ;;
  }

  measure:  average_sample_measurement{
    type: average
    sql: ${avg_num} ;;
    value_format: "0.##"
  }

  dimension: rank_a {
    hidden: yes
    type: string
    sql: ${TABLE}.RANK ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.RANK  ;;
  }

  set: detail {
    fields: [county_name, avg_sample_measurement, rank_a]
  }
}

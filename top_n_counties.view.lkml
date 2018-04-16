view: top_n_counties {
  derived_table: {
    sql: WITH particulates_daily AS (SELECT * FROM `se-pbl.epa_historical_air_quality.pm10_daily_summary`
      UNION ALL
      SELECT * FROM `se-pbl.epa_historical_air_quality.pm25_frm_daily_summary`
       )
SELECT
  particulates_daily.county_name  AS county_name,
  AVG(particulates_daily.aqi ) AS avg_aqi,
  ROW_NUMBER() OVER (ORDER BY  AVG(particulates_daily.aqi ) DESC) AS RANK
FROM particulates_daily

WHERE (particulates_daily.sample_duration = '24 HOUR')
-- AND ((((particulates_daily.date_local ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))) AND (particulates_daily.date_local ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS DATE), INTERVAL 10 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL -9 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %T', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP)) AS STRING))) AS TIMESTAMP), DAY)))))))
AND (NOT (particulates_daily.aqi  IS NULL))
GROUP BY 1
ORDER BY 2 DESC
 ;;
    sql_trigger_value: SELECT CURRENT_DATE();;
  }

  dimension: key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.RANK ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension: avg {
    hidden: yes
    type: string
    sql: ${TABLE}.avg_aqi ;;
  }

dimension: avg_aqi {
  type: number
  sql: ${TABLE}.avg_aqi ;;
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


measure: average_aqi {
  type: average
  sql: ${TABLE}.avg_aqi ;;
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

#   dimension: aqi {
#     type: number
#     sql: ${TABLE}.aqi ;;
#     html:
#         {% if value >= 0 and value <= 50 %}
#           <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
#         {% elsif value >= 51 and value <= 100  %}
#           <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
#         {% elsif value >= 101 and value <= 150  %}
#           <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
#         {% elsif value >= 151 and value <= 200  %}
#           <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
#         {% elsif value >= 201 and value <= 300  %}
#           <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
#         {% else %}
#           <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
#         {% endif %}
#     ;;
#   }

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
    fields: [county_name, avg_aqi, rank]
  }
}

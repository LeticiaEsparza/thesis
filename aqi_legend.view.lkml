connection: "big_query_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
view: aqi_legend {
  derived_table: {
    sql: SELECT "Good" AS levels_of_health_concern, "0 to 50" AS aqi_values
      UNION ALL
      SELECT "Moderate" AS levels_of_health_concern, "51 to 100" AS aqi_values
      UNION ALL
      SELECT "Unhealthy for Sensitive Groups" AS levels_of_health_concern, "101 to 150" AS aqi_values
      UNION ALL
      SELECT "Unhealthy" AS levels_of_health_concern, "151 to 200" AS aqi_values
      UNION ALL
      SELECT "Very Unhealthy" AS levels_of_health_concern, "201 to 300" AS aqi_values
      UNION ALL
      SELECT "Hazardous" AS levels_of_health_concern, "301 to 500" AS aqi_values
       ;;
    sql_trigger_value: SELECT CURRENT_DATE();;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: levels_of_health_concern {
    type: string
    sql: ${TABLE}.levels_of_health_concern ;;
    html:
        {% if value == "Good" %}
          <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
        {% elsif value == "Moderate"  %}
          <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
        {% elsif value == "Unhealthy for Sensitive Groups" %}
          <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% elsif value == "Unhealthy"  %}
          <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% elsif value == "Very Unhealthy"  %}
          <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% else %}
          <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% endif %}
    ;;

  }


  dimension: aqi_values {
    type: string
    sql: ${TABLE}.aqi_values ;;
    html:
        {% if value == "0 to 50" %}
        <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
        {% elsif value == "51 to 100"  %}
        <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
        {% elsif value == "101 to 150"  %}
        <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% elsif value == "151 to 200"  %}
        <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% elsif value == "201 to 300"  %}
        <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% else %}
        <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
        {% endif %}
        ;;
}

dimension: order {
  type: number
  sql:
      CASE WHEN ${aqi_values}="0 to 50" THEN 1
           WHEN ${aqi_values}="51 to 100" THEN 2
           WHEN ${aqi_values}="101 to 150" THEN 3
           WHEN ${aqi_values}="151 to 200" THEN 4
           WHEN ${aqi_values}="201 to 300" THEN 5
      ELSE 6
      END
    ;;
}

    set: detail {
    fields: [levels_of_health_concern, aqi_values]
  }
}

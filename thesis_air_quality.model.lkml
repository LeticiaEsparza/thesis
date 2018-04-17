connection: "big_query_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: aqi_legend {}
explore: connection_reg_r3 {
  hidden: yes
}

#Should have 32 tables total
explore:  air_quality_annual_summary{}

# Criteria Gases: Carbon monoxide (CO); Ground-level Ozone (O3); Nitrogen Dioxide (NO2); Sulfur Dioxide (SO2)
# Toxics: Lead (Pb); Hazardous Air Pollutants (HAPs); Nitrous Oxides (NONOxNOy); Volatile Organic Compounds (VOCs)

# explore: all_particulates {}
explore: wind_hourly_summary {}

explore: so2_hourly_summary {

}

explore: co_hourly_summary {

}

explore: no2_hourly_summary {

}

explore: pm10_daily_summary {}
explore: pm25_frm_daily_summary {}

explore: o3_daily_summary {}

explore: pm10_hourly_summary {}

# Particulates
#
explore: all_particulates {
  join: wind_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_particulates.state_code} = ${wind_hourly_summary.state_code}
        AND ${all_particulates.county_code} = ${wind_hourly_summary.county_code}
        AND ${all_particulates.site_num} = ${wind_hourly_summary.site_num}
        AND ${all_particulates.date_gmt_raw} = ${wind_hourly_summary.date_gmt_raw}
        AND ${all_particulates.time_gmt} = ${wind_hourly_summary.time_gmt}
        AND ${wind_hourly_summary.units_of_measure} = "Knots"
    ;;
  }
  join: temperature_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_particulates.state_code} = ${temperature_hourly_summary.state_code}
        AND ${all_particulates.county_code} = ${temperature_hourly_summary.county_code}
        AND ${all_particulates.site_num} = ${temperature_hourly_summary.site_num}
        AND ${all_particulates.date_gmt_raw} = ${temperature_hourly_summary.date_gmt_raw}
        AND ${all_particulates.time_gmt} = ${temperature_hourly_summary.time_gmt}
    ;;
  }
  join: pressure_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_particulates.state_code} = ${pressure_hourly_summary.state_code}
        AND ${all_particulates.county_code} = ${pressure_hourly_summary.county_code}
        AND ${all_particulates.site_num} = ${pressure_hourly_summary.site_num}
        AND ${all_particulates.date_gmt_raw} = ${pressure_hourly_summary.date_gmt_raw}
        AND ${all_particulates.time_gmt} = ${pressure_hourly_summary.time_gmt}
    ;;
  }
  join: rh_and_dp_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_particulates.state_code} = ${rh_and_dp_hourly_summary.state_code}
        AND ${all_particulates.county_code} = ${rh_and_dp_hourly_summary.county_code}
        AND ${all_particulates.site_num} = ${rh_and_dp_hourly_summary.site_num}
        AND ${all_particulates.date_gmt_raw} = ${rh_and_dp_hourly_summary.date_gmt_raw}
        AND ${all_particulates.time_gmt} = ${rh_and_dp_hourly_summary.time_gmt}
    ;;
  }
}

explore: particulates_daily {}

explore: all_gases {
  join: wind_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_gases.state_code} = ${wind_hourly_summary.state_code}
        AND ${all_gases.county_code} = ${wind_hourly_summary.county_code}
        AND ${all_gases.site_num} = ${wind_hourly_summary.site_num}
        AND ${all_gases.date_gmt_raw} = ${wind_hourly_summary.date_gmt_raw}
        AND ${all_gases.time_gmt} = ${wind_hourly_summary.time_gmt}
        AND ${wind_hourly_summary.units_of_measure} = "Knots"
    ;;
  }
  join: temperature_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_gases.state_code} = ${temperature_hourly_summary.state_code}
        AND ${all_gases.county_code} = ${temperature_hourly_summary.county_code}
        AND ${all_gases.site_num} = ${temperature_hourly_summary.site_num}
        AND ${all_gases.date_gmt_raw} = ${temperature_hourly_summary.date_gmt_raw}
        AND ${all_gases.time_gmt} = ${temperature_hourly_summary.time_gmt}
    ;;
  }
  join: pressure_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_gases.state_code} = ${pressure_hourly_summary.state_code}
        AND ${all_gases.county_code} = ${pressure_hourly_summary.county_code}
        AND ${all_gases.site_num} = ${pressure_hourly_summary.site_num}
        AND ${all_gases.date_gmt_raw} = ${pressure_hourly_summary.date_gmt_raw}
        AND ${all_gases.time_gmt} = ${pressure_hourly_summary.time_gmt}
    ;;
  }
  join: rh_and_dp_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_gases.state_code} = ${rh_and_dp_hourly_summary.state_code}
        AND ${all_gases.county_code} = ${rh_and_dp_hourly_summary.county_code}
        AND ${all_gases.site_num} = ${rh_and_dp_hourly_summary.site_num}
        AND ${all_gases.date_gmt_raw} = ${rh_and_dp_hourly_summary.date_gmt_raw}
        AND ${all_gases.time_gmt} = ${rh_and_dp_hourly_summary.time_gmt}
    ;;
  }
}

explore: all_particulates_daily_filtered {
  label: "Pollution Rankings"
join: all_particulates {
  type: inner
  relationship: one_to_one
    sql_on:
--            ${all_particulates.state_code} = ${all_particulates_daily_filtered.state_code}
                ${all_particulates.county_name} = ${all_particulates_daily_filtered.county_name}
--            AND ${all_particulates.site_num} = ${all_particulates_daily_filtered.site_num}
            AND ${all_particulates.date_local_raw} = ${all_particulates_daily_filtered.date_local_raw}
;;
 }
join: all_particulates_rank {
  view_label: "Rank by Sample Measurement"
  type: inner
  relationship: one_to_one
  sql_on: ${all_particulates_daily_filtered.county_name} = ${all_particulates_rank.county_name}
    ;;
}
join: top_n_counties {
  view_label: "Rank by AQI"
  type: inner
  relationship: one_to_one
  sql_on: ${all_particulates_daily_filtered.county_name} = ${top_n_counties.county_name} ;;
}
}


# explore: all_particulates_daily_past_10_years  {
#   label: "Top N Counties in the Past 10 Years"
#   join: top_n_counties {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${all_particulates_daily_past_10_years.county_name} = ${top_n_counties.county_name} ;;
#   }
# }
# explore: top_n_counties {}



# explore: all_particulates {
#   label: "Pollution Rankings"
#   join: all_particulates_rank{
#     type: inner
#     relationship: one_to_one
#     sql_on: ${all_particulates.county_name} = ${all_particulates_rank.county_name};;
#   }
#   join: all_particulates_daily_filtered {
#     type: inner
#     relationship: one_to_one
#     sql_on: all ;;
#   }
# }
#
#


#
# explore: pm10_hourly_summary {}
# explore: pm25_frm_daily_summary {}
#
explore: pm25_frm_hourly_summary {}
#
# explore: pm25_nonfrm_daily_summary {}
#
# explore: pm25_nonfrm_hourly_summary {}
#
# explore: pm25_speciation_daily_summary {}
#
# explore: pm25_speciation_hourly_summary {}

# explore: pressure_daily_summary {}
#
explore: pressure_hourly_summary {}

explore: o3_hourly_summary {}
#
# explore: rh_and_dp_daily_summary {}
#
explore: rh_and_dp_hourly_summary {}
#
# explore: so2_daily_summary {}
#
# explore: so2_hourly_summary {}
#
# explore: temperature_daily_summary {}
#
# explore: temperature_hourly_summary {}
#
# explore: voc_daily_summary {}
#
# explore: voc_hourly_summary {}
#
# explore: wind_daily_summary {}
#

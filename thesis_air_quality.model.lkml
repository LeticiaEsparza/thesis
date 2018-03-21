connection: "big_query_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: connection_reg_r3 {
  hidden: yes
}

#Should have 32 tables total
explore:  air_quality_annual_summary{}

# Criteria Gases: Carbon monoxide (CO); Ground-level Ozone (O3); Nitrogen Dioxide (NO2); Sulfur Dioxide (SO2)
# Toxics: Lead (Pb); Hazardous Air Pollutants (HAPs); Nitrous Oxides (NONOxNOy); Volatile Organic Compounds (VOCs)

# explore: all_particulates {}
explore: wind_hourly_summary {}
# explore: wind_hourly_summary {
#   label: "Wind and Criteria Gases"
#   join: o3_hourly_summary {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${wind_hourly_summary.state_name} = ${o3_hourly_summary.state_name}
#               AND ${wind_hourly_summary.date_gmt_raw} = ${o3_hourly_summary.date_gmt_raw}
#               AND ${wind_hourly_summary.time_gmt} = ${o3_hourly_summary.time_gmt}
#               AND ${wind_hourly_summary.county_name} = ${o3_hourly_summary.county_name}
#               AND ${wind_hourly_summary.site_num} = ${o3_hourly_summary.site_num}
#               AND ${wind_hourly_summary.units_of_measure} = "Knots"
#     ;;
#   }
#   join: so2_hourly_summary {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${wind_hourly_summary.state_name} = ${so2_hourly_summary.state_name}
#               AND ${wind_hourly_summary.date_gmt_raw} = ${so2_hourly_summary.date_gmt_raw}
#               AND ${wind_hourly_summary.time_gmt} = ${so2_hourly_summary.time_gmt}
#               AND ${wind_hourly_summary.county_name} = ${so2_hourly_summary.county_name}
#               AND ${wind_hourly_summary.site_num} = ${so2_hourly_summary.site_num}
#               AND ${wind_hourly_summary.units_of_measure} = "Knots"
#     ;;
#   }
#   join: co_hourly_summary {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${wind_hourly_summary.state_name} = ${co_hourly_summary.state_name}
#               AND ${wind_hourly_summary.date_gmt_raw} = ${co_hourly_summary.date_gmt_raw}
#               AND ${wind_hourly_summary.time_gmt} = ${co_hourly_summary.time_gmt}
#               AND ${wind_hourly_summary.county_name} = ${co_hourly_summary.county_name}
#               AND ${wind_hourly_summary.site_num} = ${co_hourly_summary.site_num}
#               AND ${wind_hourly_summary.units_of_measure} = "Knots"
#     ;;
#   }
#   join: no2_hourly_summary {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${wind_hourly_summary.state_name} = ${no2_hourly_summary.state_name}
#               AND ${wind_hourly_summary.date_gmt_raw} = ${no2_hourly_summary.date_gmt_raw}
#               AND ${wind_hourly_summary.time_gmt} = ${no2_hourly_summary.time_gmt}
#               AND ${wind_hourly_summary.county_name} = ${no2_hourly_summary.county_name}
#               AND ${wind_hourly_summary.site_num} = ${no2_hourly_summary.site_num}
#               AND ${wind_hourly_summary.units_of_measure} = "Knots"
#     ;;
#   }
# }

#
#   label: "Criteria Gases"
#   join: so2_hourly_summary {
#     type: left_outer
#     sql_on: ${o3_hourly_summary.o3_key}=${so2_hourly_summary.so2_key} ;;
#     relationship: many_to_one
#   }
#   join: co_hourly_summary {
#     type: left_outer
#     sql_on: ${co_hourly_summary.co_key}=${o3_hourly_summary.o3_key} ;;
#     relationship: many_to_one
#   }
#   join: no2_hourly_summary {
#     type:left_outer
#     sql: ${o3_hourly_summary.o3_key}=${no2_hourly_summary.no2_key} ;;
#     relationship: many_to_one
#   }
#
# }

explore: so2_hourly_summary {

}

explore: co_hourly_summary {

}

explore: no2_hourly_summary {

}

# union all for particulates and then partition
# partition keys for time_gmt
# create flag for union all

# explore: co_daily_summary {}
#
# explore: co_hourly_summary {}
#
# explore: hap_daily_summary {}
#
# explore: hap_hourly_summary {}
#
# explore: lead_daily_summary {}
#
# explore: no2_daily_summary {}
#
# explore: no2_hourly_summary {}
#
# explore: nonoxnoy_daily_summary {}
#
# explore: nonoxnoy_hourly_summary {}
#
# explore: o3_daily_summary {}
#
# explore: o3_hourly_summary {}
#
# explore: pm10_daily_summary {}
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


explore: all_gases {
  join: wind_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${all_gases.state_code} = ${wind_hourly_summary.state_code}
        AND ${all_gases.county_code} = ${wind_hourly_summary.county_code}
        AND ${all_gases.site_num} = ${wind_hourly_summary.site_num}
        AND ${all_gases.date_gmt_raw} = ${wind_hourly_summary.date_gmt_raw}
        AND ${all_gases.time_gmt} = ${wind_hourly_summary.time_gmt}
        AND ${all_gases.units_of_measure} = "Knots"
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
explore: temperature_hourly_summary {}
#
# explore: voc_daily_summary {}
#
# explore: voc_hourly_summary {}
#
# explore: wind_daily_summary {}
#
# explore: wind_hourly_summary {}

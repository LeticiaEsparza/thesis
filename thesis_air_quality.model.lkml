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


explore: wind_hourly_summary {

  join: o3_hourly_summary {
    type: inner
    relationship: one_to_one
    sql_on: ${wind_hourly_summary.state_name}=${o3_hourly_summary.state_name}
              AND ${o3_hourly_summary.date_gmt_raw}=${wind_hourly_summary.date_gmt_raw}
              AND ${wind_hourly_summary.time_gmt}=${o3_hourly_summary.time_gmt}
              AND ${wind_hourly_summary.county_name}=${o3_hourly_summary.county_name}
              AND ${wind_hourly_summary.site_num}=${o3_hourly_summary.site_num}
              AND ${wind_hourly_summary.units_of_measure}="Knots"
              ;;
  }
}

#
explore: o3_hourly_summary {}
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
#
# explore: pm10_hourly_summary {}
#
# explore: pm25_frm_daily_summary {}
#
# explore: pm25_frm_hourly_summary {}
#
# explore: pm25_nonfrm_daily_summary {}
#
# explore: pm25_nonfrm_hourly_summary {}
#
# explore: pm25_speciation_daily_summary {}
#
# explore: pm25_speciation_hourly_summary {}
#
# explore: pressure_daily_summary {}
#
# explore: pressure_hourly_summary {}
#
# explore: rh_and_dp_daily_summary {}
#
# explore: rh_and_dp_hourly_summary {}
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
# explore: wind_hourly_summary {}

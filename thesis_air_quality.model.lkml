connection: "big_query_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: connection_reg_r3 {}

#Should have 32 tables total
explore:  air_quality_annual_summary{}

explore: co_daily_summary {}

explore: co_hourly_summary {}

explore: hap_daily_summary {}

explore: hap_hourly_summary {}

explore: lead_daily_summary {}

explore: no2_daily_summary {}

explore: no2_hourly_summary {}

explore: nonoxnoy_daily_summary {}

explore: nonoxnoy_hourly_summary {}

explore: o3_daily_summary {}

explore: o3_hourly_summary {}

explore: pm10_daily_summary {}

explore: pm10_hourly_summary {}

explore: pm25_frm_daily_summary {}

explore: pm25_frm_hourly_summary {}

explore: pm25_nonfrm_daily_summary {}

explore: pm25_nonfrm_hourly_summary {}

explore: pm25_speciation_daily_summary {}

explore: pm25_speciation_hourly_summary {}

explore: pressure_daily_summary {}

explore: pressure_hourly_summary {}

explore: rh_and_dp_daily_summary {}

explore: rh_and_dp_hourly_summary {}

explore: so2_daily_summary {}

explore: so2_hourly_summary {}

explore: temperature_daily_summary {}

explore: temperature_hourly_summary {}

explore: voc_daily_summary {}

explore: voc_hourly_summary {}

explore: wind_daily_summary {}

explore: wind_hourly_summary {}

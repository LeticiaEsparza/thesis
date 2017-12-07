connection: "big_query_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: connection_reg_r3 {}

#Should have 32 tables total
explore:  air_quality_annual_summary{}

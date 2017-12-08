view: air_quality_annual_summary {
  sql_table_name: looker_scratch.air_quality_annual_summary ;;

  dimension: address {
    description: "The approximate street address of the monitoring site."
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: arithmetic_mean {
    description: "The average (arithmetic mean) value for the year."
    type: number
    sql: ${TABLE}.arithmetic_mean ;;
  }

  dimension: arithmetic_standard_dev {
    description: "The standard deviation about the mean of the values for the year."
    type: number
    sql: ${TABLE}.arithmetic_standard_dev ;;
  }

  dimension: cbsa_name {
    description: "The name of the core bases statistical area (metropolitan area) where the monitoring site is located."
    type: string
    sql: ${TABLE}.cbsa_name ;;
  }

  dimension: certification_indicator {
    description: "An indication whether the completeness and accuracy of the information on the annual summary record has been certified by the submitter. Certified means the submitter has certified the data (due May 01 the year after collection). Certification not required means that the parameter does not require certification or the deadline has not yet passed. Uncertified (past due) means that certification is required but is overdue. Requested but not yet concurred means the submitter has completed the process, but EPA has not yet acted to certify the data. Requested but denied means the submitter has completed the process, but EPA has denied the request for cause. Was certified but data changed means the data was certified but data was replaced and the process has not been repeated."
    type: string
    sql: ${TABLE}.certification_indicator ;;
  }

  dimension: city_name {
    description: "The name of the city where the monitoring site is located. This represents the legal incorporated boundaries of cities and not urban areas."
    type: string
    sql: ${TABLE}.city_name ;;
  }

  dimension: completeness_indicator {
    description: "An indication of whether the regulatory data completeness criteria for valid summary data have been met by the monitor for the year. Y means yes, N means no or that there are no regulatory completeness criteria for the parameter."
    type: string
    sql: ${TABLE}.completeness_indicator ;;
  }

  dimension: county_code {
    description: "The FIPS code of the county in which the monitor resides."
    type: string
    sql: ${TABLE}.county_code ;;
  }

  dimension: county_name {
    description: "The name of the county where the monitoring site is located."
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension_group: date_of_last_change {
    description: "The date the last time any numeric values in this record were updated in the AQS data system."
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
    description: "The Datum associated with the Latitude and Longitude measures."
    type: string
    sql: ${TABLE}.datum ;;
  }

  dimension: event_type {
    description: "Indicates whether data measured during exceptional events are included in the summary. A wildfire is an example of an exceptional event; it is something that affects air quality, but the local agency has no control over. No Events means no events occurred. Events Included means events occurred and the data from them is included in the summary. Events Excluded means that events occurred but data form them is excluded from the summary. Concurred Events Excluded means that events occurred but only EPA concurred exclusions are removed from the summary. If an event occurred for the parameter in question, the data will have multiple records for each monitor."
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: exceptional_data_count {
    description: "The number of data points in the annual data set affected by exceptional air quality events (things outside the norm that affect air quality)."
    type: number
    sql: ${TABLE}.exceptional_data_count ;;
  }

  dimension: fifty_percentile {
    description: "The value from this monitor for which 50 per cent of the rest of the measured values for the year are equal to or less than (i.e., the median)."
    type: number
    sql: ${TABLE}.fifty_percentile ;;
  }

  dimension_group: first_max_datetime {
    description: "The date and time (on a 24-hour clock) when the highest value for the year (the first_max field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_max_datetime ;;
  }

  dimension: first_max_non_overlapping_value {
    description: "For 8-hour CO averages, the highest value of the year."
    type: number
    sql: ${TABLE}.first_max_non_overlapping_value ;;
  }

  dimension: first_max_value {
    description: "The highest value for the year."
    type: number
    sql: ${TABLE}.first_max_value ;;
  }

  dimension_group: first_no_max_datetime {
    description: "The date and time (on a 24-hour clock) when the first maximum non overlapping value for the year (the previous field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_no_max_datetime ;;
  }

  dimension_group: fourth_max_datetime {
    description: "The date and time (on a 24-hour clock) when the fourth highest value for the year (the previous field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.fourth_max_datetime ;;
  }

  dimension: fourth_max_value {
    description: "The fourth highest value for the year."
    type: number
    sql: ${TABLE}.fourth_max_value ;;
  }

  dimension: latitude {
    description: "The monitoring site’s angular distance north of the equator measured in decimal degrees."
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: local_site_name {
    description: "The name of the site (if any) given by the State, local, or tribal air pollution control agency that operates it."
    type: string
    sql: ${TABLE}.local_site_name ;;
  }

  dimension: longitude {
    description: "The monitoring site’s angular distance east of the prime meridian measured in decimal degrees."
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: method_name {
    description: "A short description of the processes, equipment, and protocols used in gathering and measuring the sample."
    type: string
    sql: ${TABLE}.method_name ;;
  }

  dimension: metric_used {
    description: "The base metric used in the calculation of the aggregate statistics presented in the remainder of the row. For example, if this is Daily Maximum, then the value in the Mean column is the mean of the daily maximums."
    type: string
    sql: ${TABLE}.metric_used ;;
  }

  dimension: ninety_eight_percentile {
    description: "The value from this monitor for which 98 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.ninety_eight_percentile ;;
  }

  dimension: ninety_five_percentile {
    description: "The value from this monitor for which 95 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.ninety_five_percentile ;;
  }

  dimension: ninety_nine_percentile {
    description: "The value from this monitor for which 99 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.ninety_nine_percentile ;;
  }

  dimension: ninety_percentile {
    description: "The value from this monitor for which 90 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.ninety_percentile ;;
  }

  dimension: null_data_count {
    description: "The count of scheduled samples when no data was collected and the reason for no data was reported."
    type: number
    sql: ${TABLE}.null_data_count ;;
  }

  dimension: num_obs_below_mdl {
    description: "The number of samples reported during the year that were below the method detection limit (MDL) for the monitoring instrument. Sometimes these values are replaced by 1/2 the MDL in summary calculations."
    type: number
    sql: ${TABLE}.num_obs_below_mdl ;;
  }

  dimension: observation_count {
    description: "The number of observations (samples) taken during the year."
    type: number
    sql: ${TABLE}.observation_count ;;
  }

  dimension: observation_percent {
    description: "The percent representing the number of observations taken with respect to the number scheduled to be taken during the year. This is only calculated for monitors where measurements are required (e.g., only certain parameters)."
    type: number
    sql: ${TABLE}.observation_percent ;;
  }

  dimension: parameter_code {
    description: "The AQS code corresponding to the parameter measured by the monitor."
    type: number
    sql: ${TABLE}.parameter_code ;;
  }

  dimension: parameter_name {
    description: "The name or description assigned in AQS to the parameter measured by the monitor. Parameters may be pollutants or non-pollutants."
    type: string
    sql: ${TABLE}.parameter_name ;;
  }

  dimension: poc {
    description: "This is the “Parameter Occurrence Code” used to distinguish different instruments that measure the same parameter at the same site."
    type: number
    sql: ${TABLE}.poc ;;
  }

  dimension: pollutant_standard {
    description: "A description of the ambient air quality standard rules used to aggregate statistics. (See description at beginning of document.)"
    type: string
    sql: ${TABLE}.pollutant_standard ;;
  }

  dimension: primary_exceedance_count {
    description: "The number of samples during the year that exceeded the primary air quality standard."
    type: number
    sql: ${TABLE}.primary_exceedance_count ;;
  }

  dimension: required_day_count {
    description: "The number of days during the year which the monitor was scheduled to take samples if measurements are required."
    type: number
    sql: ${TABLE}.required_day_count ;;
  }

  dimension: sample_duration {
    description: "The length of time that air passes through the monitoring device before it is analyzed (measured). So, it represents an averaging period in the atmosphere (for example, a 24-hour sample duration draws ambient air over a collection filter for 24 straight hours). For continuous monitors, it can represent an averaging time of many samples (for example, a 1-hour value may be the average of four one-minute samples collected during each quarter of the hour)."
    type: string
    sql: ${TABLE}.sample_duration ;;
  }

  dimension_group: second_max_datetime {
    description: "The date and time (on a 24-hour clock) when the second highest value for the year (the previous field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.second_max_datetime ;;
  }

  dimension: second_max_non_overlapping_value {
    description: "For 8-hour CO averages, the second highest value of the year that does not share any hours with the 8-hour period of the first max non overlapping value."
    type: number
    sql: ${TABLE}.second_max_non_overlapping_value ;;
  }

  dimension: second_max_value {
    description: "The second highest value for the year."
    type: number
    sql: ${TABLE}.second_max_value ;;
  }

  dimension_group: second_no_max_datetime {
    description: "The date and time (on a 24-hour clock) when the second maximum non overlapping value for the year (the previous field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.second_no_max_datetime ;;
  }

  dimension: secondary_exceedance_count {
    description: "The number of samples during the year that exceeded the secondary air quality standard."
    type: number
    sql: ${TABLE}.secondary_exceedance_count ;;
  }

  dimension: seventy_five_percentile {
    description: "The value from this monitor for which 75 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.seventy_five_percentile ;;
  }

  dimension: site_num {
    description: "A unique number within the county identifying the site."
    type: string
    sql: ${TABLE}.site_num ;;
  }

  dimension: state_code {
    description: "The FIPS code of the state in which the monitor resides."
    type: string
    sql: ${TABLE}.state_code ;;
  }

  dimension: state_name {
    description: "The name of the state where the monitoring site is located."
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: ten_percentile {
    description: "The value from this monitor for which 10 per cent of the rest of the measured values for the year are equal to or less than."
    type: number
    sql: ${TABLE}.ten_percentile ;;
  }

  dimension_group: third_max_datetime {
    description: "The date and time (on a 24-hour clock) when the third highest value for the year (the previous field) was taken."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.third_max_datetime ;;
  }

  dimension: third_max_value {
    description: "The third highest value for the year."
    type: number
    sql: ${TABLE}.third_max_value ;;
  }

  dimension: units_of_measure {
    description: "The unit of measure for the parameter. QAD always returns data in the standard units for the parameter. Submitters are allowed to report data in any unit and EPA converts to a standard unit so that we may use the data in calculations."
    type: string
    sql: ${TABLE}.units_of_measure ;;
  }

  dimension: valid_day_count {
    description: "The number of days during the year where the daily monitoring criteria were met, if the calculation of the summaries is based on valid days."
    type: number
    sql: ${TABLE}.valid_day_count ;;
  }

  dimension: year {
    description: "The year the annual summary data represents."
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    description: "Standard Looker/sql count field"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      local_site_name,
      method_name,
      state_name,
      cbsa_name,
      city_name,
      parameter_name,
      county_name
    ]
  }
}

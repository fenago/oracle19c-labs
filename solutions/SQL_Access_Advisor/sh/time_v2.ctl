LOAD DATA INFILE dat
   DISCARDFILE  time_v2.discard
   DISCARDMAX  200
    INTO TABLE SH.TIMES
    INSERT
    FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
(TIME_ID DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 DAY_NAME,
 DAY_NUMBER_IN_WEEK,
 DAY_NUMBER_IN_MONTH,
 CALENDAR_WEEK_NUMBER,
 FISCAL_WEEK_NUMBER,
 WEEK_ENDING_DAY DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 CALENDAR_MONTH_NUMBER,
 FISCAL_MONTH_NUMBER,
 CALENDAR_MONTH_DESC,
 FISCAL_MONTH_DESC,
 DAYS_IN_CAL_MONTH,
 DAYS_IN_FIS_MONTH,
 END_OF_CAL_MONTH DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 END_OF_FIS_MONTH DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 CALENDAR_MONTH_NAME,
 FISCAL_MONTH_NAME,
 CALENDAR_QUARTER_DESC,
 FISCAL_QUARTER_DESC,
 DAYS_IN_CAL_QUARTER,
 DAYS_IN_FIS_QUARTER,
 END_OF_CAL_QUARTER DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 END_OF_FIS_QUARTER DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 CALENDAR_QUARTER_NUMBER,
 FISCAL_QUARTER_NUMBER,
 CALENDAR_YEAR,
 FISCAL_YEAR,
 DAYS_IN_CAL_YEAR,
 DAYS_IN_FIS_YEAR,
 END_OF_CAL_YEAR DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 END_OF_FIS_YEAR DATE(19) "YYYY-MM-DD-HH24-MI-SS")

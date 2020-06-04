CREATE FUNCTION fnTrimDateUpper (v_Date DATETIME) BEGIN


   RETURN TIMESTAMPADD(day,1,fnTrimDateLower(v_Date));
END
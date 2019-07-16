CREATE FUNCTION fnTrimDateLower (v_Date DATETIME) BEGIN


   RETURN STR_TO_DATE(DATE_FORMAT(v_Date,'%m/%d/%y'),'%m/%d/%y');
END
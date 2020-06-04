CREATE PROCEDURE VerifyCurrency2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ExchangeRateDate DATETIME,
	v_ExchangeRateFlag INT,
	INOUT v_CompanyCurrencyID NATIONAL VARCHAR(3) ,
	INOUT v_CurrencyID NATIONAL VARCHAR(3) ,
 	INOUT v_CurrencyExchangeRate FLOAT) BEGIN







   DECLARE v_Today DATETIME;
   SET v_ExchangeRateDate = STR_TO_DATE(DATE_FORMAT(v_ExchangeRateDate,'%Y-%m-%d'),'%Y-%m-%d');
   SET v_Today = STR_TO_DATE(DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d'),'%Y-%m-%d');

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   SET v_CurrencyID = IFNULL(v_CurrencyID,v_CompanyCurrencyID);

   IF v_ExchangeRateFlag = 1 then
	
      SET v_CurrencyExchangeRate =
      IFNULL(v_CurrencyExchangeRate,(SELECT MAX(CurrencyExchangeRate)
      FROM CurrencyTypesHistory
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      CurrencyID = v_CurrencyID	AND
      STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate));
   ELSE 
      IF v_ExchangeRateFlag = 2 then
	
         SET v_CurrencyExchangeRate =
         IFNULL(v_CurrencyExchangeRate,(SELECT MIN(CurrencyExchangeRate)
         FROM CurrencyTypesHistory
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         CurrencyID = v_CurrencyID	AND
         STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate));
      ELSE
         SET v_CurrencyExchangeRate =
         IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
         FROM CurrencyTypesHistory
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         CurrencyID = v_CurrencyID	AND
         STR_TO_DATE(DATE_FORMAT(CurrencyIDDateTime,'%Y-%m-%d'),'%Y-%m-%d') = v_ExchangeRateDate
         ORDER BY
         CurrencyIDDateTime DESC LIMIT 1));
      end if;
   end if;

   SET v_CurrencyExchangeRate =
   IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
   FROM CurrencyTypesHistory
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CurrencyID = v_CurrencyID	AND
   CurrencyIDDateTime < v_ExchangeRateDate
   ORDER BY
   CurrencyIDDateTime DESC LIMIT 1));

   SET v_CurrencyExchangeRate =
   IFNULL(v_CurrencyExchangeRate,(SELECT  CurrencyExchangeRate
   FROM CurrencyTypes
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CurrencyID = v_CurrencyID LIMIT 1));

   SET v_CurrencyExchangeRate = IFNULL(v_CurrencyExchangeRate,1);

   IF v_CurrencyExchangeRate <= 0 then
      SET v_CurrencyExchangeRate = 1;
   end if;
END
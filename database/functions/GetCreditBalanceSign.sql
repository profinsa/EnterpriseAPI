CREATE FUNCTION GetCreditBalanceSign (v_GLBalanceType NATIONAL VARCHAR(36)) BEGIN

   RETURN CASE

	
	
   When  v_GLBalanceType = 'ASSET' OR v_GLBalanceType = 'EXPENSE' THEN -1
	
	
   When v_GLBalanceType = 'LIABILITY' OR v_GLBalanceType = 'EQUITY' OR v_GLBalanceType = 'INCOME' THEN 1

	
	
   ELSE 1
   END;


END
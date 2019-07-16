CREATE FUNCTION GetBalanceAmount (v_GLBalanceType NATIONAL VARCHAR(36),
	v_DebitAmount DECIMAL(19,4),
	v_CreditAmount DECIMAL(19,4)) BEGIN
   DECLARE v_CreditBalanceSign INT;
   SET v_CreditBalanceSign = GetCreditBalanceSign(v_GLBalanceType);

   RETURN CASE
   When IFNULL(v_CreditAmount,0) <> 0  THEN v_CreditAmount*v_CreditBalanceSign
	
   When IFNULL(v_DebitAmount,0) <> 0  THEN 0 -(v_DebitAmount*v_CreditBalanceSign)
   ELSE 0
   END;

END
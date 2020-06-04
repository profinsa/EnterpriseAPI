CREATE PROCEDURE BankReconciliation_PrepareForPrint (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLBankAccount NATIONAL VARCHAR(36),
	v_BankRecID NATIONAL VARCHAR(36),
	v_CurrencyID NATIONAL VARCHAR(3),
	v_CurrencyExchangeRate FLOAT,
	v_BankRecCutoffDate DATETIME,
	v_BankRecEndingBalance DECIMAL(19,4),
	v_BankRecServiceCharge DECIMAL(19,4),
	v_GLServiceChargeAccount NATIONAL VARCHAR(36),
	v_BankRecIntrest DECIMAL(19,4),
	v_GLInterestAccount NATIONAL VARCHAR(36),
	v_BankRecAdjustment DECIMAL(19,4),
	v_GLAdjustmentAccount NATIONAL VARCHAR(36),
	v_BankRecOtherCharges DECIMAL(19,4),
	v_GLOtherChargesAccount NATIONAL VARCHAR(36),
	v_BankRecCreditTotal DECIMAL(19,4),
	v_BankRecDebitTotal DECIMAL(19,4),
	v_BankRecCreditOS DECIMAL(19,4),
	v_BankRecDebitOS DECIMAL(19,4),
	v_BankRecStartingBalance DECIMAL(19,4),
	v_BankRecBookBalance DECIMAL(19,4),
	v_BankRecDifference DECIMAL(19,4),
	v_BankRecEndingBookBalance DECIMAL(19,4),
	v_BankRecStartingBookBalance DECIMAL(19,4),
	v_Notes NATIONAL VARCHAR(1)) BEGIN














   DELETE FROM BankReconciliationSummaryTemp WHERE CreationDate < TIMESTAMPADD(day,-1,CURRENT_TIMESTAMP);

   INSERT INTO BankReconciliationSummaryTemp(CompanyID,
	DivisionID,
	DepartmentID,
	BankRecID,
	GLBankAccount,
	CurrencyID,
	CurrencyExchangeRate,
	BankRecCutoffDate,
	BankRecEndingBalance,
	BankRecServiceCharge,
	GLServiceChargeAccount,
	BankRecIntrest,
	GLInterestAccount,
	BankRecAdjustment,
	GLAdjustmentAccount,
	BankRecOtherCharges,
	GLOtherChargesAccount,
	BankRecCreditTotal,
	BankRecDebitTotal,
	BankRecCreditOS,
	BankRecDebitOS,
	BankRecStartingBalance,
	BankRecBookBalance,
	BankRecDifference,
	BankRecEndingBookBalance,
	BankRecStartingBookBalance,
	Notes,
	CreationDate)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	IFNULL(v_BankRecID,UUID()),
	v_GLBankAccount,
	v_CurrencyID,
	v_CurrencyExchangeRate,
	v_BankRecCutoffDate,
	v_BankRecEndingBalance,
	v_BankRecServiceCharge,
	v_GLServiceChargeAccount,
	v_BankRecIntrest,
	v_GLInterestAccount,
	v_BankRecAdjustment,
	v_GLAdjustmentAccount,
	v_BankRecOtherCharges,
	v_GLOtherChargesAccount,
	v_BankRecCreditTotal,
	v_BankRecDebitTotal,
	v_BankRecCreditOS,
	v_BankRecDebitOS,
	v_BankRecStartingBalance,
	v_BankRecBookBalance,
	v_BankRecDifference,
	v_BankRecEndingBookBalance,
	v_BankRecStartingBookBalance,
	v_Notes,
	CURRENT_TIMESTAMP);


END
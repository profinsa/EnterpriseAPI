CREATE PROCEDURE RptListContractsHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   OrderNumber,
	TransactionType,
	ContractTypeID,
	ContractStartDate,
	ContractEndDate,
	ContractLastRecurrDate,
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,BalanceDue,N'') as SIGNED INTEGER) AS BalanceDue
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM ContractsHeader
   INNER JOIN CurrencyTypes ON
   ContractsHeader.CompanyID = CurrencyTypes.CompanyID and
   ContractsHeader.DivisionID = CurrencyTypes.DivisionID and
   ContractsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   ContractsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   ContractsHeader.CompanyID = v_CompanyID and
   ContractsHeader.DivisionID = v_DivisionID and
   ContractsHeader.DepartmentID = v_DepartmentID;
END
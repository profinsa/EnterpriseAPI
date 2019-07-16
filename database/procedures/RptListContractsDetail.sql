CREATE PROCEDURE RptListContractsDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN




   SELECT
	
	
	
   ContractsDetail.OrderNumber,
	OrderLineNumber,
	ItemID,
	ContractsDetail.WarehouseID,
	
	
	OrderQty,
	
	
	
	
	
	
	
	
	
	ItemUnitPrice,
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ContractsDetail.Total,N'') as SIGNED INTEGER) AS Total,
	
	
	ProjectID
	
	
	
	
	
	
   FROM ContractsDetail
   INNER JOIN ContractsHeader ON
   ContractsHeader.CompanyID = ContractsDetail.CompanyID and
   ContractsHeader.DivisionID = ContractsDetail.DivisionID and
   ContractsHeader.DepartmentID = ContractsDetail.DepartmentID and
   ContractsHeader.OrderNumber = ContractsDetail.OrderNumber
   INNER JOIN CurrencyTypes ON
   ContractsHeader.CompanyID = CurrencyTypes.CompanyID and
   ContractsHeader.DivisionID = CurrencyTypes.DivisionID and
   ContractsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   ContractsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   ContractsDetail.CompanyID = v_CompanyID and
   ContractsDetail.DivisionID = v_DivisionID and
   ContractsDetail.DepartmentID = v_DepartmentID;



END
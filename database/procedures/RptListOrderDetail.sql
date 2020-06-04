CREATE PROCEDURE RptListOrderDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   OrderDetail.OrderNumber,
	OrderLineNumber,
	ItemID,
	OrderDetail.WarehouseID, 
	
	
	OrderQty, 
	
	
	
	
	
	
	
	
	
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ItemUnitPrice,N'') as SIGNED INTEGER) AS ItemUnitPrice,
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,OrderDetail.Total,OrderHeader.CurrencyID) as SIGNED INTEGER) AS Total, 
	
	
	ProjectID
	
	
	
	
	
	
   FROM OrderDetail
   INNER JOIN OrderHeader ON
   OrderHeader.CompanyID = OrderDetail.CompanyID and
   OrderHeader.DivisionID = OrderDetail.DivisionID and
   OrderHeader.DepartmentID = OrderDetail.DepartmentID and
   OrderHeader.OrderNumber = OrderDetail.OrderNumber
   INNER JOIN CurrencyTypes ON
   OrderHeader.CompanyID = CurrencyTypes.CompanyID and
   OrderHeader.DivisionID = CurrencyTypes.DivisionID and
   OrderHeader.DepartmentID = CurrencyTypes.DepartmentID and
   OrderHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   OrderDetail.CompanyID = v_CompanyID and
   OrderDetail.DivisionID = v_DivisionID and
   OrderDetail.DepartmentID = v_DepartmentID;
END
CREATE PROCEDURE RptListInventoryItems (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN

















   SELECT
	
	
	
   ItemID,
	
	
	ItemName,
	ItemDescription,
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Price,N'') AS Price,
	
	
	
	
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,LIFOValue,N'') AS LIFOValue,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AverageValue,N'') AS AverageValue,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,FIFOValue,N'') AS FIFOValue
	
	
	
   FROM InventoryItems
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END
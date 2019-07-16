CREATE PROCEDURE RptListFixedAssets (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN














   SELECT
	
	
	
   AssetID,
	AssetName,
	
	AssetTypeID,
	AssetStatusID, 
	
	AssetDescription,
	AssetLocation, 
	
	
	AssetInServiceDate, 
	
	
	
	
	
	
	
	
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AssetBookValue,N'') AS AssetBookValue
	
	
   FROM FixedAssets
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END
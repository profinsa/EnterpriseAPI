CREATE PROCEDURE RptListInventoryCategories (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   ItemCategoryID,
	ItemFamilyID,
	CategoryName,
	CategoryDescription,
	CategoryLongDescription,
	CategoryPictureURL
   FROM InventoryCategories
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END
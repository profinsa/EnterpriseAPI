CREATE PROCEDURE spCompanyInformation (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN







   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	CompanyName,
	CompanyAddress1,
	CompanyCity,
	CompanyState,
	CompanyZip,
	CompanyCountry,
	CompanyPhone,
	CompanyFax,
	CompanyEmail,
	CompanyWebAddress,
	CompanyLogoUrl,
	CompanyLogoFilename,
	CompanyNotes
   FROM Companies
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID; 


   SET SWP_Ret_Value = 0;
END
CREATE PROCEDURE RptDocReceivingDetailSingleFromReceivingNumber (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_RecivingNumber NATIONAL VARCHAR(36)) BEGIN



   SELECT * FROM PurchaseDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and PurchaseNumber = v_RecivingNumber;
END
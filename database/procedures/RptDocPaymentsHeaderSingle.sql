CREATE PROCEDURE RptDocPaymentsHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
v_DivisionID NATIONAL VARCHAR(36), 
v_DepartmentID NATIONAL VARCHAR(36),
v_PaymentID NATIONAL VARCHAR(36)) BEGIN
   SELECT * FROM PaymentsHeader INNER JOIN VendorInformation On
   PaymentsHeader.VendorID = VendorInformation.VendorID AND
   PaymentsHeader.CompanyID = VendorInformation.CompanyID AND
   PaymentsHeader.DivisionID = VendorInformation.DivisionID AND
   PaymentsHeader.DepartmentID = VendorInformation.DepartmentID
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;
END
CREATE PROCEDURE RptDocPaymentsDetailSingle (v_CompanyID NATIONAL VARCHAR(36), 
v_DivisionID NATIONAL VARCHAR(36), 
v_DepartmentID NATIONAL VARCHAR(36),
v_PaymentID NATIONAL VARCHAR(36)) BEGIN
   SELECT * FROM PaymentsDetail WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and PaymentID = v_PaymentID;
END
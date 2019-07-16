CREATE PROCEDURE Vendor_CreateFromCustomer2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT CustomerID
   From CustomerInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID) then

      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT VendorID
   From VendorInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_CustomerID) then

      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;


   SET @SWV_Error = 0;
   INSERT INTO VendorInformation(CompanyID, DivisionID, DepartmentID, VendorID,   AccountStatus, VendorName,   VendorAddress1,   VendorAddress2,   VendorAddress3,   VendorCity,   VendorState,   VendorZip,   VendorCountry,   VendorPhone,   VendorFax,   VendorEmail,   VendorWebPage,   VendorLogin,   VendorPassword,   VendorPasswordOld,   VendorPasswordDate,   VendorPasswordExpires,   VendorPasswordExpiresDate,   Attention, VendorTypeID,   EDIQualifier, EDIID, EDITestQualifier, EDITestID, EDIContactName, EDIContactAgentFax, EDIContactAgentPhone, EDIContactAddressLine, EDIPurchaseOrders, EDIInvoices, EDIPayments, EDIOrderStatus, EDIShippingNotices, Approved, ApprovedBy, ApprovedDate, EnteredBy, ConvertedFromCustomer)
   SELECT
   CompanyID, DivisionID, DepartmentID, CustomerID, AccountStatus, CustomerName, CustomerAddress1, CustomerAddress2, CustomerAddress3, CustomerCity, CustomerState, CustomerZip, CustomerCountry, CustomerPhone, CustomerFax, CustomerEmail, CustomerWebPage, CustomerLogin, CustomerPassword, CustomerPasswordOld, CustomerPasswordDate, CustomerPasswordExpires, CustomerPasswordExpiresDate, Attention, CustomerTypeID, EDIQualifier, EDIID, EDITestQualifier, EDITestID, EDIContactName, EDIContactAgentFax, EDIContactAgentPhone, EDIContactAddressLine, EDIPurchaseOrders, EDIInvoices, EDIPayments, EDIOrderStatus, EDIShippingNotices, Approved, ApprovedBy, ApprovedDate, EnteredBy, 1
   FROM
   CustomerInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert VendorInformation failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_CreateFromCustomer',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Vendor_CreateFromCustomer',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);

   SET SWP_Ret_Value = -1;
END
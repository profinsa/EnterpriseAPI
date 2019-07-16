CREATE PROCEDURE Customer_CreateFromLead (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_LeadID  NATIONAL VARCHAR(50),
	INOUT v_ReturnValue INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   Set v_ReturnValue = 0;

   IF Exists(SELECT LeadID
   From LeadInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   LeadID = v_LeadID AND
   ConvertedToCustomer = 1) then

      Set v_ReturnValue = 1;
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT CustomerID
   From CustomerInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_LeadID) then

      Set v_ReturnValue = 2;
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;

   SET @SWV_Error = 0;
   INSERT INTO CustomerInformation(CompanyID,
	DivisionID,
	DepartmentID,
	CustomerID,
	CustomerName,
	CustomerAddress1,
	CustomerAddress2,
	CustomerAddress3,
	CustomerCity,
	CustomerState,
	CustomerZip,
	CustomerCountry,
	CustomerPhone,
	CustomerFax,
	CustomerEmail,
	CustomerWebPage,
	CustomerLogin,
	CustomerPassword,
	CustomerFirstName,
	CustomerLastName,
	CustomerSalutation,
	Attention,
	CustomerTypeID)
   SELECT
   CompanyID,
		DivisionID,
		DepartmentID,
		LeadID,
		LeadCompany,
		LeadAddress1,
		LeadAddress2,
		LeadAddress3,
		LeadCity,
		LeadState,
		LeadZip,
		LeadCountry,
		LeadPhone,
		LeadFax,
		LeadEmail,
		LeadWebPage,
		LeadLogin,
		LeadPassword,
		LeadFirstName,
		LeadLastName,
		LeadSalutation,
		Attention,
		LeadTypeID
   FROM
   LeadInformation
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   LeadID = v_LeadID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update CustomerInformation failed';
	
      Set v_ReturnValue = -1;
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_CreateFromLead',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'LeadID',v_LeadID);
      Set v_ReturnValue = -1;
      SET SWP_Ret_Value = -1;
   end if;
		

   SET @SWV_Error = 0;
   UPDATE
   LeadInformation
   SET
   ConvertedToCustomer = 1,ConvertedToCustomerBy = v_EmployeeID,ConvertedToCustomerDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   LeadID = v_LeadID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update LeadInformation failed';
	
      Set v_ReturnValue = -1;
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_CreateFromLead',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'LeadID',v_LeadID);
      Set v_ReturnValue = -1;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   Set v_ReturnValue = -1;

   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_CreateFromLead',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'LeadID',v_LeadID);

   Set v_ReturnValue = -1;
   SET SWP_Ret_Value = -1;
END
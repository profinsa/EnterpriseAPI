CREATE PROCEDURE FinancialsRecalc (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cCustomerInformati CURSOR 
   FOR SELECT 
   CustomerID
   FROM 
   CustomerInformation
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND IFNULL(ConvertedFromVendor,0) = 0;

   DECLARE cVendorInformation CURSOR 
   FOR SELECT 
   VendorID
   FROM 
   VendorInformation
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND IFNULL(ConvertedFromCustomer,0) = 0;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   OPEN cCustomerInformati;
   SET NO_DATA = 0;
   FETCH cCustomerInformati INTO v_CustomerID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL CustomerFinancials_ReCalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cCustomerInformati;
		
         SET v_ErrorMessage = 'CustomerFinancials_Recalc call failed';
         ROLLBACK;


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cCustomerInformati INTO v_CustomerID;
   END WHILE;
   CLOSE cCustomerInformati;


   OPEN cVendorInformation;
   SET NO_DATA = 0;
   FETCH cVendorInformation INTO v_VendorID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus =  VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0  then
	
         CLOSE cVendorInformation;
		
         SET v_ErrorMessage = 'VendorFinancials_Recalc2 call failed';
         ROLLBACK;


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cVendorInformation INTO v_VendorID;
   END WHILE;
   CLOSE cVendorInformation;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'FinancialsRecalc',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END
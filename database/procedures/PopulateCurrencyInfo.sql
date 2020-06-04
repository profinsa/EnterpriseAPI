CREATE PROCEDURE PopulateCurrencyInfo (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TransactionNumber NATIONAL VARCHAR(36),
	v_ParentTable NATIONAL VARCHAR(80),
	INOUT v_Result INT  ,
	INOUT v_CurrencyID NATIONAL VARCHAR(3)  ,
	INOUT v_CurrencyExchangeRate FLOAT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ID NATIONAL VARCHAR(1);
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   Set v_ID = NULL;

   IF v_ParentTable = 'OrderHeader' then

      select   OrderNumber, CurrencyID, CurrencyExchangeRate INTO v_ID,v_CurrencyID,v_CurrencyExchangeRate FROM OrderHeader WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_TransactionNumber;
   ELSE 
      IF v_ParentTable = 'InvoiceHeader' then

         select   InvoiceNumber, CurrencyID, CurrencyExchangeRate INTO v_ID,v_CurrencyID,v_CurrencyExchangeRate FROM InvoiceHeader WHERE CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND InvoiceNumber = v_TransactionNumber;
      ELSE 
         IF v_ParentTable = 'ContractsHeader' then

            select   OrderNumber, CurrencyID, CurrencyExchangeRate INTO v_ID,v_CurrencyID,v_CurrencyExchangeRate FROM ContractsHeader WHERE CompanyID = v_CompanyID
            AND DivisionID = v_DivisionID
            AND DepartmentID = v_DepartmentID
            AND OrderNumber = v_TransactionNumber;
         ELSE 
            IF v_ParentTable = 'PurchaseHeader' then

               select   PurchaseNumber, CurrencyID, CurrencyExchangeRate INTO v_ID,v_CurrencyID,v_CurrencyExchangeRate FROM PurchaseHeader WHERE CompanyID = v_CompanyID
               AND DivisionID = v_DivisionID
               AND DepartmentID = v_DepartmentID
               AND PurchaseNumber = v_TransactionNumber;
            ELSE
               SET v_ErrorMessage = CONCAT('Incorrect parent table name:',v_ParentTable);
	
               SET v_Result = 0;

               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PopulateCurrencyInfo',v_ErrorMessage,
               v_ErrorID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
      end if;
   end if;

   SET @SWV_Error = 0;
   IF v_ID Is Null then 

      SET v_ErrorMessage = CONCAT(' No rows were found in ',v_ParentTable,' with TransactionNumber =',
      v_TransactionNumber);
	
      SET v_Result = 0;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PopulateCurrencyInfo',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = ' Some error...';
	
      SET v_Result = 0;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PopulateCurrencyInfo',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   SET v_Result = 1;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   SET v_Result = 0;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PopulateCurrencyInfo',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END
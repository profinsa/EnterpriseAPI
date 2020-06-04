CREATE PROCEDURE Order_RecalcCustomerCredit2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID  NATIONAL VARCHAR(36),
	INOUT v_AvailibleCredit  DECIMAL(19,4)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(200);
   DECLARE v_BookedOrders DECIMAL(19,4);
   DECLARE v_TotalAR DECIMAL(19,4);
   DECLARE v_CreditLimit DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(v_CompanyCurrencyID,N'') INTO v_CompanyCurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_BookedOrders FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND Posted = 1 
   AND IFNULL(Invoiced,0) = 0; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_TotalAR FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005); 
   select   IFNULL(CreditLimit,0) INTO v_CreditLimit FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   START TRANSACTION;
   SET v_AvailibleCredit = IFNULL(v_CreditLimit,0) -IFNULL(v_BookedOrders,0) -IFNULL(v_TotalAR,0);
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = v_AvailibleCredit
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'CustomerFinancials update failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_RecalcCustomerCredit',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
      SET SWP_Ret_Value = -1;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_RecalcCustomerCredit',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CustomerID',v_CustomerID);
   SET SWP_Ret_Value = -1;
END
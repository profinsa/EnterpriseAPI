CREATE PROCEDURE PaymentCheck_Post2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_Counter SMALLINT;

   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_AppliedAmount DECIMAL(19,4);
   DECLARE v_DocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_CheckDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);


   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPayment CURSOR FOR
   SELECT
   IFNULL(PaymentsHeader.CurrencyID,N''),
		IFNULL(PaymentsHeader.CurrencyExchangeRate,1),
		PaymentsDetail.DocumentNumber,
		IFNULL(PaymentsDetail.AppliedAmount,0)
   FROM
   PaymentsDetail INNER JOIN PaymentChecks ON
   PaymentsDetail.CompanyID = PaymentChecks.CompanyID AND
   PaymentsDetail.DivisionID = PaymentChecks.DivisionID AND
   PaymentsDetail.DepartmentID = PaymentChecks.DepartmentID AND
   PaymentsDetail.PaymentID = PaymentChecks.PaymentID 
   LEFT JOIN PaymentsHeader ON
   PaymentsDetail.PaymentID = PaymentsHeader.PaymentID AND
   PaymentsDetail.CompanyID = PaymentsHeader.CompanyID AND
   PaymentsDetail.DivisionID = PaymentsHeader.DivisionID AND
   PaymentsDetail.DepartmentID = PaymentsHeader.DepartmentID AND
   PaymentsHeader.CheckDate = v_CheckDate
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;			





   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       GET DIAGNOSTICS CONDITION 1
       @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
       SELECT @p1, @p2;
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   PaymentsHeader.PaymentID
   FROM
   PaymentsHeader
   INNER JOIN PaymentsDetail ON
   PaymentsHeader.CompanyID = PaymentsDetail.CompanyID AND
   PaymentsHeader.DivisionID = PaymentsDetail.DivisionID AND
   PaymentsHeader.DepartmentID = PaymentsDetail.DepartmentID AND
   PaymentsHeader.PaymentID = PaymentsDetail.PaymentID
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID AND
   IFNULL(PaymentsHeader.CheckNumber,N'') <> N'' AND
   IFNULL(PaymentsHeader.CheckPrinted,0) = 0 AND
   IFNULL(PaymentsHeader.Paid,0) = 0 AND
   IFNULL(PaymentsDetail.AppliedAmount,0) > 0) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   START TRANSACTION;

	
   SET @SWV_Error = 0;
   CALL PaymentCheck_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'PaymentCheck_CreateGLTransaction call failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
      SET SWP_Ret_Value = -1;
   end if; 


   select   CheckDate, CheckNumber, VendorID INTO v_CheckDate,v_CheckNumber,v_VendorID FROM
   PaymentsHeader WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;			


   OPEN cPayment;

   SET NO_DATA = 0;
   FETCH cPayment INTO v_CurrencyID,v_CurrencyExchangeRate,v_DocumentNumber,v_AppliedAmount;


   WHILE NO_DATA = 0 DO
      select   IFNULL(CurrencyID,N''), IFNULL(CurrencyExchangeRate,1), IFNULL(BalanceDue,0) INTO v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,v_BalanceDue FROM
      PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_DocumentNumber;
      SET @SWV_Error = 0;
      
      select   COUNT(*) INTO v_Counter from PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_DocumentNumber;

      IF v_Counter <> 0 then
	
         IF v_PurchaseCurrencyID <> v_CurrencyID then
            SET v_AppliedAmount =  fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_PurchaseCurrencyExchangeRate/v_CurrencyExchangeRate)*v_AppliedAmount,v_CurrencyID);
         end if;
         SET v_BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BalanceDue -v_AppliedAmount,v_CurrencyID);
         UPDATE
         PurchaseHeader
         SET
         AmountPaid = IFNULL(AmountPaid,0)+v_AppliedAmount,BalanceDue = v_BalanceDue,
         CheckNumber = v_CheckNumber,CheckDate = v_CheckDate,PaidDate = CURRENT_TIMESTAMP,
         Paid =(CASE
         WHEN ABS(v_BalanceDue) <= 0.005 THEN 1
         ELSE 0
         END)
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         PurchaseNumber = v_DocumentNumber;
      end if;
      IF @SWV_Error <> 0 then
	
         CLOSE cPayment;
		
         SET v_ErrorMessage = 'Update PurchaseHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPayment INTO v_CurrencyID,v_CurrencyExchangeRate,v_DocumentNumber,v_AppliedAmount;
   END WHILE;

   CLOSE cPayment;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   NOT ProjectID IS NULL   LIMIT 1;


   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;



      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
      SET SWP_Ret_Value = -1;
   end if;


		

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);

   SET SWP_Ret_Value = -1;
END
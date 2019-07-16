CREATE PROCEDURE ServiceReceipt_Recalc2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_Discount DECIMAL(19,4);
   DECLARE v_CreditAmount DECIMAL(19,4);
	

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;



   select   CurrencyID, CurrencyExchangeRate, IFNULL(CreditAmount,0) INTO v_CurrencyID,v_CurrencyExchangeRate,v_CreditAmount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;	



   select   SUM(IFNULL(WriteOffAmount,0)+IFNULL(DiscountTaken,0)), SUM(IFNULL(AppliedAmount,0)+IFNULL(WriteOffAmount,0)+IFNULL(DiscountTaken,0)) INTO v_Discount,v_Total FROM
   ReceiptsDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;
   SET v_CreditAmount = v_Total; 

   SET @SWV_Error = 0;
   UPDATE
   ReceiptsHeader
   SET
   Amount = v_Total,CreditAmount = v_CreditAmount,UnAppliedAmount = v_Discount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating receipt header totals failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceReceipt_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END
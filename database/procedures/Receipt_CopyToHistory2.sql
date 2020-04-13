CREATE PROCEDURE Receipt_CopyToHistory2 (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID	NATIONAL VARCHAR(36),
	v_ReceiptID  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Work INT;
   DECLARE v_WorkB BOOLEAN;


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT ReceiptID FROM ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID
   AND (ReceiptsHeader.ReceiptClassID = 'Customer')
   AND (NOT (ReceiptsHeader.CreditAmount IS NULL OR ReceiptsHeader.CreditAmount <> 0))) then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;



   select   COUNT(*) INTO v_Work from ReceiptsHeaderHistory where
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;
   IF (v_Work = 0) then

      SET @SWV_Error = 0;
      INSERT INTO ReceiptsHeaderHistory
      SELECT * FROM    ReceiptsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create ReceiptsHeaderHistory';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptNumber',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO ReceiptsDetailHistory(CompanyID,
	DivisionID,
	DepartmentID,
	ReceiptID,
	
	DocumentNumber,
	DocumentDate,
	PaymentID,
	PayedID,
	CurrencyID,
	CurrencyExchangeRate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	ProjectID,
	DetailMemo1,
	DetailMemo2,
	DetailMemo3,
	DetailMemo4,
	DetailMemo5)
      SELECT
      CompanyID,
	DivisionID,
	DepartmentID,
	ReceiptID,
	
	DocumentNumber,
	DocumentDate,
	PaymentID,
	PayedID,
	CurrencyID,
	CurrencyExchangeRate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	ProjectID,
	DetailMemo1,
	DetailMemo2,
	DetailMemo3,
	DetailMemo4,
	DetailMemo5
      FROM ReceiptsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create Receipt Details History';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptNumber',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;



   select   IFNULL(Memorize,0) INTO v_WorkB from ReceiptsHeader where
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;

   IF (v_WorkB <> 1) then

      SET @SWV_Error = 0;
      DELETE FROM         ReceiptsDetail   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from ReceiptsDetail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptNumber',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE FROM         ReceiptsHeader   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND ReceiptID = v_ReceiptID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from ReceiptsHeader failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptNumber',v_ReceiptID);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CopyToHistory',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptNumber',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END
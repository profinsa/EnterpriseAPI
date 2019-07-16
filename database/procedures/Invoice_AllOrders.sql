CREATE PROCEDURE Invoice_AllOrders (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrder CURSOR FOR
   SELECT
   OrderNumber
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Shipped = 1 AND IFNULL(Invoiced,0) = 0 AND 
   LOWER(TransactionTypeID) <> LOWER('Return') AND
   LOWER(TransactionTypeID) <> LOWER('Service Order');

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

   OPEN cOrder;
   SET NO_DATA = 0;
   FETCH cOrder INTO v_OrderNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL Invoice_CreateFromOrder2(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_InvoiceNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cOrder;
		
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AllOrders','',v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cOrder INTO v_OrderNumber;
   END WHILE;

   CLOSE cOrder;


	

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AllOrders','',v_ErrorID);

   SET SWP_Ret_Value = -1;
END
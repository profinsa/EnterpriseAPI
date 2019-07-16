CREATE FUNCTION Receipt_Cash_Auto (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36)) BEGIN














   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_Result SMALLINT;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE  cReceiptsHeader CURSOR FOR
   SELECT 
   ReceiptID 
   FROM 
   ReceiptsHeader
   WHERE
   CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID and
   CustomerID = v_CustomerID and
   Posted = 1 and
	(CreditAmount is null or CreditAmount <> 0);

   DECLARE cInvoiceHeader CURSOR FOR
   SELECT
   InvoiceNumber
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID and
   CustomerID = v_CustomerID and
   Posted = 1 and
   BalanceDue <> 0;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   OPEN cReceiptsHeader;


   SET NO_DATA = 0;
   FETCH cReceiptsHeader INTO v_ReceiptID;

   WHILE NO_DATA = 0 DO
		
      OPEN cInvoiceHeader;
      SET NO_DATA = 0;
      FETCH cInvoiceHeader INTO v_InvoiceNumber;
      WHILE NO_DATA = 0 DO
         CALL Receipt_Cash2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ReceiptID,v_Result);
         IF v_Result = 0 then
						
            RETURN 0;
         end if;
         SET NO_DATA = 0;
         FETCH cInvoiceHeader INTO v_InvoiceNumber;
      END WHILE;
      CLOSE cInvoiceHeader;
		
      SET NO_DATA = 0;
      FETCH cReceiptsHeader INTO v_ReceiptID;
   END WHILE;

   CLOSE cReceiptsHeader;




   RETURN 0;









   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_Cash_Auto',v_ErrorMessage,
   v_ErrorID);


   RETURN -1;
END
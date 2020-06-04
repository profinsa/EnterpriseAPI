CREATE FUNCTION Order_Shipped (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36)) BEGIN








   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_Invoiced BOOLEAN;
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_ShipDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Shipped = 1,ShipDate = IFNULL(ShipDate,CURRENT_TIMESTAMP)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND OrderTypeID <> 'Hold';
	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating order header failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Shipped',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      RETURN -1;
   end if;
   select   ShipDate, Invoiced, InvoiceNumber INTO v_ShipDate,v_Invoiced,v_InvoiceNumber FROM OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND OrderTypeID <> 'Hold';
   IF IFNULL(v_Invoiced,0) = 1 AND IFNULL(v_InvoiceNumber,N'') <> N'' then
      UPDATE
      InvoiceHeader
      SET
      Shipped = 1,ShipDate = v_ShipDate
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

   RETURN 0;






   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Shipped',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   RETURN -1;
END
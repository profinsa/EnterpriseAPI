CREATE FUNCTION Return_Shipped (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36)) BEGIN






















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Shipped = 1,ShipDate = CURRENT_TIMESTAMP
   WHERE
   OrderNumber = v_OrderNumber
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND TransactionTypeID = 'Return';
	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating order header failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Shipped',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      RETURN -1;
   end if;

   RETURN 0;






   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_Shipped',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   RETURN -1;
END
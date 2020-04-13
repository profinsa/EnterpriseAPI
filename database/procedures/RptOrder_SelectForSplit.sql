CREATE PROCEDURE RptOrder_SelectForSplit (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   CREATE TEMPORARY TABLE tt_Temp AS SELECT
      OrderHeader.*,
	(SELECT
         COUNT(*)
         FROM
         OrderDetail
         WHERE
         CompanyID = OrderHeader.CompanyID
         AND OrderNumber = OrderHeader.OrderNumber
         AND DivisionID = OrderHeader.DivisionID
         AND DepartmentID = OrderHeader.DepartmentID)
      AS DetailsNo, 
	(SELECT
         COUNT(*)
         FROM
         OrderDetail
         WHERE
         CompanyID = OrderHeader.CompanyID
         AND OrderNumber = OrderHeader.OrderNumber
         AND DivisionID = OrderHeader.DivisionID
         AND DepartmentID = OrderHeader.DepartmentID
         AND BackOrdered = 1
         AND BackOrderQyyty > 0)
      AS BackOrderedDetailsNo 

      FROM
      OrderHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND Posted = 1
      AND IFNULL(Picked,0) = 0	
      AND IFNULL(Shipped,0) = 0 	
      AND IFNULL(Invoiced,0) = 0;	

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Selecting the orders failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_SelectForSplit',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT * FROM
   tt_Temp
   WHERE
   DetailsNo <> BackOrderedDetailsNo
   AND BackOrderedDetailsNo > 0;

   SET @SWV_Error = 0;
   DROP TEMPORARY TABLE IF EXISTS tt_Temp;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Dropping the temporary table failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_SelectForSplit',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_SelectForSplit',v_ErrorMessage,
   v_ErrorID);


   SET SWP_Ret_Value = -1;
END
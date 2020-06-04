CREATE PROCEDURE Customer_Statement (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SELECT
   CI.CustomerName,

	CI.CustomerCity,
	CI.CustomerState,
	CONCAT(CI.CustomerAddress1,' ',CI.CustomerAddress2,' ',CI.CustomerAddress3,
   ' ') AS CustomerAdress,
	CI.CustomerCountry,
	CI.CustomerZip,

	CI.CreditLimit,
	IH.InvoiceNumber,
	IH.InvoiceDate,
	IH.Total -IH.AmountPaid AS AmountDue,
	TIMESTAMPDIFF(DAY,InvoiceDate,IFNULL(CheckDate,CURRENT_TIMESTAMP)) AS LateDays 
   FROM
   CustomerInformation CI
   INNER JOIN InvoiceHeader IH
   ON(CI.CompanyID = IH.CompanyID
   AND CI.DivisionID = IH.DivisionID
   AND CI.DepartmentID = IH.DepartmentID
   AND CI.CustomerID = IH.CustomerID)
   INNER JOIN CustomerFinancials CF
   ON (CI.CompanyID = CF.CompanyID
   AND CI.DivisionID = CF.DivisionID
   AND CI.DepartmentID = CF.DepartmentID
   AND CI.CustomerID = CF.CustomerID)
   WHERE
   CF.CurrentARBalance <> 0 
   AND (IH.Total > IH.AmountPaid OR IH.AmountPaid IS NULL) 
   ORDER BY
   CI.CustomerName ASC,IH.InvoiceDate DESC;




   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Customer statement failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Statement',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;










   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Customer_Statement',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END
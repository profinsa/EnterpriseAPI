CREATE PROCEDURE Purchase_GetAPInvoiceDiscount (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),
	v_CalcDate DATETIME,
	INOUT v_DiscountPercent FLOAT  ,
	INOUT v_DiscountDays SMALLINT  ,
	INOUT v_DiscountAmount DECIMAL(19,4)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_Diff INT;
   DECLARE v_Total DECIMAL(19,4);


   DECLARE v_ErrorID INT;
   select   Terms.DiscountPercent, Terms.DiscountDays, PurchaseHeader.PurchaseDate, Total INTO v_DiscountPercent,v_DiscountDays,v_PurchaseDate,v_Total FROM
   PurchaseHeader, Terms WHERE
   PurchaseHeader.TermsID = Terms.TermsID
   AND PurchaseHeader.CompanyID = Terms.CompanyID
   AND PurchaseHeader.DivisionID = Terms.DivisionID
   AND PurchaseHeader.DepartmentID = Terms.DepartmentID
   AND PurchaseHeader.CompanyID = v_CompanyID
   AND PurchaseHeader.DivisionID = v_DivisionID
   AND PurchaseHeader.DepartmentID = v_DepartmentID
   AND PurchaseHeader.PurchaseNumber = v_PurchaseNumber;

   SET v_DiscountPercent = IFNULL(v_DiscountPercent,0)/100;


   SET v_Diff = TIMESTAMPDIFF(day,v_PurchaseDate,v_CalcDate); 


   IF v_Diff <= v_DiscountDays then
      SET v_DiscountAmount = ROUND(v_Total*v_DiscountPercent,0);
   end if;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_GetAPInvoiceDiscount',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END
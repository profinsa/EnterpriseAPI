CREATE PROCEDURE RptCurrencyReceipts (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN















	
   SELECT
   CurrencyID,
		
		COUNT(Amount) as NumberofReceipts,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(Amount,0)),CurrencyID) AS TotalReceipts
   FROM
   ReceiptsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Posted = 1 
   GROUP BY
   CurrencyID; 
   SET SWP_Ret_Value = 0;
END
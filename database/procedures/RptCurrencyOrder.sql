CREATE PROCEDURE RptCurrencyOrder (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN

















   SELECT
   CurrencyID,
	COUNT(OrderNumber) AS NumberOfOrders, 
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(Total,0)),CurrencyID) as OrderTotals
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID
   GROUP BY
   CurrencyID; 
	
	

   SET SWP_Ret_Value = 0;
END
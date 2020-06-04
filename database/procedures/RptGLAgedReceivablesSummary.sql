CREATE PROCEDURE RptGLAgedReceivablesSummary (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN














   SELECT
   CustomerInformation.CustomerID,
	CustomerInformation.CustomerName,
	IFNULL(CustomerFinancials.Under30,0) AS Under30,
	IFNULL(CustomerFinancials.Over30,0) AS Over30,
	IFNULL(CustomerFinancials.Over60,0) AS Over60,
	IFNULL(CustomerFinancials.Over90,0) AS Over90,
	IFNULL(CustomerFinancials.Over120,0) AS Over120,
	IFNULL(CustomerFinancials.Over150,0) AS Over150,
	IFNULL(CustomerFinancials.Over180,0) AS Over180
   FROM
   CustomerInformation INNER JOIN CustomerFinancials ON
   CustomerInformation.CompanyID = CustomerFinancials.CompanyID AND
   CustomerInformation.DivisionID = CustomerFinancials.DivisionID AND
   CustomerInformation.DepartmentID = CustomerFinancials.DepartmentID AND
   CustomerInformation.CustomerID = CustomerFinancials.CustomerID
   WHERE
   CustomerInformation.CompanyID = v_CompanyID AND
   CustomerInformation.DivisionID = v_DivisionID AND
   CustomerInformation.DepartmentID = v_DepartmentID AND
	(IFNULL(CustomerFinancials.Under30,0) <> 0 OR
   IFNULL(CustomerFinancials.Over30,0) <> 0 OR
   IFNULL(CustomerFinancials.Over60,0) <> 0 OR
   IFNULL(CustomerFinancials.Over90,0) <> 0 OR
   IFNULL(CustomerFinancials.Over120,0) <> 0 OR
   IFNULL(CustomerFinancials.Over150,0) <> 0 OR
   IFNULL(CustomerFinancials.Over180,0) <> 0);

	
	

   SET SWP_Ret_Value = 0;
END
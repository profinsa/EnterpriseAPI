CREATE PROCEDURE RptListCustomerCreditReferences (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ReferenceID,
	ReferenceName,
	ReferenceDate,
	ReferenceFactor,
	ReferenceSoldSince,
	ReferenceLastSale,
	ReferenceHighCredit,
	ReferenceCurrentBalance,
	ReferencePastDue,
	ReferencePromptPerc
	
	
	
   FROM CustomerCreditReferences
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END
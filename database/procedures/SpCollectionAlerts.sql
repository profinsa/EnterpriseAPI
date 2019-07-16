CREATE PROCEDURE SpCollectionAlerts (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN





   SELECT
   CustomerID,
	(Over30+Over60+Over90+Over120+Over150+Over180) as Overdue
   FROM CustomerFinancials
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID
   and LOWER(CustomerID) <> 'default'
   and(Over30+Over60+Over90+Over120+Over150+Over180) > 0
   ORDER BY Overdue DESC;
END
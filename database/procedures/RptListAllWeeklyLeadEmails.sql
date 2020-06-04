CREATE PROCEDURE RptListAllWeeklyLeadEmails (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   LeadEmail
   FROM LeadInformation
   WHERE CompanyID = v_CompanyID and
   DivisionID = v_DivisionID and
   DepartmentID = v_DepartmentID and
   TIMESTAMPDIFF(DAY,FirstContacted,CURRENT_TIMESTAMP) > 14 AND
   TIMESTAMPDIFF(DAY,FirstContacted,CURRENT_TIMESTAMP) < 7  AND
   Confirmed = 1;
END
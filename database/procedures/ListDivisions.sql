CREATE PROCEDURE ListDivisions (v_CompanyID NATIONAL VARCHAR(36)) BEGIN
   SELECT
   DISTINCT(DivisionID)
   FROM
   Divisions
   WHERE
   CompanyID = v_CompanyID;
END
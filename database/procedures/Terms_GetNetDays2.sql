CREATE PROCEDURE Terms_GetNetDays2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TermsID NATIONAL VARCHAR(36), 
	INOUT v_NetDays INT) BEGIN








   select   IFNULL(NetDays,0) INTO v_NetDays FROM Terms WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   TermsID = v_TermsID;
END
CREATE PROCEDURE FixedAssets_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AssetID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN







   DECLARE v_AssetStatusID NATIONAL VARCHAR(36);
   DECLARE v_AssetAcutalDisposalDate DATETIME;
   DECLARE v_LastDepreciationDate DATETIME;
   select   AssetAcutalDisposalDate, AssetStatusID, LastDepreciationDate INTO v_AssetAcutalDisposalDate,v_AssetStatusID,v_LastDepreciationDate FROM	FixedAssets WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND AssetID = v_AssetID;

   IF ISDATE(v_AssetAcutalDisposalDate) = 1 OR ISDATE(v_LastDepreciationDate) = 1 OR v_AssetStatusID = 'Disposed' then
      SET v_CanDelete = 0;
   ELSE
      SET v_CanDelete = 1;
   end if;

   
SET SWP_Ret_Value = 0;
END
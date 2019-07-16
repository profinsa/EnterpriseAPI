CREATE PROCEDURE FixedAssetDepreciation_PostAll (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_Result INT ,INOUT SWP_Ret_Value INT) BEGIN



















   DECLARE v_Res INT;
   DECLARE v_Return INT;
   DECLARE v_AssetID NATIONAL VARCHAR(36);
   DECLARE v_PostAsset INT;

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cAssets CURSOR  FOR
   SELECT	AssetID
   FROM	FixedAssets
   WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_Return = 1;





   SELECT	AssetID
   FROM	FixedAssets
   WHERE	CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID;
   SET NO_DATA = 0;
   FETCH cAssets INTO v_AssetID;
   WHILE NO_DATA = 0 DO
      CALL FixedAssetDepreciation_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_AssetID,v_PostAsset, v_Res);
      IF v_Res <> 1 then 
         SET v_Return = 0;
      end if;
      SET NO_DATA = 0;
      FETCH cAssets INTO v_AssetID;
   END WHILE;

   SET SWP_Ret_Value = v_Return;
END
CREATE FUNCTION fnTaxGroup_GetTotalPercent2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupID  NATIONAL VARCHAR(36)) BEGIN






	
   DECLARE v_TotalPercent FLOAT;
   DECLARE v_TaxOnTax FLOAT;
   DECLARE v_curTax FLOAT;
   DECLARE v_prevTax FLOAT;
   DECLARE v_curTaxGroupDetail NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE vend_cursor CURSOR
   FOR select TaxGroupDetail.TaxGroupDetailID
   FROM
   TaxGroups
   INNER JOIN TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID AND
   TaxGroupDetail.DivisionID = TaxGroups.DivisionID AND
   TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroups.TaxGroupID = v_TaxGroupID
   group by TaxGroupDetail.TaxGroupDetailID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_TotalPercent = 0;


   set v_TaxOnTax = 0;

   select   sum(case when TaxGroups.TaxOnTax = 1 then 1 else 0 end) INTO v_TaxOnTax FROM
   TaxGroups WHERE
   TaxGroups.CompanyID = v_CompanyID AND
   TaxGroups.DivisionID = v_DivisionID AND
   TaxGroups.DepartmentID = v_DepartmentID AND
   TaxGroups.TaxGroupID = v_TaxGroupID;


   set v_curTax = 0;
   set v_prevTax = 0;



   OPEN vend_cursor;
   SET NO_DATA = 0;
   FETCH vend_cursor into v_curTaxGroupDetail;
   WHILE NO_DATA = 0 DO
      set v_curTax = fnTaxGroupDetail_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_curTaxGroupDetail);
      if (v_TaxOnTax > 0) then
         set v_prevTax =(1+v_prevTax/100)*v_curTax;
      else
         set v_prevTax = v_curTax;
      end if;
      set v_TotalPercent = v_TotalPercent+v_prevTax;
      SET NO_DATA = 0;
      FETCH vend_cursor into v_curTaxGroupDetail;
   END WHILE;

   CLOSE vend_cursor;
	

	
   RETURN ROUND(v_TotalPercent,4);

END
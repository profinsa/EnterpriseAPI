CREATE FUNCTION fnTaxGroupDetail_GetTotalPercent2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupDetailID  NATIONAL VARCHAR(36)) BEGIN






	
   DECLARE v_TotalPercent FLOAT;
   DECLARE v_TaxOnTax FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_curTax FLOAT;
   DECLARE v_prevTax FLOAT;
   DECLARE vend_cursor CURSOR
   FOR select Taxes.TaxPercent
   FROM
   TaxGroupDetail
   INNER JOIN Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID AND
   TaxGroupDetail.DivisionID = Taxes.DivisionID AND
   TaxGroupDetail.DepartmentID = Taxes.DepartmentID AND
   TaxGroupDetail.TaxID = Taxes.TaxID
   WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_TotalPercent = 0;


   set v_TaxOnTax = 0;

   select   nullif(sum(case when TaxGroupDetail.TaxOnTax = 1 then 1 else 0 end),0) INTO v_TaxOnTax FROM
   TaxGroupDetail WHERE
   TaxGroupDetail.CompanyID = v_CompanyID AND
   TaxGroupDetail.DivisionID = v_DivisionID AND
   TaxGroupDetail.DepartmentID = v_DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;

   if (v_TaxOnTax > 0) then
	


		
      set v_curTax = 0;
      set v_prevTax = 0;



      OPEN vend_cursor;
      SET NO_DATA = 0;
      FETCH vend_cursor into v_curTax;
      WHILE NO_DATA = 0 DO
         set v_prevTax =(1+v_prevTax/100)*v_curTax;
         set v_TotalPercent = v_TotalPercent+v_prevTax;
         SET NO_DATA = 0;
         FETCH vend_cursor into v_curTax;
      END WHILE;
      CLOSE vend_cursor;
		
   else

      select   IFNULL(Sum(IFNULL(Taxes.TaxPercent,0)),0) INTO v_TotalPercent FROM
      TaxGroupDetail
      INNER JOIN Taxes ON
      TaxGroupDetail.CompanyID = Taxes.CompanyID AND
      TaxGroupDetail.DivisionID = Taxes.DivisionID AND
      TaxGroupDetail.DepartmentID = Taxes.DepartmentID AND
      TaxGroupDetail.TaxID = Taxes.TaxID WHERE
      TaxGroupDetail.CompanyID = v_CompanyID AND
      TaxGroupDetail.DivisionID = v_DivisionID AND
      TaxGroupDetail.DepartmentID = v_DepartmentID AND
      TaxGroupDetail.TaxGroupDetailID = v_TaxGroupDetailID;
   end if;

	
   RETURN ROUND(v_TotalPercent,4);

END
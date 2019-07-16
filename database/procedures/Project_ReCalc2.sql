CREATE PROCEDURE Project_ReCalc2 (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID 	NATIONAL VARCHAR(36),
	v_ProjectID 	NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ActualRevenue DECIMAL(19,4);
   DECLARE v_ActualCost DECIMAL(19,4);
   DECLARE v_EstRevenue DECIMAL(19,4);
   DECLARE v_EstCost DECIMAL(19,4);





   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   SET v_ActualRevenue = v_ActualRevenue+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetail IND
   INNER JOIN InvoiceHeader INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('invoice','service invoice')
			
   AND (ABS(INH.BalanceDue) < 0.005) AND (ABS(INH.Total) >= 0.005)),
   0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualRevenue = v_ActualRevenue+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetailHistory IND
   INNER JOIN InvoiceHeaderHistory INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('invoice','service invoice')
			
   AND (ABS(INH.BalanceDue) < 0.005) AND (ABS(INH.Total) >= 0.005)
			
   AND INH.InvoiceNumber NOT IN(SELECT InvoiceNumber
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ActualRevenue = v_ActualRevenue -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetail IND
   INNER JOIN InvoiceHeader INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('return','credit memo')
			
   AND (ABS(INH.BalanceDue) < 0.005) AND (ABS(INH.Total) >= 0.005)),
   0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualRevenue = v_ActualRevenue -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetailHistory IND
   INNER JOIN InvoiceHeaderHistory INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('return','credit memo')
			
   AND (ABS(INH.BalanceDue) < 0.005) AND (ABS(INH.Total) >= 0.005)
			
   AND INH.InvoiceNumber NOT IN(SELECT InvoiceNumber
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ActualRevenue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ActualRevenue,v_CompanyCurrencyID);


   SET v_ActualCost = v_ActualCost+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetail PHD
   INNER JOIN PurchaseHeader PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('purchase order')
			
   AND (IFNULL(PHH.Received,0) = 1) AND (IFNULL(PHH.Paid,0) = 1)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualCost = v_ActualCost+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetailHistory PHD
   INNER JOIN PurchaseHeaderHistory PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('purchase order')
			
   AND (IFNULL(PHH.Received,0) = 1) AND (IFNULL(PHH.Paid,0) = 1)
			
   AND PHH.PurchaseNumber NOT IN(SELECT PurchaseNumber
      FROM PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualCost = v_ActualCost -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetail PHD
   INNER JOIN PurchaseHeader PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('debit memo','rma')
			
   AND (IFNULL(PHH.Received,0) = 1) AND (IFNULL(PHH.Paid,0) = 1)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualCost = v_ActualCost -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetailHistory PHD
   INNER JOIN PurchaseHeaderHistory PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('debit memo','rma')
			
   AND (IFNULL(PHH.Received,0) = 1) AND (IFNULL(PHH.Paid,0) = 1)
			
   AND PHH.PurchaseNumber NOT IN(SELECT PurchaseNumber
      FROM PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ActualCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ActualCost,v_CompanyCurrencyID);



   SET v_EstRevenue = v_EstRevenue+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetail IND
   INNER JOIN InvoiceHeader INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('invoice','service invoice')),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstRevenue = v_EstRevenue+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetailHistory IND
   INNER JOIN InvoiceHeaderHistory INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('invoice','service invoice')
			
   AND INH.InvoiceNumber NOT IN(SELECT InvoiceNumber
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstRevenue = v_EstRevenue -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetail IND
   INNER JOIN InvoiceHeader INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('return','credit memo')),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstRevenue = v_EstRevenue -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(IND.SubTotal,0)*IFNULL(INH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   InvoiceDetailHistory IND
   INNER JOIN InvoiceHeaderHistory INH ON
   INH.InvoiceNumber = IND.InvoiceNumber
   AND INH.CompanyID = IND.CompanyID
   AND INH.DivisionID = IND.DivisionID
   AND INH.DepartmentID = IND.DepartmentID
   WHERE
   IND.CompanyID = v_CompanyID
   AND IND.DivisionID = v_DivisionID
   AND IND.DepartmentID = v_DepartmentID
   AND IND.ProjectID = v_ProjectID
   AND IFNULL(INH.Posted,0) = 1
   AND LOWER(INH.TransactionTypeID) IN('return','credit memo')
			
   AND INH.InvoiceNumber NOT IN(SELECT InvoiceNumber
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstRevenue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_EstRevenue,v_CompanyCurrencyID);


   SET v_EstCost = v_EstCost+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetail PHD
   INNER JOIN PurchaseHeader PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('purchase order')),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstCost = v_EstCost+IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetailHistory PHD
   INNER JOIN PurchaseHeaderHistory PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('purchase order')
			
   AND PHH.PurchaseNumber NOT IN(SELECT PurchaseNumber
      FROM PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstCost = v_EstCost -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetail PHD
   INNER JOIN PurchaseHeader PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('debit memo','rma')),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstCost = v_EstCost -IFNULL((SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(PHD.Total,0)*IFNULL(PHH.CurrencyExchangeRate,1.)), 
   v_CompanyCurrencyID)
   FROM
   PurchaseDetailHistory PHD
   INNER JOIN PurchaseHeaderHistory PHH ON
   PHH.PurchaseNumber = PHD.PurchaseNumber
   AND PHH.CompanyID = PHD.CompanyID
   AND PHH.DivisionID = PHD.DivisionID
   AND PHH.DepartmentID = PHD.DepartmentID
   WHERE
   PHD.CompanyID = v_CompanyID
   AND PHD.DivisionID = v_DivisionID
   AND PHD.DepartmentID = v_DepartmentID
   AND PHD.ProjectID = v_ProjectID
   AND IFNULL(PHH.Posted,0) = 1
   AND LOWER(PHH.TransactionTypeID) IN('debit memo','rma')
			
   AND PHH.PurchaseNumber NOT IN(SELECT PurchaseNumber
      FROM PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID)),0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_EstCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_EstCost,v_CompanyCurrencyID);

   SET @SWV_Error = 0;
   UPDATE
   Projects
   SET
   ProjectActualRevenue = v_ActualRevenue,ProjectActualCost = v_ActualCost,
   ProjectEstRevenue = v_EstRevenue,ProjectEstCost = v_EstCost
   WHERE
   ProjectID = v_ProjectID 
   AND CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating project failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Project_ReCalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ProjectID',v_ProjectID);

   SET SWP_Ret_Value = -1;
END
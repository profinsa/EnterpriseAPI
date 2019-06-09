update databaseinfo set value='2019_06_09',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP PROCEDURE IF EXISTS RMA_Post2;
//
CREATE                            PROCEDURE RMA_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


























/*
Name of stored procedure: RMA_Post
Method: 
	Posts a RMA order to the system and updates Customer Financials

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the RMA number

Output Parameters:

	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user

Called From:

	Purchase_Control, RMA_Post.vb

Calls:

	Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, VerifyCurrency, Terms_GetNetDays, Vendor_CreateFromCustomer, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_Total DECIMAL(19,4);


   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CustomerCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseAmount DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);

   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_NetDays INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber,
		ItemID, 
		WarehouseID, 
		WarehouseBinID,
		IFNULL(OrderQty,0),
		IFNULL(Total,0)
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'RMA was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
		(IFNULL(OrderQty,0) = 0 OR IFNULL(ItemUnitPrice,0) = 0) AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'RMA was not posted: there is the RMA detail item with undefined Total value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
-- if purchase is posted return
   select   IFNULL(Posted,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0), IFNULL(VendorInvoiceNumber,'') INTO v_PurchasePosted,v_PurchaseCancelDate,v_PurchasePaid,v_AmountPaid,v_OrderNumber FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF v_PurchasePosted <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- if order is canceled
-- or order is not posted exit the procedure
   IF ((NOT v_PurchaseCancelDate IS NULL) AND v_PurchaseCancelDate < CURRENT_TIMESTAMP) then

      SET v_PostingResult = 'RMA was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;



   IF NOT EXISTS(SELECT
   InvoiceNumber
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_OrderNumber
   UNION
   SELECT
   InvoiceNumber
   FROM
   InvoiceHeaderHistory
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_OrderNumber) then

      SET v_PostingResult = CONCAT('RMA was not posted: there is no Customer invoice number ',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;




   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL RMA_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
-- EXEC @ReturnStatus = enterprise.RMA_Recalc @CompanyID, @DivisionID, @DepartmentID, @PurchaseNumber
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the RMA failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- credit the invenory
-- get the warehouse for the order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForPurchase call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- create cursor for iteration of purchase details	
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty, 
   v_Total;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
      v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,1,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty, 
      v_Total;
   END WHILE;

   CLOSE cPurchaseDetail;


-- get the purchase amount


-- get values from PurchaseHeader
   select   VendorID, IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_CustomerID,v_PurchaseAmount,v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,
   v_PurchaseDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- transform if necessary (different currencies)
   IF v_PurchaseCurrencyID <> v_CompanyCurrencyID then

      SET v_PurchaseAmount = v_PurchaseAmount*v_PurchaseCurrencyExchangeRate;
   end if;
-- check special terms
   select   TermsID INTO v_TermsID FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   SET @SWV_Error = 0;
   CALL Terms_GetNetDays2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE PurchaseHeader
   SET
   PurchaseHeader.TermsID = v_TermsID,PurchaseHeader.PurchaseDueDate = TIMESTAMPADD(Day,v_NetDays,PurchaseDate)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   UPDATE
   PurchaseHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL Vendor_CreateFromCustomer2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Vendor_CreateFromCustomer call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- update Customer financials
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   RMAs = IFNULL(RMAs,0)+v_PurchaseAmount,LastRMADate = v_PurchaseDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update CustomerFinancials failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	


-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RMA_Cancel;
//
CREATE            PROCEDURE RMA_Cancel(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: RMA_Cancel
Method: 
	Cancels a non-received RMA order

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the RMA number

Output Parameters:

	NONE

Called From:

	RMA_Cancel.vb

Calls:

	VerifyCurrency, Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;

   DECLARE v_Received BOOLEAN;
   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;

   DECLARE v_IsOverflow BOOLEAN;

-- if purchase is posted return
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber, 
		ItemID, WarehouseID, WarehouseBinID, IFNULL(OrderQty,0)
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   IFNULL(Received,0), IFNULL(Posted,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate, VendorID INTO v_Received,v_PurchasePosted,v_PurchaseCancelDate,v_PurchasePaid,v_AmountPaid,
   v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;



-- if order is canceled
-- or order is not posted exit the procedure
   IF 	v_PurchasePosted = 0
   OR v_PurchasePaid <> 0
   OR v_AmountPaid <> 0
   OR v_Received <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- get the warehouse for the order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForRMA call failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- create cursor for iteration of purchase details	
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty;

   WHILE NO_DATA = 0 DO
	-- update the quantity in inventory
	-- use the warehouse of the purchase detail or of purchase order
      IF v_Received = 0 then
		
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
         v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,3,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cPurchaseDetail;
				
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;
-- the error handler

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
         v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,4,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cPurchaseDetail;
				
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;
-- the error handler

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty;
   END WHILE;


   CLOSE cPurchaseDetail;



-- cancel the purchase
   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Posted = 0
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update RMAHeader failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).

   ROLLBACK;
-- the error handler

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Cancel',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;










//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RMA_Recalc;
//
CREATE             PROCEDURE RMA_Recalc(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


















/*
Name of stored procedure: RMA_Recalc
Method: 
	Calculates the amounts of money for a specified RMA

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR (36)	 - the RMA number

Output Parameters:

	NONE

Called From:

	RMAReceiving_Post, RMA_Recalc.vb

Calls:

	TaxGroup_GetTotalPercent, VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Paid BOOLEAN;

   DECLARE v_TaxPercent FLOAT;
   DECLARE v_HeaderTaxPercent FLOAT;

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemSubtotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);

   DECLARE v_tmp NATIONAL VARCHAR(100);
-- get the information about the order status
   DECLARE SWV_cPurchaseDetail_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_PurchaseNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cPurchaseDetail_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR 
   FOR SELECT 
   IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0),
		IFNULL(DiscountPerc,0),
		IFNULL(Taxable,0),
		IFNULL(TaxGroupID,N''), CompanyID,DivisionID,DepartmentID,PurchaseNumber,PurchaseLineNumber
   FROM 
   PurchaseDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_TaxPercent = 0;
   select   IFNULL(Posted,0), IFNULL(Paid,0) INTO v_Posted,v_Paid FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;	

   IF v_Posted = 1 then

      IF v_Paid = 1 then 
	-- if the order is posted and Paid return
	
         SET SWP_Ret_Value = 0;
         LEAVE SWL_return;
      end if;
   end if;

-- get the currency id for the order header

   select   CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), TaxGroupID INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_HeaderTaxGroupID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_HeaderTaxGroupID,v_HeaderTaxPercent);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_HeaderTaxPercent = IFNULL(v_HeaderTaxPercent,0);

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the details Totals
   SET v_Subtotal = 0;
   SET v_ItemSubtotal = 0;
   SET v_TotalTaxable = 0;
   SET v_DiscountAmount = 0;
   SET v_TaxAmount = 0;
   SET v_Total = 0;

-- open the cursor and get the first row
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO  v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
   SWV_cPurchaseDetail_CompanyID,SWV_cPurchaseDetail_DivisionID,SWV_cPurchaseDetail_DepartmentID,
   SWV_cPurchaseDetail_PurchaseNumber,SWV_cPurchaseDetail_PurchaseLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_TaxPercent = 0;
      SET v_ItemTaxAmount = 0;
	-- update totals
      SET v_ItemSubtotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice, 
      v_CompanyCurrencyID);
      SET v_Subtotal = v_Subtotal+v_ItemSubtotal;
      SET v_DiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount+v_ItemOrderQty*v_ItemUnitPrice*v_ItemDiscountPerc/100,v_CompanyCurrencyID);
    -- recalculate the Total for every line of the Order; the total for a line is = OrderQty * ItemUnitPrice * ( 100 - DiscountPerc )/100
      SET v_ItemTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemOrderQty*v_ItemUnitPrice*(100 -v_ItemDiscountPerc)/100, 
      v_CompanyCurrencyID);
      IF v_TaxGroupID <> N'' then
		
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TaxPercent);
         IF @SWV_Error <> 0 then
			
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET v_Total = v_Total+v_ItemTotal;
      IF v_ItemTaxable = 1 then
	
         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TaxPercent = v_HeaderTaxPercent;
         end if;
         SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_ItemTotal*v_TaxPercent)/100, 
         v_CompanyCurrencyID);
         SET v_TaxAmount = v_TaxAmount+v_ItemTaxAmount;
         SET v_TotalTaxable = v_TotalTaxable+v_ItemTotal;
         SET v_ItemTotal = v_ItemTotal+v_ItemTaxAmount;
      end if;

	-- update item total
      SET @SWV_Error = 0;
      UPDATE PurchaseDetail
      SET
      Total = v_ItemTotal,SubTotal = v_ItemSubtotal,TaxPercent = v_TaxPercent,
      TaxGroupID = v_TaxGroupID,TaxAmount = v_ItemTaxAmount
      WHERE PurchaseDetail.CompanyID = SWV_cPurchaseDetail_CompanyID AND PurchaseDetail.DivisionID = SWV_cPurchaseDetail_DivisionID AND PurchaseDetail.DepartmentID = SWV_cPurchaseDetail_DepartmentID AND PurchaseDetail.PurchaseNumber = SWV_cPurchaseDetail_PurchaseNumber AND PurchaseDetail.PurchaseLineNumber = SWV_cPurchaseDetail_PurchaseLineNumber;
      IF @SWV_Error <> 0 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'Updating order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_ItemOrderQty,v_ItemUnitPrice,v_ItemDiscountPerc,v_ItemTaxable,v_TaxGroupID,
      SWV_cPurchaseDetail_CompanyID,SWV_cPurchaseDetail_DivisionID,SWV_cPurchaseDetail_DepartmentID,
      SWV_cPurchaseDetail_PurchaseNumber,SWV_cPurchaseDetail_PurchaseLineNumber;
   END WHILE;
   CLOSE cPurchaseDetail;




   IF v_Handling > 0 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Handling*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   IF v_Freight > 0 AND v_TaxFreight = 1 then
      SET v_TaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount+v_Freight*v_HeaderTaxPercent/100, 
      v_CompanyCurrencyID);
   end if;
   SET v_Total = v_Total+v_Handling+v_Freight+v_TaxAmount;

   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = v_DiscountAmount,TaxableSubTotal = v_TotalTaxable,
   TaxPercent = v_HeaderTaxPercent,TaxAmount = v_TaxAmount,
   Total = v_Total,BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -IFNULL(AmountPaid,0), 
   v_CompanyCurrencyID)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;

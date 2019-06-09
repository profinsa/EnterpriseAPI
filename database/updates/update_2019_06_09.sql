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
   IF v_ReturnStatus = -1 then

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

DELIMITER //
DROP PROCEDURE IF EXISTS RMAReceiving_Post;
//
CREATE PROCEDURE RMAReceiving_Post(v_CompanyID NATIONAL VARCHAR(36)
	,v_DivisionID NATIONAL VARCHAR(36)
	,v_DepartmentID NATIONAL VARCHAR(36)
	,v_PurchaseNumber NATIONAL VARCHAR(36)
	,INOUT v_Success INT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: RMAReceiving_Post
Method:
	Posts a receiving into the system
	Stored procedure used to post a receive
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the RMA number
Output Parameters:
	@Success INT  			 - RETURN VALUES for the @Success output parameter:
							   1 succes
							   0 error while processin data
							   2 error on geting time Period
Called From:
	RMAReceiving_Post.vb
Calls:
	RMA_Recalc, Receiving_UpdateInventoryCosting, Error_InsertError, RMAReceiving_AdjustCustomerFinancials, LedgerMain_VerifyPeriod, Error_InsertErrorDetail, Receiving_AdjustInventory, Payment_CreateFromRMA, RMAReceiving_CreateGLTransaction
Last Modified:
Last Modified By:
Revision History:
*/

-- variables declarations
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_NewPaymentID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;

-- initialize the success flag of this procedure to 1 (which signifies succes)
-- If an error will occurre in the procedure this flag will be set to 0 or 2 (which signifies an error)
   SET @SWV_Error = 0;
   SET v_Success = 1;
   SET v_ErrorMessage = '';

-- get the current rule for post date for the company from the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM Companies WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

-- begin the posting process
   IF v_PostDate = '1' then
	-- if the post Period is set to true
	-- the transaction date is the current date
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
	-- if the post Period is set to false
	-- the transaction date is the purchase date
      select   PurchaseDate INTO v_TranDate FROM PurchaseHeader WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
   end if;

-- verify the Period of time the posting will take place
-- call a procedure (LedgerMain_VerifyPeriod) which will verify if the Period to post is closed or not
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

-- if the Period to post is closed the posted cannot be done and the procedure will return an error
   IF v_PeriodClosed <> 0
   OR v_ReturnStatus = -1 then
	

-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;

-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;

   START TRANSACTION;

-- recalc the purchase order
   CALL RMA_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'RMA_Recalc call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- get the information about the Vendor, Currency and the ammount of money from the purchase order
   select   IFNULL(AmountPaid,0), IFNULL(Total,0), VendorID INTO v_AmountPaid,v_Total,v_CustomerID FROM PurchaseHeader WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   UPDATE PurchaseDetail
   SET ReceivedQty = IFNULL(OrderQty,0),ReceivedDate = IFNULL(ReceivedDate,CURRENT_TIMESTAMP)
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

-- debit the inventory from the OnOrder field, and credit OnHand field
   SET @SWV_Error = 0;
   CALL Receiving_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustInventory call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- update inventory costing
   SET @SWV_Error = 0;
   CALL Receiving_UpdateInventoryCosting2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_UpdateInventoryCosting call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Adjust Vendor Finacials information
   SET @SWV_Error = 0;
   CALL RMAReceiving_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustVendorFinancials call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- if a payment was made for the order that is received this payment must be returned
-- and the vendor financials must be updated
   SET @SWV_Error = 0;
   CALL Payment_CreateFromRMA(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_NewPaymentID, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Payment_CreateFromRMA call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_PaymentID = v_NewPaymentID;

   SET @SWV_Error = 0;
   CALL Payment_CreateCreditMemo(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Payment_CreateCreditMemo call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   UPDATE PurchaseHeader
   SET Received = 1,ReceivedDate = CURRENT_TIMESTAMP
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   UPDATE PurchaseDetail
   SET Received = 1
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

-- get the transaction number
   SET @SWV_Error = 0;
   CALL RMAReceiving_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PostDate, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'RMAReceiving_CreateGLTransaction call failed';
      ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
   SET v_Success = 2;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;

-- Change return status if it was not changed iside error checking procedure
   IF v_Success = 1 then

      SET v_Success = 0;
   end if;

-- Process error only if @ErrorMessage was set during error checking
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
      v_PurchaseNumber);
   end if;

   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RMAReceiving_AdjustCustomerFinancials;
//
CREATE          PROCEDURE RMAReceiving_AdjustCustomerFinancials(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
















/*
Name of stored procedure: RMAReceiving_AdjustCustomerFinancials
Method: 
	We need to un-do the order postings, 
	First, minus the order total from the booked orders, and add the amount back onto the available credit.
	Also, check, if available credit > credit limit set in Customer Information table, then available credit = credit limit.
	Update the Invoices YTD Field, set InvoicesYTD = InvoicesYTD + This Invoice.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR (36)	 - the RMA number

Output Parameters:

	NONE

Called From:

	RMAReceiving_Post

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);

-- select informations about the customer,
-- the total value of the order
-- the currency of the order and the exchange rate
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   VendorID, IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   RMAs = IFNULL(RMAs,0) -v_ConvertedTotal,RMAsYTD = IFNULL(RMAsYTD,0)+v_ConvertedTotal,
   RMAsLifetime = IFNULL(RMAsLifetime,0)+v_ConvertedTotal
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_PurchaseNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_AdjustCustomerFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;












//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RMAReceiving_CreateGLTransaction;
//
CREATE                     PROCEDURE RMAReceiving_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseOrderNumber NATIONAL VARCHAR(36),
	v_PostDate  NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


















/*
Name of stored procedure: RMAReceiving_CreateGLTransaction
Method: 
	Creates a new GL transaction from an RMA receiving

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseOrderNumber NVARCHAR(36) - the RMA number
	@PostDate NVARCHAR(1)			 - defines the date of GL transaction

							   1 - the current date

							   0 - the RMA date

Output Parameters:

	NONE

Called From:

	RMAReceiving_Post

Calls:

	VerifyCurrency, GetNextEntityID, TaxGroup_GetTotalPercent, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_InventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;

   DECLARE v_TranDate DATETIME;
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxAmount DECIMAL(19,4);
   DECLARE v_HeaderTaxPercent FLOAT;
   DECLARE v_GLAPCOGSAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
-- get the information about the Vendor, Currency and the ammount of money from the purchase order

   DECLARE v_TaxAccount NATIONAL VARCHAR(36);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_TotalTaxPercent FLOAT;
   DECLARE v_ItemProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLTaxAccount NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_TaxPercent FLOAT;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   SUM(IFNULL(TaxAmount,0)),
		TaxGroupID,
		TaxPercent,
		ProjectID
		
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber AND 
   IFNULL(Total,0) > 0
   GROUP BY
   TaxGroupID,TaxPercent,ProjectID;

   DECLARE cTax CURSOR FOR
   SELECT 
   IFNULL(Taxes.TaxPercent,0), 
		IFNULL(Taxes.GLTaxAccount,(SELECT GLARMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID))
   FROM 
   TaxGroups

   INNER JOIN  TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID
   AND TaxGroupDetail.DivisionID = TaxGroups.DivisionID
   AND TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID
   AND TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   INNER JOIN  Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID
   AND TaxGroupDetail.DivisionID = Taxes.DivisionID
   AND TaxGroupDetail.DepartmentID = Taxes.DepartmentID
   AND TaxGroupDetail.TaxID = Taxes.TaxID

   WHERE 
   TaxGroups.CompanyID = v_CompanyID
   AND TaxGroups.DivisionID = v_DivisionID
   AND TaxGroups.DepartmentID = v_DepartmentID
   AND TaxGroups.TaxGroupID = v_TaxGroupID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(AmountPaid,0), IFNULL(Total,0), IFNULL(Freight,0), IFNULL(Handling,0), IFNULL(DiscountAmount,0), GLPurchaseAccount, TaxGroupID, IFNULL(TaxAmount,0), IFNULL(TaxPercent,0), CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PurchaseDate END INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_AmountPaid,v_Total,
   v_Freight,v_Handling,v_DiscountAmount,v_InventoryAccount,v_HeaderTaxGroupID,
   v_HeaderTaxAmount,v_HeaderTaxPercent,v_TranDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM  PurchaseDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseOrderNumber
   AND NOT ProjectID IS NULL   LIMIT 1;



-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

-- insert the necessary entries into LedgerTransactions table
-- set the transaction type to Receiving and the date to the current
-- date or to purchase date depending on the value of @PostDate
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionAmountUndistributed,
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'RMA Receiving',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PurchaseDate END ,
		VendorID,
		PurchaseNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedTotal,
		0,
		0,
		1,
		CONCAT('RMAREC ',cast(PurchaseNumber as char(10))),
		1
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert Header into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

	
-- create temporary table to retain information about transaction details
-- This informations will be written into the LedgerTransactionDetail after some processing.
-- The temporary table definition contains the column's definitions and the informations
-- about primary key of the temporary table.
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;

-- Get default company Accounts
   select   GLAPAccount, GLAPInventoryAccount, GLARCOGSAccount INTO v_GLAPAccount,v_GLAPInventoryAccount,v_GLAPCOGSAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
	
   SET v_InventoryAccount = IFNULL(v_InventoryAccount,v_GLAPInventoryAccount);

-- Debit Freight to GLAPFreightAccount
   SET @SWV_Error = 0;
   IF v_Freight > 0 then

      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
      SELECT
      Companies.GLAPFreightAccount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Freight*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
	0,
	v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Freight Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Debit Handling to GLAPHandlingAccount
   IF v_Handling > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      GLAPHandlingAccount,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Handling*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
		0,
		v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing Handling Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- insert the record for @TaxAmount
-- we will redistribute @TaxAmount between different GLTaxAccounts included to Invoice tax group
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   WHILE NO_DATA = 0 DO
      IF v_TaxAmount > 0 then

         IF v_TaxGroupID = N'' then
            SET @SWV_Null_Var = 0;
         end if;
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TotalTaxPercent);
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	-- the error handler
	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         OPEN cTax;
         SET NO_DATA = 0;
         FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         WHILE NO_DATA = 0 DO
            IF v_TotalTaxPercent <> 0 then
               SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount*v_CurrencyExchangeRate*v_TaxPercent/v_TotalTaxPercent, 
               v_CompanyCurrencyID);
            ELSE
               SET v_ItemTaxAmount = 0;
            end if;


	-- Debit Tax to Tax Account
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLTaxAccount,
		v_ItemTaxAmount,
		0,
		v_ProjectID);
	
            IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
               SET v_ErrorMessage = 'Error Processing Tax Data';
               CLOSE cTax;
		
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	-- the error handler
	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
            SET NO_DATA = 0;
            FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         END WHILE;
         CLOSE cTax;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   END WHILE;
   CLOSE cPurchaseDetail;
   SET @SWV_Error = 0;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Tax Update';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Credit DiscountAmount to GLAPDiscountAccount
   IF v_DiscountAmount > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      GLAPDiscountAccount,
		0,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
		v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing GL Discount Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- Credit Total to Account Payable
   IF v_Total > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLAPAccount,
		0,
		v_ConvertedTotal,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing AP Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;


-- Debit SubTotal To Inventory Account
-- Detail item can have different Inventroy Accounts,
-- so we post it as sum of detail Totals grouped by Account and ProjectID
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLPurchaseAccount,v_InventoryAccount),
	SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SubTotal*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID)),
	0,
	ProjectID
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber AND
   IFNULL(SubTotal,0) > 0
   GROUP BY
   IFNULL(GLPurchaseAccount,v_InventoryAccount),ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Inventory Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- insert the data into the LedgerTransactionsDetail table; 
-- the records are grouped by GLTransactionAccount and ProjectID
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		GLTransactionAccount,
		SUM(GLDebitAmount),
		SUM(GLCreditAmount),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Everything is  OK
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

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Payment_CreateCreditMemo;
//
CREATE       PROCEDURE Payment_CreateCreditMemo(v_CompanyID 		NATIONAL VARCHAR(36),
	v_DivisionID 		NATIONAL VARCHAR(36),
	v_DepartmentID 		NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Payment_CreateCreditMemo
Method: 
	Creates a Credit memo from a Payment

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PaymentID NVARCHAR(36)		 - ID of the payment

Output Parameters:

	NONE

Called From:

	Payment_CreateCreditMemo.vb

Calls:

	GetNextEntityID, Customer_CreateFromVendor, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_CreditAmount DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Void BOOLEAN;
   DECLARE v_GLDefaultSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);

-- get vendor id
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      select   VendorID, IFNULL(CreditAmount,0), IFNULL(Posted,0), IFNULL(Void,0) INTO v_VendorID,v_CreditAmount,v_Posted,v_Void FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;

-- IF @Void = 1 OR @Posted = 0 OR @CreditAmount<=0
-- 	Return 0

      If v_Void = 1 then

         SET v_ReturnStatus = -4;
         SET v_ErrorMessage = CONCAT('The payment is void for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      If v_CreditAmount <= 0 then

         SET v_ReturnStatus = -5;
         SET v_ErrorMessage = CONCAT('The credit amount is 0 or less than 0 for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      if v_Posted = 0 then

         SET v_ReturnStatus = -6;
         SET v_ErrorMessage = CONCAT('The payment is not yet posted for PaymentID:',v_PaymentID);
         LEAVE WriteError;
      end if;
      START TRANSACTION;
      select   ProjectID INTO v_ProjectID FROM
      PaymentsDetail WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID
      AND NOT ProjectID IS NULL   LIMIT 1;

-- Get default values from Companies table for
-- Sales Account, Account Payable and PeriodPosting flag
      select   GLARSalesAccount, GLAPAccount INTO v_GLDefaultSalesAccount,v_GLAPAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;

-- get the credit memo number
      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextInvoiceNumber',v_CreditMemoNumber, v_ReturnStatus);
-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'GetNextEntityID call failed';
         LEAVE WriteError;
      end if;


-- convert vendor to customer
      SET @SWV_Error = 0;
      CALL Customer_CreateFromVendor(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID, v_ReturnStatus);
-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'Customer_CreateFromVendor call failed';
         LEAVE WriteError;
      end if;


-- create the Credit memo header getting all the data from the payment
      SET @SWV_Error = 0;
      INSERT INTO InvoiceHeader(CompanyID,
	DivisionID,
	DepartmentID,
	InvoiceNumber,
	OrderNumber ,
	TransactionTypeID,
	InvoiceDate,
	InvoiceDueDate,
	InvoiceShipDate,
	InvoiceCancelDate,
	SystemDate,
	PurchaseOrderNumber,
	TaxExemptID,
	TaxGroupID,
	CustomerID,
	TermsID,
	CurrencyID,
	CurrencyExchangeRate,
	Subtotal,
	DiscountPers,
	DiscountAmount,
	TaxPercent,
	TaxAmount,
	TaxableSubTotal,
	Freight,
	TaxFreight,
	Handling,
	Advertising,
	Total,
	EmployeeID,
	Commission,
	CommissionableSales,
	ComissionalbleCost,
	CustomerDropShipment,
	ShipMethodID,
	WarehouseID,
	ShipToID,
	ShipForID,
	ShippingName,
	ShippingAddress1,
	ShippingAddress2,
	ShippingAddress3,
	ShippingCity,
	ShippingState,
	ShippingZip,
	ShippingCountry,
	GLSalesAccount,
	PaymentMethodID,
	AmountPaid,
	BalanceDue,
	UndistributedAmount,
	CheckNumber,
	CheckDate,
	CreditCardTypeID,
	CreditCardName,
	CreditCardNumber,
	CreditCardExpDate,
	CreditCardCSVNumber,
	CreditCardBillToZip,
	CreditCardValidationCode,
	CreditCardApprovalNumber,
	Picked,
	PickedDate,
	Printed,
	PrintedDate,
	Shipped,
	ShipDate,
	TrackingNumber,
	BilledDate,
	Billed,
	Backordered,
	Posted,
	PostedDate,
	HeaderMemo1,
	HeaderMemo2,
	HeaderMemo3,
	HeaderMemo4,
	HeaderMemo5,
	HeaderMemo6,
	HeaderMemo7,
	HeaderMemo8,
	HeaderMemo9)
      SELECT
      v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_CreditMemoNumber,
	NULL,
	'Credit Memo',
	PaymentDate, -- InvoiceDate,
	DueToDate, -- InvoiceDueDate,
	now(), -- InvoiceShipDate,
	now(), -- InvoiceCancelDate,
	now(), -- SystemDate,
	NULL, -- PurchaseOrderNumber,
	NULL, -- TaxExemptID,
	NULL, -- TaxGroupID,
	VendorID, -- CustomerID,
	NULL, -- TermsID,
	CurrencyID, -- CurrencyID,
	CurrencyExchangeRate, -- CurrencyExchangeRate,
	v_CreditAmount, -- Subtotal,
	0, -- DiscountPers,
	0, -- DiscountAmount,
	0, -- TaxPercent,
	0, -- TaxAmount,
	0, -- TaxableSubTotal,
	0, -- Freight,
	0, -- TaxFreight,
	0, -- Handling,
	0, -- Advertising,
	v_CreditAmount, -- Total,
	NULL, -- EmployeeID,
	NULL, -- Commission,

	NULL, -- CommissionableSales,
	NULL, -- ComissionalbleCost,
	NULL, -- CustomerDropShipment,
	NULL, -- ShipMethodID,
	NULL, -- WarehouseID,
	NULL, -- ShipToID,
	NULL, -- ShipForID,
	NULL, -- ShippingName,
	NULL, -- ShippingAddress1,
	NULL, -- ShippingAddress2,

	NULL, -- ShippingAddress3,
	NULL, -- ShippingCity,
	NULL, -- ShippingState,
	NULL, -- ShippingZip,
	NULL, -- ShippingCountry,
	NULL, -- GLSalesAccount,
	NULL, -- PaymentMethodID,
	0, -- AmountPaid,
	v_CreditAmount, -- BalanceDue,
	0, -- UndistributedAmount,
	NULL, -- CheckNumber,
	NULL, -- CheckDate,
	NULL, -- CreditCardTypeID,
	NULL, -- CreditCardName,
	NULL, -- CreditCardNumber,
	NULL, -- CreditCardExpDate,
	NULL, -- CreditCardCSVNumber,
	NULL, -- CreditCardBillToZip,
	NULL, -- CreditCardValidationCode,
	NULL, -- CreditCardApprovalNumber,
	0, -- Picked,
	now(), -- PickedDate,
	0, -- Printed,
	now(), -- PrintedDate,
	0, -- Shipped,
	now(), -- ShipDate,
	NULL, -- TrackingNumber,
	now(), -- BilledDate,
	0, -- Billed,
	0, -- Backordered,
	0, -- Posted,
	now(), -- PostedDate,
	NULL, -- HeaderMemo1,
	NULL, -- HeaderMemo2,
	NULL, -- HeaderMemo3,
	NULL, -- HeaderMemo4,
	NULL, -- HeaderMemo5,
	NULL, -- HeaderMemo6,
	NULL, -- HeaderMemo7,
	NULL, -- HeaderMemo8,
	NULL -- HeaderMemo9
      FROM
      PaymentsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;


-- An error occured, go to the error handler
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Cannot create the credit memo header';
         LEAVE WriteError;
      end if;



-- create the credit memo details getting all the data from the payment
      SET @SWV_Error = 0;
      INSERT INTO InvoiceDetail(CompanyID,
	DivisionID,
	DepartmentID,
	InvoiceNumber,
	ItemID,
	WarehouseID,
	SerialNumber,
	OrderQty,
	BackOrdered,
	BackOrderQty,
	ItemUOM,
	ItemWeight,
	Description,
	DiscountPerc,
	Taxable,
	ItemCost,
	ItemUnitPrice,
	Total,
	TotalWeight,
	GLSalesAccount,
	ProjectID,
	TrackingNumber,
	DetailMemo1,
	DetailMemo2,
	DetailMemo3,
	DetailMemo4,
	DetailMemo5)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_CreditMemoNumber,
	'Credit Memo', -- ItemID,
	NULL, -- WarehouseID,
	NULL, -- SerialNumber,
	1, -- OrderQty,
	NULL, -- BackOrdered,
	NULL, -- BackOrderQty,
	NULL, -- ItemUOM,
	NULL, -- ItemWeight,
	NULL, -- Description,
	NULL, -- DiscountPerc,
	NULL, -- Taxable,
	NULL, -- ItemCost,
	NULL, -- ItemUnitPrice,
	v_CreditAmount, -- Total,
	NULL, -- TotalWeight,
	v_GLAPAccount, -- GLSalesAccount,
	v_ProjectID, -- ProjectID,
	NULL, -- TrackingNumber,
	NULL, -- DetailMemo1,
	NULL, -- DetailMemo2,
	NULL, -- DetailMemo3,
	NULL, -- DetailMemo4,
	NULL -- DetailMemo5
);

-- An error occured, go to the error handler

      IF @SWV_Error <> 0 then

         SET v_CreditMemoNumber = N'';
         SET v_ErrorMessage = 'Cannot create Credit Memo Details';
         LEAVE WriteError;
      end if;
      SET @SWV_Error = 0;
      CALL CreditMemo_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber, @postingResult v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'CreditMemo_Post call failed';
         LEAVE WriteError;
      end if;


-- void the payment
      UPDATE
      PaymentsHeader
      SET
      Paid = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;


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
   END;
   IF (NOT (v_Void = 1 OR v_Posted = 0 OR v_CreditAmount <= 0)) AND 1  /*NOT SUPPORTED @@TRANCOUNT*/< 2 then
      ROLLBACK;
   ELSE
      COMMIT;
   end if;
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemo',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   IF (NOT (v_Void = 1 OR v_Posted = 0 OR v_CreditAmount <= 0)) then
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   ELSE
      SET SWP_Ret_Value = v_ReturnStatus;
      LEAVE SWL_return;
   end if;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Payment_CreateFromRMA;
//
CREATE PROCEDURE Payment_CreateFromRMA(v_CompanyID NATIONAL VARCHAR(36)
	,v_DivisionID NATIONAL VARCHAR(36)
	,v_DepartmentID NATIONAL VARCHAR(36)
	,v_PurchaseNumber NATIONAL VARCHAR(36)
	,INOUT v_NewPaymentID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*  
Name of stored procedure: Payment_CreateFromRMA  
Method:   
 Creates payment from RMA  
  
Date Created: EDE - 07/28/2015  
  
Input Parameters:  
  
 @CompanyID NVARCHAR(36)   - the ID of the company  
 @DivisionID NVARCHAR(36)  - the ID of the division  
 @DepartmentID NVARCHAR(36)  - the ID of the department  
 @PurchaseNumber NVARCHAR(36)  - the number of RMA  
  
Output Parameters:  
  
 NONE  
  
Called From:  
  
 RMAReceiving_Post  
  
Calls:  
  
 GetNextEntityID, Error_InsertError, Error_InsertErrorDetail  
  
Last Modified:   
  
Last Modified By:   
  
Revision History:   
  
*/
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_PaymentTotal DECIMAL(19,4);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DocumentDate DATETIME;
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Total,0) -IFNULL(AmountPaid,0), VendorID, IFNULL(PaymentDate,CURRENT_TIMESTAMP), IFNULL(PaymentDate,CURRENT_TIMESTAMP) INTO v_PaymentTotal,v_CustomerID,v_PaymentDate,v_DocumentDate FROM PurchaseHeader WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

-- get the payment number  
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

-- the error handler  
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromRMA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM Companies
   INNER JOIN BankAccounts ON Companies.CompanyID = BankAccounts.CompanyID
   AND Companies.DivisionID = BankAccounts.DivisionID
   AND Companies.DepartmentID = BankAccounts.DepartmentID WHERE Companies.CompanyID = v_CompanyID
   AND Companies.DivisionID = v_DivisionID
   AND Companies.DepartmentID = v_DepartmentID;

-- Insert into Payment Header getting the information from the purchase order  
   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID
	,DivisionID
	,DepartmentID
	,PaymentID
	,PaymentTypeID
	,CheckNumber
	,VendorID
	,PaymentDate
	,Amount
	,UnAppliedAmount
	,PaymentStatus
	,CurrencyID
	,CurrencyExchangeRate
	,CreditAmount
	,Posted
	,Cleared
	,GLBankAccount
	,InvoiceNumber
	,DueToDate
	,PurchaseDate)
   SELECT v_CompanyID
	,v_DivisionID
	,v_DepartmentID
	,v_PaymentID
	,'Check'
	,CheckNumber
	,VendorID
	,now()
	,v_PaymentTotal
	,0
	,'Posted'
	,CurrencyID
	,CurrencyExchangeRate
	,v_PaymentTotal
	,1
	,0
	,v_GLBankAccount
	,v_PurchaseNumber
	,PurchaseDueDate
	,PurchaseDate
   FROM PurchaseHeader
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;

-- the error handler  
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- insert into receipts detail getting data from the orer details  
   SET @SWV_Error = 0;
   INSERT INTO PaymentsDetail(CompanyID
	,DivisionID
	,DepartmentID
	,PaymentID
	,PayedID
	,DocumentNumber
	,DocumentDate
	,DiscountTaken
	,WriteOffAmount
	,AppliedAmount
	,Cleared
	,GLExpenseAccount)
   SELECT CompanyID
	,DivisionID
	,DepartmentID
	,v_PaymentID
	,v_CustomerID
	,v_PurchaseNumber
	,v_PaymentDate
	,DiscountPerc
	,0
	,Total
	,NULL
	,GLPurchaseAccount
   FROM PurchaseDetail
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;

-- the error handler  
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_NewPaymentID = v_PaymentID;

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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

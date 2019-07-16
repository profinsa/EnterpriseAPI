CREATE PROCEDURE RptCCS (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(50),
	v_DivisionIDs NATIONAL VARCHAR(2000),  
	v_StartDate NATIONAL VARCHAR(30),
	v_EndDate NATIONAL VARCHAR(30),
	INOUT v_CustomerName NATIONAL VARCHAR(50) ,
	INOUT v_CustomerAddress1 NATIONAL VARCHAR(50) ,
	INOUT v_CustomerAddress2 NATIONAL VARCHAR(50) ,
	INOUT v_CustomerAddress3 NATIONAL VARCHAR(50) ,
	INOUT v_CustomerCity NATIONAL VARCHAR(50) ,
	INOUT v_CustomerState NATIONAL VARCHAR(50) ,
	INOUT v_CustomerZip NATIONAL VARCHAR(10) ,
	INOUT v_CustomerCountry NATIONAL VARCHAR(50) ,
	INOUT v_Balance DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   select   CustomerName, CustomerAddress1, CustomerAddress2, CustomerAddress3, CustomerCity, CustomerState, CustomerZip, CustomerCountry INTO v_CustomerName,v_CustomerAddress1,v_CustomerAddress2,v_CustomerAddress3,
   v_CustomerCity,v_CustomerState,v_CustomerZip,v_CustomerCountry FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;


   IF v_DivisionIDs = 'All' then

      SET v_Balance =(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Amount,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
      N'')
      FROM ReceiptsHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1  
      AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
      AND TransactionDate between v_StartDate and v_EndDate)
      -(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Total,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
      N'')
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1   
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo')
      AND InvoiceDate between v_StartDate and v_EndDate);
   ELSE
      CALL SplitListToTable(v_DivisionIDs,',');
      CALL SplitListToTable(v_DivisionIDs,',');
      SET v_Balance =(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Amount,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
      N'')
      FROM ReceiptsHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1  
      AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
      AND DivisionID IN(SELECT * FROM tt_RtnValue) 
      AND TransactionDate between v_StartDate and v_EndDate)
      -(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Total,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
      N'')
      FROM InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1   
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo')
      AND DivisionID IN(SELECT * FROM tt_RtnValue) 
      AND InvoiceDate between v_StartDate and v_EndDate);
   end if;

   
IF v_DivisionIDs = 'All' then

      SELECT
      InvoiceNumber AS Number,
	TransactionTypeID AS Type,
	InvoiceDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	-Total AS Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,-Total*CurrencyExchangeRate,
      N'') AS BaseCurrAmount,
	DivisionID AS Division,
	DepartmentID AS Department
      FROM
      InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1  
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo')
      AND InvoiceDate between v_StartDate and v_EndDate
      UNION    

      SELECT
      ReceiptID AS Number,
	'Receipt' AS Type,
	TransactionDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Amount*CurrencyExchangeRate,
      N'') AS BaseCurrAmount,
	DivisionID AS Division,
	DepartmentID AS Department
      FROM
      ReceiptsHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1 
      AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
      AND TransactionDate between v_StartDate and v_EndDate
      ORDER BY  3;
   ELSE
      CALL SplitListToTable(v_DivisionIDs,',');
      CALL SplitListToTable(v_DivisionIDs,',');
      SELECT
      InvoiceNumber AS Number,
	TransactionTypeID AS Type,
	InvoiceDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	-Total AS Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,-Total*CurrencyExchangeRate,
      N'') AS BaseCurrAmount,
	DivisionID AS Division,
	DepartmentID AS Department
      FROM
      InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1  
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
      AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo')
      AND DivisionID IN(SELECT * FROM tt_RtnValue) 
      AND InvoiceDate between v_StartDate and v_EndDate
      UNION    

      SELECT
      ReceiptID AS Number,
	'Receipt' AS Type,
	TransactionDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Amount*CurrencyExchangeRate,
      N'') AS BaseCurrAmount,
	DivisionID AS Division,
	DepartmentID AS Department
      FROM
      ReceiptsHeader
      WHERE
      CompanyID = v_CompanyID
      AND CustomerID = v_CustomerID
      AND Posted = 1 
      AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
      AND DivisionID IN(SELECT * FROM tt_RtnValue) 
      AND TransactionDate between v_StartDate and v_EndDate
      ORDER BY  3;
   end if;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptCustomerStatement',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END
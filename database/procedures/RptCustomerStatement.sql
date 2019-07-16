CREATE PROCEDURE RptCustomerStatement (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(50),
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


   SET v_Balance =(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Amount,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
   N'')
   FROM ReceiptsHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
		)
   -(SELECT fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(Total,NULL)*IFNULL(CurrencyExchangeRate,1)),0),
   N'')
   FROM InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo'));


   SELECT
   InvoiceNumber AS Number,
	TransactionTypeID AS Type,
	InvoiceDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	-Total AS Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,-Total*CurrencyExchangeRate,
   N'') AS BaseCurrAmount
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo')
   UNION
   SELECT
   ReceiptID AS Number,
	'Receipt' AS Type,
	TransactionDate AS ValueDate,
	CurrencyID,
	CurrencyExchangeRate,
	Amount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Amount*CurrencyExchangeRate,
   N'') AS BaseCurrAmount
   FROM
   ReceiptsHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 

   ORDER BY  3;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptCustomerStatement',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END
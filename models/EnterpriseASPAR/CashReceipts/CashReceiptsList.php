<?php
/*
  Name of Page: CashReceiptsrList model

  Method: Model for gridView It provides data from database and default values, column names and categories

  Date created: 06/14/2017 Nikita Zaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by Grid controller
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 08/15/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "receiptsheader";
    public $dashboardTitle ="Customer Receipts List";
    public $breadCrumbTitle ="Customer Receipts List";
    public $idField ="CustomerID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    public $modes = ["grid"]; // list of enabled modes
    public $gridFields = [
            "ReceiptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReceiptTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Amount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
           "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Posted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
     ];

    public $editCategories = [
        "Main" => [
            "ReceiptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReceiptTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ReceiptClassID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Memorize" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "SystemDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "DueToDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "OrderDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Amount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NSF" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Cleared" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Posted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Reconciled" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Deposited" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "HeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ApprovedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "EnteredBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlTotal" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Signature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "ReceiptID" => "Receipt ID",
        "ReceiptTypeID" => "Receipt Type",
        "ReceiptClassID" => "ReceiptClassID",
        "CheckNumber" => "Check Number",
        "CustomerID" => "Customer ID",
        "Memorize" => "Memorize",
        "TransactionDate" => "Transaction Date",
        "SystemDate" => "SystemDate",
        "DueToDate" => "DueToDate",
        "OrderDate" => "OrderDate",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "CurrencyExchangeRate",
        "Amount" => "Amount",
        "UnAppliedAmount" => "UnAppliedAmount",
        "GLBankAccount" => "GLBankAccount",
        "Status" => "Status",
        "NSF" => "NSF",
        "Notes" => "Notes",
        "CreditAmount" => "CreditAmount",
        "Cleared" => "Cleared",
        "Posted" => "Posted",
        "Reconciled" => "Reconciled",
        "Deposited" => "Deposited",
        "HeaderMemo1" => "HeaderMemo1",
        "HeaderMemo2" => "HeaderMemo2",
        "HeaderMemo3" => "HeaderMemo3",
        "HeaderMemo4" => "HeaderMemo4",
        "HeaderMemo5" => "HeaderMemo5",
        "HeaderMemo6" => "HeaderMemo6",
        "HeaderMemo7" => "HeaderMemo7",
        "HeaderMemo8" => "HeaderMemo8",
        "HeaderMemo9" => "HeaderMemo9",
        "Approved" => "Approved",
        "ApprovedBy" => "ApprovedBy",
        "ApprovedDate" => "ApprovedDate",
        "EnteredBy" => "EnteredBy",
        "BatchControlNumber" => "BatchControlNumber",
        "BatchControlTotal" => "BatchControlTotal",
        "Signature" => "Signature",
        "SignaturePassword" => "SignaturePassword",
        "SupervisorSignature" => "SupervisorSignature",
        "SupervisorPassword" => "SupervisorPassword",
        "ManagerSignature" => "ManagerSignature",
        "ManagerPassword" => "ManagerPassword"
    ];

    //getting rows for grid
    public function getPage($customer){
        $user = Session::get("user");
        $query = <<<EOF
			SELECT     CashReceiptsHeader.CompanyID AS CompanyID, CashReceiptsHeader.DivisionID AS DivisionID, CashReceiptsHeader.DepartmentID AS DepartmentID,
			CashReceiptsHeader.ReceiptID AS ReceiptID, 0 AS CashType, IFNULL(CashReceiptsHeader.ReceiptTypeID, '') AS ReceiptTypeID,
			CashReceiptsHeader.ReceiptClassID AS ReceiptClassID, CashReceiptsHeader.CheckNumber AS CheckNumber, CashReceiptsHeader.CustomerID AS CustomerID,
			CashReceiptsHeader.TransactionDate AS TransactionDate, IFNULL(CashReceiptsHeader.Amount, 0) AS Amount, CashReceiptsHeader.Status AS Status,
			IFNULL(CashReceiptsHeader.CreditAmount, CashReceiptsHeader.Amount) AS CreditAmount, CashReceiptsHeader.UnAppliedAmount AS UnAppliedAmount,
			CashReceiptsHeader.Posted AS Posted, CashReceiptsHeader.CurrencyID AS CurrencyID, CashReceiptsHeader.CurrencyExchangeRate AS CurrencyExchangeRate,
			CurrencyTypes.CurrenycySymbol AS CurrenycySymbol
			FROM         ReceiptsHeader AS CashReceiptsHeader LEFT JOIN
			CurrencyTypes ON CashReceiptsHeader.CompanyID = CurrencyTypes.CompanyID AND CashReceiptsHeader.DivisionID = CurrencyTypes.DivisionID AND
			CashReceiptsHeader.DepartmentID = CurrencyTypes.DepartmentID AND CashReceiptsHeader.CurrencyID = CurrencyTypes.CurrencyID
			WHERE     (CashReceiptsHeader.CompanyID = '{$user["CompanyID"]}') AND (CashReceiptsHeader.DivisionID = '{$user["DivisionID"]}') AND (CashReceiptsHeader.DepartmentID = '{$user["DepartmentID"]}')
			AND ((CashReceiptsHeader.CustomerID = '$customer') AND (CashReceiptsHeader.Posted = 1) AND CashReceiptsHeader.ReceiptClassID != 'Vendor' AND
		(CashReceiptsHeader.CreditAmount IS NULL OR
		CashReceiptsHeader.CreditAmount != 0))
			UNION
			SELECT     CashReceiptsHeader.CompanyID AS CompanyID, CashReceiptsHeader.DivisionID AS DivisionID, CashReceiptsHeader.DepartmentID AS DepartmentID,
			CashReceiptsHeader.InvoiceNumber AS ReceiptID, 1 AS CashType, 'Credit Memo' AS ReceiptTypeID, NULL AS ReceiptClassID,
			CashReceiptsHeader.CheckNumber AS CheckNumber, CashReceiptsHeader.CustomerID AS CustomerID, CashReceiptsHeader.InvoiceDate AS TransactionDate,
			IFNULL(CashReceiptsHeader.Total, 0) AS Amount, NULL AS Status, (IFNULL(CashReceiptsHeader.Total, 0) - IFNULL(CashReceiptsHeader.AmountPaid, 0)) AS CreditAmount,
			CashReceiptsHeader.UndistributedAmount AS UnAppliedAmount, CashReceiptsHeader.Posted AS Posted, CashReceiptsHeader.CurrencyID AS CurrencyID,
			CashReceiptsHeader.CurrencyExchangeRate AS CurrencyExchangeRate, CurrencyTypes.CurrenycySymbol AS CurrenycySymbol
			FROM         InvoiceHeader AS CashReceiptsHeader LEFT JOIN
			CurrencyTypes ON CashReceiptsHeader.CompanyID = CurrencyTypes.CompanyID AND CashReceiptsHeader.DivisionID = CurrencyTypes.DivisionID AND
			CashReceiptsHeader.DepartmentID = CurrencyTypes.DepartmentID AND CashReceiptsHeader.CurrencyID = CurrencyTypes.CurrencyID
			WHERE     ((CashReceiptsHeader.CompanyID = '{$user["CompanyID"]}') AND (CashReceiptsHeader.DivisionID = '{$user["DivisionID"]}') AND (CashReceiptsHeader.DepartmentID = '{$user["DepartmentID"]}') AND
			(CashReceiptsHeader.CustomerID = '$customer') AND CashReceiptsHeader.TransactionTypeID = 'Credit Memo' AND CashReceiptsHeader.Posted = 1 AND
			(IFNULL(CashReceiptsHeader.Total, 0) - IFNULL(CashReceiptsHeader.AmountPaid, 0)) > 0.005 AND IFNULL(CashReceiptsHeader.Total, 0) >= 0.005)
EOF;
        
        $result = DB::select($query, array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
}
?>

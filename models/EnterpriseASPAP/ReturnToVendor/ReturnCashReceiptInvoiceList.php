<?php
/*
  Name of Page: Cash Receipt Invoice List model
   
  Method: It provides data from database and default values, column names and categories
   
  Date created: 10/07/2019 Nikita Zaharov
   
  Use: this model used by views for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers
  used as model by views
   
  Calls:
  MySql Database
   
  Last Modified: 11/07/2019
  Last Modified by: Zaharov Nikita
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "invoiceheader";
    public $dashboardTitle ="Return Cash Receipt Invoices List";
    public $breadCrumbTitle ="Return Cash Receipt Invoices List 	 ";
    public $idField ="InvoiceNumber";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","InvoiceNumber"];
    public $modes = ["grid"]; // list of enabled modes
    public $features = ["selecting"];
    public $gridFields = [
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "TransactionTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "InvoiceDate" => [
            "dbType" => "timestamp",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
        "UndistributedAmount" => [
            "dbType" => "decimal(19,4)",
            "formatFunction" => "currencyFormat",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Total" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "formatFunction" => "currencyFormat",
            "defaultValue" => ""
        ],
        "BalanceDue" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "formatFunction" => "currencyFormat",
            "defaultValue" => ""
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AmountToApply" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "formatFunction" => "currencyFormat",
            "defaultValue" => "",
            "editable" => true
        ]
    ];
    public $editCategories = [
        "Main" => [
            "InvoiceNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "InvoiceDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "UndistributedAmount" => [
                "dbType" => "decimal(19,4)",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Total" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "BalanceDue" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AmountToApply" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "InvoiceNumber" => "Invoice Number",
        "TransactionTypeID" => "Transaction Type ID",
        "InvoiceDate" => "Invoice Date",
        "UndistributedAmount" => "Undistributed Amount",
        "Total" => "Total",
        "BalanceDue" => "BalanceDue",
        "CurrencyID" => "Currency ID",
        "AmountToApply" => "Amount To Apply"
    ];
    
    //getting rows for grid
    public function getPage($CustomerID){
        $user = Session::get("user");
        $CompanyID = "'{$user["CompanyID"]}'";
        $DivisionID = "'{$user["DivisionID"]}'";
        $DepartmentID = "'{$user["DepartmentID"]}'";
        $query = <<<EOF
			SELECT     ReturnCashReceiptInvoice.CompanyID AS CompanyID, ReturnCashReceiptInvoice.DivisionID AS DivisionID, ReturnCashReceiptInvoice.DepartmentID AS DepartmentID,
			ReturnCashReceiptInvoice.InvoiceNumber AS InvoiceNumber, ReturnCashReceiptInvoice.TransactionTypeID AS TransactionTypeID,
			ReturnCashReceiptInvoice.InvoiceDate AS InvoiceDate, ReturnCashReceiptInvoice.UndistributedAmount AS UndistributedAmount, ReturnCashReceiptInvoice.Total AS Total,
			ReturnCashReceiptInvoice.BalanceDue AS BalanceDue, ReturnCashReceiptInvoice.CurrencyID AS CurrencyID, ReturnCashReceiptInvoice.AmountPaid AS AmountPaid,
			ReturnCashReceiptInvoice.CustomerID AS CustomerID, (IFNULL(ReturnCashReceiptInvoice.Total, 0) - IFNULL(ReturnCashReceiptInvoice.AmountPaid, 0))
			AS AvailableAmount,
			0 AS AmountToApply
			FROM InvoiceHeader AS ReturnCashReceiptInvoice
			WHERE     ((ReturnCashReceiptInvoice.CompanyID = $CompanyID) AND (ReturnCashReceiptInvoice.DivisionID = $DivisionID) AND
			(ReturnCashReceiptInvoice.DepartmentID = $DepartmentID) AND (ReturnCashReceiptInvoice.CustomerID = '$CustomerID') AND (ReturnCashReceiptInvoice.Posted = 1) AND
			((IFNULL(ReturnCashReceiptInvoice.Total, 0) - IFNULL(ReturnCashReceiptInvoice.AmountPaid, 0)) > 0.005) AND IFNULL(ReturnCashReceiptInvoice.TransactionTypeID, N'')
			<> 'Credit Memo')
			UNION
			SELECT     ReturnCashReceiptInvoice.CompanyID AS CompanyID, ReturnCashReceiptInvoice.DivisionID AS DivisionID, ReturnCashReceiptInvoice.DepartmentID AS DepartmentID,
			ReturnCashReceiptInvoice.PurchaseNumber AS InvoiceNumber, ReturnCashReceiptInvoice.TransactionTypeID AS TransactionTypeID,
			ReturnCashReceiptInvoice.PurchaseDate AS InvoiceDate, ReturnCashReceiptInvoice.UndistributedAmount AS UndistributedAmount, ReturnCashReceiptInvoice.Total AS Total,
			ReturnCashReceiptInvoice.BalanceDue AS BalanceDue, ReturnCashReceiptInvoice.CurrencyID AS CurrencyID, ReturnCashReceiptInvoice.AmountPaid AS AmountPaid,
			ReturnCashReceiptInvoice.VendorID AS CustomerID, (IFNULL(ReturnCashReceiptInvoice.Total, 0) - IFNULL(ReturnCashReceiptInvoice.AmountPaid, 0)) AS AvailableAmount,
			0 AS AmountToApply
			FROM         PurchaseHeader AS ReturnCashReceiptInvoice
			WHERE     ((ReturnCashReceiptInvoice.CompanyID = $CompanyID) AND (ReturnCashReceiptInvoice.DivisionID = $DivisionID) AND
			(ReturnCashReceiptInvoice.DepartmentID = $DepartmentID) AND (ReturnCashReceiptInvoice.VendorID = '$CustomerID') AND (ReturnCashReceiptInvoice.Posted = 1) AND
			((IFNULL(ReturnCashReceiptInvoice.Total, 0) - IFNULL(ReturnCashReceiptInvoice.AmountPaid, 0)) > 0.005) AND ReturnCashReceiptInvoice.TransactionTypeID = 'Debit Memo')
EOF;
        
        $result = DB::select($query, array());
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function Receipt_Cash(){
        $user = Session::get("user");
        $postData = file_get_contents("php://input");
        
        // `application/x-www-form-urlencoded`  `multipart/form-data`
        $data = parse_str($postData);
        // or
        // `application/json`
        $data = json_decode($postData, true);
        $success = true;
        //        print_r($data);
        foreach($data as $row){
            //           print_r($row);
            DB::statement("CALL ReturnReceipt_Cash(?, ?, ?, ?, ?, 'Receipt', 'Return Invoice', ?, @Result, @SWP_RET_VALUE)", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["InvoiceNumber"], $row["ReceiptID"], $row["AmountToApply"]));
        
            $result = DB::select('select @Result as Result, @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == 0){
                $success = false;
                echo $result[0]->SWP_RET_VALUE;
            }
        }
        
        echo "ok";
    }
}
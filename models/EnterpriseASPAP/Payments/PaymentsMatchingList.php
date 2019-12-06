<?php
/*
  Name of Page: Payments Matching

  Method: Model for gridView It provides data from database and default values, column names and categories

  Date created: 06/08/2017 Nikita Zaharov

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
  created and used for ajax requests by Grid controll
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 05/12/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "paymentsheader";
    public $dashboardTitle ="Voucher Three Matching";
    public $breadCrumbTitle ="Voucher Three Matching";
    //public $idField ="TransitID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $modes = ["grid"];
    public $fageGridColumns = true;
    public $gridFields = [
        "a1" =>[
        ],
        "PurchaseNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "VendorID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "Total" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "a2" =>[
        ],
        "RecivingNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CurrencyID1" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "AmountPaid" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "a3" =>[
        ],
        "PaymentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        /*        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
            ],*/
        "CurrencyID2" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "Amount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ]
    ];

    public $editCategories = [
        "PurchaseNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "VendorID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "Total" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "RecivingNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AmountPaid" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "PaymentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "InvoiceNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "Amount" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ]
    ];
    
    public $columnNames = [
        "PurchaseNumber" => "Purchase Number",
        "CurrencyID" => "Currency ID",
        "CurrencyID1" => "Currency ID",
        "CurrencyID2" => "Currency ID",
        "VendorID" => "Vendor ID",
        "Total" => "Purchase Total",
        "RecivingNumber" => "Receiving Number",
        "AmountPaid" => "Receiving Amount",
        "PaymentID" => "Payment ID",
        "InvoiceNumber" => "Purchase Order Number",
        "Amount" => "Amount",
        "a1" => "",
        "a2" => "",
        "a3" => ""
    ];

        //getting rows for grid
    public function getPage($number){
        $user = Session::get("user");

        $query = <<<EOF
SELECT DISTINCT
    PurchaseHeader.CompanyID,
	PurchaseHeader.DivisionID,
	PurchaseHeader.DepartmentID,
	PurchaseHeader.PurchaseNumber,
	PurchaseHeader.CurrencyID,
	PurchaseHeader.VendorID,
	PurchaseHeader.Total,
	PurchaseHeader.RecivingNumber,
	PurchaseHeader.AmountPaid,
	PaymentsHeader.PaymentID,
	PaymentsHeader.InvoiceNumber,
	PaymentsHeader.Amount
	FROM
	PaymentsHeader INNER JOIN PurchaseHeader
	ON PaymentsHeader.CompanyID = PurchaseHeader.CompanyID
	AND PaymentsHeader.DivisionID = PurchaseHeader.DivisionID
	AND	PaymentsHeader.DepartmentID = PurchaseHeader.DepartmentID
	AND PaymentsHeader.InvoiceNumber = PurchaseHeader.PurchaseNumber
	WHERE
	PaymentsHeader.CompanyID = '{$user["CompanyID"]}'
	AND PaymentsHeader.DivisionID = '{$user["DivisionID"]}'
	AND	PaymentsHeader.DepartmentID = '{$user["DepartmentID"]}'
	AND PurchaseHeader.PurchaseNumber != 'DEFAULT'
	ORDER BY PurchaseHeader.VendorID
EOF;
        $result = DB::select($query, array());

        $result = json_decode(json_encode($result), true);

        return $result;
    }
}
?>

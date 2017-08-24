<?php
/*
  Name of Page: Payments History Detail model

  Method: Model for Payments History Detail form. It provides data from database and default values, column names and categories

  Date created: 05/25/2017 Zaharov Nikita

  Use: this model used by views/gridView for
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by grid controllers
  used as model by views

  Calls:
  MySql Database

  Last Modified: 06/15/2017
  Last Modified by: Zaharov Nikita
*/

namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

use Illuminate\Support\Facades\DB;
use Session;

class gridData extends gridDataSource{
	protected $tableName = "paymentsdetailhistory";

	public $dashboardTitle ="Payments History Detail";
	public $breadCrumbTitle ="Payments History Detail";
	public $idField ="PaymentID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID", "PaymentDetailID"];
	public $gridFields = [
		"PayedID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"DocumentNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
        "DocumentDate" => [
            "dbType" => "datetime",
            "inputType" => "datetime",
            "defaultValue" => "now"
        ],
		"GLExpenseAccount" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
        "AppliedAmount" =>	[
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
		"ProjectID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		]
	];

	public $editCategories = [
		"Main" => [
            "PaymentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledNew" => "true",
                "disabledEdit" => "true"
            ],
            "PaymentDetailID" => [
                "dbType" => "bigint(20)",
                "inputType" => "text",
                "disabledNew" => "true",
                "disabledEdit" => "true",
                "autogenerated" => true
            ],
            "PayedID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dialogChooser",
                "dataProvider" => "getVendors"
            ],
            "DocumentNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text"
            ],
            "DocumentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "AppliedAmount" =>	[
                "dbType" => "decimal(19,4)",
                "formatFunction" => "currencyFormat",
                "inputType" => "text"
            ],
            "GLExpenseAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts"
            ],
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getProjects"
            ]
        ]
    ];

    public $columnNames = [
        "Attention" => "Attention",
		"PayedID" => "Sub Vendor",
        "DocumentNumber" => "Doc #",
        "DocumentDate" => "Doc Date",
		"GLExpenseAccount" => "Account",
        "AppliedAmount" =>	"Amount",
		"ProjectID" => "Project ID",
        "PaymentID" => "Payment ID",
        "PaymentDetailID" => "Payment Detail ID",
        "DiscountTaken" =>	"Discount Taken",
        "WriteOffAmount" =>	"Write Off Amount",
        "AppliedAmount" =>	"Applied Amount",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "Cleared" => "Cleader",
        "GLExpenseAccount" => "Expense Accounse"
    ];
}
?>
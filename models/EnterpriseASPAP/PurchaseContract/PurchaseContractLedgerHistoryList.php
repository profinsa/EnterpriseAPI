<?php
/*
  Name of Page: PurchaseContractLedgerHistoryList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractLedgerHistoryList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/PurchaseContractLedgerHistoryList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractLedgerHistoryList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\PurchaseContract\PurchaseContractLedgerHistoryList.php
   
  Calls:
  MySql Database
   
  Last Modified: 12/11/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "purchasecontractledgerhistory";
    public $dashboardTitle ="View Purchase Contract Ledger History";
    public $breadCrumbTitle ="View Purchase Contract Ledger History";
    public $idField ="";
    public $idFields = ;
    public $gridFields = [
        "PurchaseOrderLineNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "NumberUsed" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ],
        "DateUsed" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "PurchaseContractNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PurchaseOrderNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "PurchaseOrderLineNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NumberUsed" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DateUsed" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ]
        ]
    ];
    
    public $columnNames = [
        "PurchaseOrderLineNumber" => "PO Line Number",
        "NumberUsed" => "Number Used",
        "DateUsed" => "Date Used",
        "PurchaseContractNumber" => "Purchase Contract Number",
        "PurchaseOrderNumber" => "Purchase Order Number"
    ];
}
?>

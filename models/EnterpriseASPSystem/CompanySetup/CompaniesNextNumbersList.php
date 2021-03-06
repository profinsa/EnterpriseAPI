<?php
/*
  Name of Page: CompaniesNextNumbersList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/CompaniesNextNumbersList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesNextNumbersList.php
   
  Calls:
  MySql Database
   
  Last Modified: 16/04/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class CompaniesNextNumbersList extends gridDataSource{
    public $tableName = "companiesnextnumbers";
    public $dashboardTitle ="CompaniesNextNumbers";
    public $breadCrumbTitle ="CompaniesNextNumbers";
    public $idField ="NextNumberName";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","NextNumberName"];
    public $gridFields = [
            "NextNumberValue" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
    ];

    public $editCategories = [
        "Main" => [
            "NextNumberName" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "NextNumberValue" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "NextNumberName" => "Next Number Name",
        "CurrentValue" => "Current Number",
        "NextNumberValue" => "Next Number",
        "Description" => "Description"
    ];

    public function getPage($number){
        $numberNameToDescription = [
            "NextAdjustmentNumber" => "Adjustment",
            "NextBankTransactionNumber" => "Bank Transaction",
            "NextContractNumber" => "Contract",
            "NextCreditMemoNumber" => "Credit Memo",
            "NextDebitMemoNumber" => "Debit Memo",
            "NextEDIException" => "EDI Exception",
            "NextGLTransNumber" => "GL Transaction",
            "NextInventoryAdjustmentNumber" => "Inventory Adjustment",
            "NextInvoiceNumber" => "Invoice",
            "NextOrderNumber" => "Order",
            "NextOtherNumber" => "Other",
            "NextOtherNumberA" => "Other A",
            "NextOtherNumberB" => "Other B",
            "NextOtherNumberC" => "Other C",
            "NextPayrollCheckNumber" => "Payroll Check",
            "NextPayrollNumber" => "Payroll",
            "NextPurchaseOrderNumber" => "Purchase Order",
            "NextQuoteNumber" => "Quote",
            "NextReceiptNumber" => "Receipt",
            "NextReconNumber" => "Reconciliation",
            "NextRMANumber" => "RMA",
            "NextUPCNumber" => "UPC",
            "NextVoucherNumber" => "Payment",
            "NextWorkOrderNumber" => "Work Order"
        ];
        $result = parent::getPage($number);
        foreach($result as &$record){
            $record["CurrentValue"] = $record["NextNumberValue"] - 1;
            $record["Description"] = key_exists($record["NextNumberName"], $numberNameToDescription) ? $numberNameToDescription[$record["NextNumberName"]] : $record["NextNumberName"];
        }
        $this->gridFields = [
            "Description" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrentValue" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NextNumberValue" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ];
        
        return $result;
    }
}
?>

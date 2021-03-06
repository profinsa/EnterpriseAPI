<?php
/*
  Name of Page: InvetoryAdjustmentsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php It provides data from database and default values, column names and categories
   
  Date created: 16/02/2019 Nikita Zaharov
   
  Use: this model used by views/InvetoryAdjustmentsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\InventoryAdjustments\InvetoryAdjustmentsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 28/03/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class InventoryAdjustmentsList extends gridDataSource{
    public $tableName = "inventoryadjustments";
    public $dashboardTitle ="Inventory Adjustments";
    public $breadCrumbTitle ="Inventory Adjustments";
    public $idField ="AdjustmentID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AdjustmentID"];
    public $gridFields = [
        "AdjustmentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AdjustmentTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AdjustmentDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "AdjustmentReason" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "AdjustmentPosted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AdjustmentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "disabledNew" => true,
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "AdjustmentTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getInventoryAdjustmentTypes",
                "defaultValue" => ""
            ],
            "AdjustmentDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "AdjustmentReason" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdjustmentNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AdjustmentPosted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "AdjustmentPostToGL" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            /*            "BatchControlNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BatchControlTotal" => [
                "dbType" => "decimal(19,4)",
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
            ],
            "Total" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
                ]*/
        ]
    ];
    
    public $detailPagesAsSubgrid = true;
    public $detailPages = [
        "Main" => [
            //            "hideFields" => "true",
            //"disableNew" => "true",
            //"deleteDisabled" => "true",
            //"editDisabled" => "true",
            "viewPath" => "Inventory/InventoryAdjustments/InventoryAdjustmentsDetail",
            "newKeyField" => "AdjustmentID",
            "keyFields" => ["AdjustmentID", "AdjustmentLineID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","AdjustmentID"],
            "gridFields" => [
            ]
        ]
    ];

    public function Recalc() {}

    public function Post(){
        $user = Session::get("user");

        DB::statement("CALL InventoryAdjustments_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["AdjustmentID"] . "', @success, @PostingResult,@SWP_RET_VALUE)");

        $result = DB::select('select @PostingResult as PostingResult, @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE == -1) {
            http_response_code(400);
            echo $result[0]->PostingResult;
        } else {
            echo "ok";
        }
    }

    public $columnNames = [
        "AdjustmentID" => "Adjustment ID",
        "AdjustmentTypeID" => "Adjustment Type ID",
        "AdjustmentDate" => "Adjustment Date",
        "AdjustmentReason" => "Adjustment Reason",
        "AdjustmentPosted" => "Adjustment Posted",
        "SystemDate" => "System Date",
        "AdjustmentNotes" => "Adjustment Notes",
        "AdjustmentPostToGL" => "Adjustment Post To GL",
        "BatchControlNumber" => "Batch Control Number",
        "BatchControlTotal" => "Batch Control Total",
        "Approved" => "Approved",
        "ApprovedBy" => "Approved By",
        "ApprovedDate" => "Approved Date",
        "EnteredBy" => "Entered By",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "Total" => "Total",
        "AdjustmentLineID" => "Adjustment Line ID",
        "ItemID" => "Item ID",
        "WarehouseID" => "Warehouse ID",
        "WarehouseBinID" => "Bin ID",
        "AdjustmentDescription" => "Adjustment Description",
        "OriginalQuantity" => "Original Qty",
        "AdjustedQuantity" => "Adjusted Qty",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "Cost" => "Cost",
        "GLAdjustmentPostingAccount" => "GL Adjustment Posting Account",
        "ProjectID" => "Project ID",
        "GLControlNumber" => "GL Control Number"
    ];
}
?>

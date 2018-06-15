<?php
/*
  Name of Page: ProjectsList model
   
  Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/ProjectsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectsList.php
  used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAR\Projects\ProjectsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 08/14/2017
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
require "./models/helpers/recalc.php";

class gridData extends gridDataSource{
    public $tableName = "projects";
    public $dashboardTitle ="Projects";
    public $breadCrumbTitle ="Projects";
    public $idField ="ProjectID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectID"];
    public $gridFields = [
        "ProjectID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ProjectName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "ProjectTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "EmployeeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ProjectStartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "ProjectOpen" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true"
            ],
            "ProjectName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getProjectTypes",
                "defaultValue" => ""
            ],
            "ProjectStartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ProjectCompleteDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectEstRevenue" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectActualRevenue" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectEstCost" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectActualCost" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "ProjectNotes" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLSalesAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "ProjectOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ],
        "Project Transactions" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ],
        "Project Transactions History" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text"
            ]
        ]
    ];
    
    public $columnNames = [
        "ProjectID" => "Project ID",
        "ProjectName" => "Project Name",
        "ProjectTypeID" => "Project Type",
        "CustomerID" => "Customer ID",
        "EmployeeID" => "Employee ID",
        "ProjectStartDate" => "Start Date",
        "ProjectOpen" => "Open",
        "ProjectDescription" => "Project Description",
        "ProjectCompleteDate" => "Project Complete Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "ProjectEstRevenue" => "Project Est Revenue",
        "ProjectActualRevenue" => "Project Actual Revenue",
        "ProjectEstCost" => "Project Est Cost",
        "ProjectActualCost" => "Project Actual Cost",
        "ProjectNotes" => "Project Notes",
        "GLSalesAccount" => "GL Sales Account",
        "Memorize" => "Memorize",
        "TransactionType" => "Transaction Type",
		"TransactionNumber" => "Transaction Number",
		"TransactionDate" => "Transaction Date",
		"TransactionAmount" => "Transaction Amount",
        "CurrencyID" => "Currency ID",
		"ShipDate" => "Ship Date",
		"TrackingNumber" => "Tracking Number"
    ];
    
    public $detailPages = [
        "Project Transactions" => [
            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            "editDisabled" => "true",
            "viewPath" => "AccountsReceivable/OrderProcessing/OrderTrackingDetail",
            "newKeyField" => "CustomerID",
            "keyFields" => ["CustomerID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","CustomerID"],
            "gridFields" => [
                "TransactionType" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionDate" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime"
                ],
                "TransactionAmount" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "CurrencyID" =>	[
                    "dbType" => "varchar(3)",
                    "inputType" => "dropdown",
                ],
                "CustomerID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ]
            ]
        ],
        "Project Transactions History" => [
            "hideFields" => "true",
            "disableNew" => "true",
            "deleteDisabled" => "true",
            "editDisabled" => "true",
            "viewPath" => "AccountsReceivable/ProjectsJobs/ViewProjects",
            "newKeyField" => "CustomerID",
            "keyFields" => ["CustomerID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","CustomerID"],
            "gridFields" => [
                "TransactionType" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionNumber" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text"
                ],
                "TransactionDate" => [
                    "dbType" => "datetime",
                    "inputType" => "datetime"
                ],
                "TransactionAmount" => [
                    "dbType" => "decimal(19,4)",
                    "format" => "{0:n}",
                    "inputType" => "text"
                ],
                "CurrencyID" =>	[
                    "dbType" => "varchar(3)",
                    "inputType" => "dropdown",
                ],
                "CustomerID" => [
                    "dbType" => "varchar(50)",
                    "inputType" => "text"
                ]
            ]
        ]
    ];

    //getting rows for grid
    public function getTransactionsWithType($CustomerID, $type){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Project Transactions"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Project Transactions"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND CustomerID='" . $CustomerID . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from " . ($type == "history" ? "projecthistorytransactions " : "projecttransactions ") . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
        
    public function getProjectTransactions($CustomerID){
        return $this->getTransactionsWithType($CustomerID, "normal");
    }
    
    public function getProjectTransactionsHistory($CustomerID){
        return $this->getTransactionsWithType($CustomerID, "history");
    }

    public function recalc() {
        $user = Session::get("user");

        $recalc = new recalcHelper;

        if ($recalc->lookForProcedure("Project_ReCalc2")) {
            DB::statement("CALL Project_ReCalc2('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["ProjectID"] . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');

            if($result[0]->SWP_RET_VALUE == -1) {
                echo "error";
                return response("failed", 400)->header('Content-Type', 'text/plain');
            } else {
                echo "ok";
                header('Content-Type: application/json');
            }
        } else {
            return response("Procedure not found", 400)->header('Content-Type', 'text/plain');
        }
    }
}
?>

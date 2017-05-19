<?php

/*
Name of Page: ProjectsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Projects\ProjectsList.php It provides data from database and default values, column names and categories
 
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
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Projects\ProjectsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAR\Projects\ProjectsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    protected $tableName = "projects";
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
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ProjectID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
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
                "inputType" => "text",
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
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectEstRevenue" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectActualRevenue" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectEstCost" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectActualCost" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectNotes" => [
                "dbType" => "varchar(250)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLSalesAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ProjectOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Memorize" => [
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
    
    public $transactionsIdFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
	public $transactionsFields = [
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
	];
    
    //getting rows for grid
    public function getTransactions($CustomerID, $type){
        $user = $_SESSION["user"];
        $keyFields = "";
        $fields = [];
        foreach($this->transactionsFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->transactionsIdFields as $key){
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

        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $fields) . " from " . ($type == "history" ? "projecthistorytransactions " : "projecttransactions ") . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        

        return $result;
    }
}
?>

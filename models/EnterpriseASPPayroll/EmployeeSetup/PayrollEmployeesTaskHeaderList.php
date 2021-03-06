<?php
/*
  Name of Page: PayrollEmployeesTaskHeaderList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskHeaderList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/PayrollEmployeesTaskHeaderList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskHeaderList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesTaskHeaderList.php
   
  Calls:
  MySql Database
   
  Last Modified: 12/06/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class PayrollEmployeesTaskHeaderList extends gridDataSource{
    public $tableName = "payrollemployeestaskheader";
    public $dashboardTitle ="Employees Tasks";
    public $breadCrumbTitle ="Employees Tasks";
    public $idField ="EmployeeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","EmployeeTaskID"];
    public $gridFields = [
        "TaskTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "StartDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "DueDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "CompletedDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "PriorityID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "LeadID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "CustomerID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "VendorID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EmployeeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "EmployeeTaskID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => true,
                "defaultValue" => ""
            ],
            "TaskTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployeesTaskTypes",
                "defaultValue" => ""
            ],
            "StartDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "DueDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "Completed" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CompletedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "PriorityID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RelatedDocumentType" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "RelatedDocumentNumber" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LeadID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getLeadIds",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Description" => [
                "dbType" => "varchar(200)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DelegatedTo" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DelegatedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ]
        ]
    ];
    
    public $columnNames = [
        "TaskTypeID" => "Task Type ID",
        "StartDate" => "Start Date",
        "DueDate" => "Due Date",
        "CompletedDate" => "Completed Date",
        "PriorityID" => "Priority ID",
        "LeadID" => "Lead ID",
        "CustomerID" => "Customer ID",
        "VendorID" => "Vendor ID",
        "EmployeeID" => "Employee ID",
        "EmployeeTaskID" => "Employee Task ID",
        "Completed" => "Completed",
        "RelatedDocumentType" => "Related Document Type",
        "RelatedDocumentNumber" => "Related Document Number",
        "Description" => "Description",
        "DelegatedTo" => "Delegated To",
        "DelegatedDate" => "Delegated Date"
    ];

    public function getPage($page){
        $user = Session::get("user");
        
        $result = parent::getPage($page);;
        if(key_exists("from", $_GET)){
            $ret = [];
            foreach($result as $key=>$value)
                if(strtotime($value["StartDate"]) <= strtotime($_GET["from"]) &&
                   strtotime($value["DueDate"]) >= strtotime($_GET["from"]))
                    $ret[] = $value;
            $result = $ret;
            //echo strtotime($_GET["from"]);
        }
        return $result;
    }
}
?>

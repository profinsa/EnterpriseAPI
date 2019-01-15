<?php

/*
Name of Page: PayrollPayEmployeesList model
 
Method: Model for EnterpriseX\models\EnterpriseASPPayroll\PayrollProcessing\PayrollPayEmployeesList.php It provides data from database and default values, column names and categories
 
Date created: 16/01/2019  
 
Use: this model used by views/PayrollRegisterList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
 
Calls:
MySql Database
 
Last Modified: 16/01/2019
Last Modified by: 
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "payrollemployees";
public $dashboardTitle ="Pay Employees";
public $breadCrumbTitle ="Pay Employees";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $gridFields = [
    "EmployeeID" => [
        "dbType" => "varchar(36)",
        "inputType" => "text"
    ],
    "EmployeeName" => [
        "dbType" => "varchar(50)",
        "inputType" => "text"
    ],
    // "PayType" => [
    //     "dbType" => "varchar(50)",
    //     "inputType" => "text",
    // ],
    // "PayFrequency" => [
    //     "dbType" => "varchar(50)",
    //     "inputType" => "text"
    // ],
    // "LastHours" => [
    //     "dbType" => "double",
    //     "inputType" => "text"
    // ]
];

public $editCategories = [
    "Main" => [
        "EmployeeID" => [
        "dbType" => "varchar(36)",
        "inputType" => "text",
        "defaultValue" => ""
        ],
        "EmployeeName" => [
        "dbType" => "varchar(50)",
        "inputType" => "text",
        "defaultValue" => ""
        ],
        "loadFrom" => [
            "method" => "getPayrollEmployeesDetails",
            "key" => "EmployeeID"
        ],
        "PayType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "PayFrequency" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "LastHours"  => [
            "dbType" => "double",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ]
];


public $columnNames = [
"EmployeeID" => "Employee ID",
"EmployeeName" => "Employee Name",
"PayType" => "Employee Pay Type",
"PayFrequency" => "Employee Pay Frequency",
"LastHours"  => "Last Hours",
];

    public function getPayrollEmployeesDetails($id){
    $user = Session::get("user");
    $payrollEmployeesDetailsResult = DB::select("SELECT EmployeeID, PayType, PayFrequency, LastHours from payrollemployeesdetail WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $id));
    if(count($payrollEmployeesDetailsResult))
        return json_decode(json_encode($payrollEmployeesDetailsResult), true)[0];
    else
        return [
            "EmployeeID" => $id,
            "PayType" => "",
            "PayFrequency" => "",
            "LastHours" => ""
            ];
    }
}
?>

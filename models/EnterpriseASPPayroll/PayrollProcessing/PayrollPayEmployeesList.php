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
public $modes = ["view", "edit", "grid"];
public $gridFields = [
    "EmployeeID" => [
        "dbType" => "varchar(36)",
        "inputType" => "text"
    ],
    "EmployeeName" => [
        "dbType" => "varchar(50)",
        "inputType" => "text"
    ],
    "PayType" => [
        "dbType" => "varchar(50)",
        "inputType" => "text",
    ],
    "PayFrequency" => [
        "dbType" => "varchar(50)",
        "inputType" => "text"
    ],
    "LastHours" => [
        "dbType" => "double",
        "inputType" => "text"
    ]
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
        "EmployeeAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeCounty" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EmployeeCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
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
        "Salary" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "HourlyRate" => [
            "dbType" => "decimal(19,4)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CommissionCalc" => [
            "dbType" => "int(11)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "ComissionPerc" => [
            "dbType" => "float",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "OvertimeRate" => [
            "dbType" => "decimal(19,4)",
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
"EmployeeAddress1" => "Employee Address 1",
"EmployeeAddress2" => "Employee Address 2",
"EmployeeCity" => "Employee City",
"EmployeeState" => "Employee State",
"EmployeeZip" => "Employee Zip",
"EmployeeCountry" => "Employee Country",
"PayType" => "Employee Pay Type",
"PayFrequency" => "Employee Pay Frequency",
"HourlyRate" => "Hourly Rate",
"CommissionCalc"  => "Commission Calc (0: for sales, 1: for profit)",
"ComissionPerc"  => "Comission Perc",
"OvertimeRate"  => "Overtime Rate",
"LastHours"  => "Last Hours",
];

    public function getPage($employees){
        $user = Session::get("user");
        $query = <<<EOF
            SELECT 
            PayrollPayEmployees.CompanyID AS CompanyID,
            PayrollPayEmployees.DivisionID AS DivisionID,
            PayrollPayEmployees.DepartmentID AS DepartmentID,
            PayrollPayEmployees.EmployeeID AS EmployeeID,
            PayrollPayEmployees.EmployeeName AS EmployeeName,
            PayrollPayEmployees.EmployeeAddress1 AS EmployeeAddress1,
            PayrollPayEmployees.EmployeeAddress2 AS EmployeeAddress2,
            PayrollPayEmployees.EmployeeCity AS EmployeeCity,
            PayrollPayEmployees.EmployeeCounty AS EmployeeCounty,
            PayrollPayEmployees.EmployeeState AS EmployeeState,
            PayrollPayEmployees.EmployeeZip AS EmployeeZip,
            PayrollPayEmployees.EmployeeCountry AS EmployeeCountry,
            PayrollEmployeesDetail.PayType AS PayType,
            PayrollEmployeesDetail.PayFrequency AS PayFrequency,
            PayrollEmployeesDetail.Salary AS Salary,
            PayrollEmployeesDetail.HourlyRate AS HourlyRate,
            PayrollEmployeesDetail.CommissionCalc AS CommissionCalc,
            PayrollEmployeesDetail.ComissionPerc AS ComissionPerc,
            PayrollEmployeesDetail.OvertimeRate AS OvertimeRate,
            PayrollEmployeesDetail.LastHours AS LastHours
            FROM
            PayrollEmployees AS PayrollPayEmployees
            INNER JOIN PayrollEmployeesDetail ON
            PayrollPayEmployees.CompanyID = PayrollEmployeesDetail.CompanyID
            AND PayrollPayEmployees.DivisionID = PayrollEmployeesDetail.DivisionID
            AND PayrollPayEmployees.DepartmentID = PayrollEmployeesDetail.DepartmentID
            AND PayrollPayEmployees.EmployeeID = PayrollEmployeesDetail.EmployeeID
            WHERE
            (PayrollPayEmployees.CompanyID = '{$user["CompanyID"]}'
            AND PayrollPayEmployees.DivisionID = '{$user["DivisionID"]}'
            AND PayrollPayEmployees.DepartmentID = '{$user["DepartmentID"]}')
EOF;
        
        $result = DB::select($query, array());
        $result = json_decode(json_encode($result), true);
        return $result;
    }
}
?>

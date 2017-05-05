<?php

/*
Name of Page: PayrollEmployeesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollEmployeesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\EmployeeSetup\PayrollEmployeesList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
	protected $tableName = "payrollemployees";
	public $dashboardTitle ="Employees";
	public $breadCrumbTitle ="Employees";
	public $idField ="EmployeeID";
	public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
	public $gridFields = [
		"EmployeeID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"EmployeeTypeID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"EmployeeName" => [
			"dbType" => "varchar(50)",
			"inputType" => "text"
		],
		"ActiveYN" => [
			"dbType" => "tinyint(1)",
			"inputType" => "text"
		],
		"EmployeeUserName" => [
			"dbType" => "varchar(15)",
			"inputType" => "text"
		],
		"HireDate" => [
			"dbType" => "datetime",
			"format" => "{0:d}",
			"inputType" => "datetime"
		]
	];

	public $editCategories = [
		"Main" => [
			"EmployeeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeTypeID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeUserName" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeePassword" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeePasswordOld" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeePasswordDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"EmployeePasswordExpires" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"EmployeePasswordExpiresDate" => [
				"dbType" => "int(11)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"ActiveYN" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
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
			"EmployeeCounty" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeCountry" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeePhone" => [
				"dbType" => "varchar(30)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeFax" => [
				"dbType" => "varchar(30)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeSSNumber" => [
				"dbType" => "varchar(15)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeEmailAddress" => [
				"dbType" => "varchar(60)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeDepartmentID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"PictureURL" => [
				"dbType" => "varchar(80)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"HireDate" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"Birthday" => [
				"dbType" => "datetime",
				"inputType" => "datetime",
				"defaultValue" => "now"
			],
			"Commissionable" => [
				"dbType" => "tinyint(1)",
				"inputType" => "checkbox",
				"defaultValue" => "0"
			],
			"CommissionPerc" => [
				"dbType" => "float",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"CommissionCalcMethod" => [
				"dbType" => "varchar(1)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeManager" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeRegionID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeSourceID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"EmployeeIndustryID" => [
				"dbType" => "varchar(36)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"Notes" => [
				"dbType" => "varchar(255)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"NextOfKinName" => [
				"dbType" => "varchar(50)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"NextOfKinNumber" => [
				"dbType" => "varchar(30)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Totals" => [
			"MonthToDateGross" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MonthToDateFICA" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MonthToDateFederal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MonthToDateState" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MonthToDateLocal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"MonthToDateOther" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateGross" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateFICA" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateFederal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateState" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateLocal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"QuarterToDateOther" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateGross" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateFICA" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateFederal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateState" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateLocal" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			],
			"YearToDateOther" => [
				"dbType" => "decimal(19,4)",
				"inputType" => "text",
				"defaultValue" => ""
			]
		],
		"Payroll Employees Details" => [
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
			]
		]
];
	public $columnNames = [
		"EmployeeID" => "Employee ID",
		"EmployeeTypeID" => "Employee Type",
		"EmployeeName" => "Employee Name",
		"ActiveYN" => "Active",
		"EmployeeUserName" => "User Name",
		"HireDate" => "Hire Date",
		"EmployeePassword" => "Employee Password",
		"EmployeePasswordOld" => "Employee Password Old",
		"EmployeePasswordDate" => "Employee Password Date",
		"EmployeePasswordExpires" => "Employee Password Expires",
		"EmployeePasswordExpiresDate" => "Employee Password Expires Date",
		"EmployeeAddress1" => "Employee Address 1",
		"EmployeeAddress2" => "Employee Address 2",
		"EmployeeCity" => "Employee City",
		"EmployeeState" => "Employee State",
		"EmployeeZip" => "Employee Zip",
		"EmployeeCountry" => "Employee Country",
		"EmployeePhone" => "Employee Phone",
		"EmployeeFax" => "Employee Fax",
		"EmployeeSSNumber" => "Employee SSNumber",
		"EmployeeEmailAddress" => "Employee Email Address",
		"EmployeeDepartmentID" => "Employee Department ID",
		"PictureURL" => "Picture URL",
		"Birthday" => "Birthday",
		"Commissionable" => "Commissionable",
		"CommissionPerc" => "Commission Perc",
		"CommissionCalcMethod" => "Commission Calc Method",
		"EmployeeManager" => "Employee Manager",
		"EmployeeRegionID" => "Employee Region ID",
		"EmployeeSourceID" => "Employee Source ID",
		"EmployeeIndustryID" => "Employee Industry ID",
		"Notes" => "Notes",
		"NextOfKinName" => "Next Of Kin Name",
		"NextOfKinNumber" => "Next Of Kin Number",
		"MonthToDateGross" => "Month To Date Gross",
		"MonthToDateFICA" => "Month To Date FICA",
		"MonthToDateFederal" => "Month To Date Federal",
		"MonthToDateState" => "Month To Date State",
		"MonthToDateLocal" => "Month To Date Local",
		"MonthToDateOther" => "Month To Date Other",
		"QuarterToDateGross" => "Quarter To Date Gross",
		"QuarterToDateFICA" => "Quarter To Date FICA",
		"QuarterToDateFederal" => "Quarter To Date Federal",
		"QuarterToDateState" => "Quarter To Date State",
		"QuarterToDateLocal" => "Quarter To Date Local",
		"QuarterToDateOther" => "Quarter To Date Other",
		"YearToDateGross" => "Year To Date Gross",
		"YearToDateFICA" => "Year To Date FICA",
		"YearToDateFederal" => "Year To Date Federal",
		"YearToDateState" => "Year To Date State",
		"YearToDateLocal" => "Year To Date Local",
		"YearToDateOther" => "Year To Date Other",
		"EmployeeCounty" => "Employee County",
		"Approved" => "Approved",
		"ApprovedBy" => "Approved By",
		"ApprovedDate" => "Approved Date",
		"EnteredBy" => "Entered By"
	];
}
?>


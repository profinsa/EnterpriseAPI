<?php

/*
Name of Page: PayrollW3DetailList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW3DetailList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PayrollW3DetailList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW3DetailList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPPayroll\PayrollSetup\PayrollW3DetailList.php
 
Calls:
MySql Database
 
Last Modified: 04/08/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class PayrollW3DetailList extends gridDataSource{
public $tableName = "payrollw3detail";
public $dashboardTitle ="PayrollW3Detail";
public $breadCrumbTitle ="PayrollW3Detail";
public $idField ="ControlNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ControlNumber"];
public $gridFields = [

"ControlNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TotalNoStatements" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"EstablishmentNo" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployerIdentifyicationNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ControlNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalNoStatements" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"EstablishmentNo" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerIdentifyicationNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OtherEmployerIdentifyicationNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"_941" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Military" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"_943" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"CT1" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Hshld" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"MedicareGovtEmp" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
]
]];
public $columnNames = [

"ControlNumber" => "Control Number",
"TotalNoStatements" => "Total No Statements",
"EstablishmentNo" => "Establishment No",
"EmployerIdentifyicationNumber" => "Employer Identifyication Number",
"OtherEmployerIdentifyicationNumber" => "Other Employer Identifyication Number",
"Box1" => "Box 1",
"Box2" => "Box 2",
"Box3" => "Box 3",
"Box4" => "Box 4",
"Box5" => "Box 5",
"Box6" => "Box 6",
"Box7" => "Box 7",
"Box8" => "Box 8",
"Box9" => "Box 9",
"Box10" => "Box 10",
"Box11" => "Box 11",
"Box12" => "Box 12",
"Box15" => "Box 15",
"_941" => "_941",
"Military" => "Military",
"_943" => "_943",
"CT1" => "CT1",
"Hshld" => "Hshld",
"MedicareGovtEmp" => "Medicare Govt Emp"];
}?>

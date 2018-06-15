<?php

/*
Name of Page: CompaniesWorkflowByEmployeesList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesWorkflowByEmployeesList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/CompaniesWorkflowByEmployeesList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesWorkflowByEmployeesList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CompaniesWorkflowByEmployeesList.php
 
Calls:
MySql Database
 
Last Modified: 04/07/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "companiesworkflowbyemployees";
public $dashboardTitle ="CompaniesWorkflowByEmployees";
public $breadCrumbTitle ="CompaniesWorkflowByEmployees";
public $idField ="WorkFlowTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkFlowTypeID","WorkFlowResponsibleEmployee"];
public $gridFields = [

"WorkFlowTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkFlowResponsibleEmployee" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"WorkFlowDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"WorkFlowTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowResponsibleEmployee" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkFlowTypeID" => "Work Flow Type ID",
"WorkFlowResponsibleEmployee" => "Responsible Employee",
"WorkFlowDescription" => "Description"];
}?>

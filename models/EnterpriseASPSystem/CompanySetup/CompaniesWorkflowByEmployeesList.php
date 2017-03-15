<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesworkflowbyemployees";
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

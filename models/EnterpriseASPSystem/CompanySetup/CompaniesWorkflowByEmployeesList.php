<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesworkflowbyemployees";
public $gridFields =["WorkFlowTypeID","WorkFlowResponsibleEmployee","WorkFlowDescription"];
public $dashboardTitle ="CompaniesWorkflowByEmployees";
public $breadCrumbTitle ="CompaniesWorkflowByEmployees";
public $idField ="WorkFlowTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","WorkFlowTypeID","WorkFlowResponsibleEmployee"];
public $editCategories = [
"Main" => [

"WorkFlowTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowResponsibleEmployee" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkFlowTypeID" => "Work Flow Type ID",
"WorkFlowResponsibleEmployee" => "Responsible Employee",
"WorkFlowDescription" => "Description"];
}?>

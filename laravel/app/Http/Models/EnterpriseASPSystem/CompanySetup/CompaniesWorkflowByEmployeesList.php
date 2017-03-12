<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesworkflowbyemployees";
protected $gridFields =["WorkFlowTypeID","WorkFlowResponsibleEmployee","WorkFlowDescription"];
public $dashboardTitle ="CompaniesWorkflowByEmployees";
public $breadCrumbTitle ="CompaniesWorkflowByEmployees";
public $idField ="WorkFlowTypeID";
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

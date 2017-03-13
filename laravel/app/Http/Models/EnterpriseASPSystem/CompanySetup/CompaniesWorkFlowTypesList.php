<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesworkflowtypes";
protected $gridFields =["WorkFlowTypeID","WorkFlowTypeDescription"];
public $dashboardTitle ="CompaniesWorkFlowTypes";
public $breadCrumbTitle ="CompaniesWorkFlowTypes";
public $idField ="WorkFlowTypeID";
public $editCategories = [
"Main" => [

"WorkFlowTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"WorkFlowTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"WorkFlowTypeID" => "Work Flow Type ID",
"WorkFlowTypeDescription" => "Work Flow Type Description"];
}?>
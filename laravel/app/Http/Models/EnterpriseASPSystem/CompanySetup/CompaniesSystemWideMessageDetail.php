<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiessystemwidemessage";
protected $gridFields =["SystemMessageAt"];
public $dashboardTitle ="CompaniesSystemWideMessage ";
public $breadCrumbTitle ="CompaniesSystemWideMessage ";
public $idField ="undefined";
public $editCategories = [
"Main" => [

"SystemMessageAt" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"SystemMessageBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"SystemMessage" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SystemMessageAt" => "SystemMessage At",
"SystemMessageBy" => "SystemMessageBy",
"SystemMessage" => "SystemMessage"];
}?>

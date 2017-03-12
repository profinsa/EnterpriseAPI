<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "departments";
protected $gridFields =["DepartmentID","DepartmentName","DepartmentDescription","DepartmentPhone"];
public $dashboardTitle ="Departments";
public $breadCrumbTitle ="Departments";
public $idField ="undefined";
public $editCategories = [
"Main" => [

"DepartmentName" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentState" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentWebAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentNotes" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DepartmentID" => "Department ID",
"DepartmentName" => "Department Name",
"DepartmentDescription" => "Department Description",
"DepartmentPhone" => "Department Phone",
"DepartmentAddress1" => "DepartmentAddress1",
"DepartmentAddress2" => "DepartmentAddress2",
"DepartmentCity" => "DepartmentCity",
"DepartmentState" => "DepartmentState",
"DepartmentZip" => "DepartmentZip",
"DepartmentCountry" => "DepartmentCountry",
"DepartmentFax" => "DepartmentFax",
"DepartmentEmail" => "DepartmentEmail",
"DepartmentWebAddress" => "DepartmentWebAddress",
"DepartmentNotes" => "DepartmentNotes"];
}?>

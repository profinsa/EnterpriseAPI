<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollw3detail";
public $gridFields =["ControlNumber","TotalNoStatements","EstablishmentNo","EmployerIdentifyicationNumber"];
public $dashboardTitle ="PayrollW3Detail";
public $breadCrumbTitle ="PayrollW3Detail";
public $idField ="ControlNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ControlNumber"];
public $editCategories = [
"Main" => [

"ControlNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalNoStatements" => [
"inputType" => "text",
"defaultValue" => ""
],
"EstablishmentNo" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployerIdentifyicationNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"OtherEmployerIdentifyicationNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box1" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box2" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box3" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box4" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box5" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box6" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box7" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box8" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box9" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box10" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box11" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box12" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15" => [
"inputType" => "text",
"defaultValue" => ""
],
"_941" => [
"inputType" => "text",
"defaultValue" => ""
],
"Military" => [
"inputType" => "text",
"defaultValue" => ""
],
"_943" => [
"inputType" => "text",
"defaultValue" => ""
],
"CT1" => [
"inputType" => "text",
"defaultValue" => ""
],
"Hshld" => [
"inputType" => "text",
"defaultValue" => ""
],
"MedicareGovtEmp" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ControlNumber" => "Control Number",
"TotalNoStatements" => "Total No Statements",
"EstablishmentNo" => "Establishment No",
"EmployerIdentifyicationNumber" => "Employer Identifyication Number",
"OtherEmployerIdentifyicationNumber" => "OtherEmployerIdentifyicationNumber",
"Box1" => "Box1",
"Box2" => "Box2",
"Box3" => "Box3",
"Box4" => "Box4",
"Box5" => "Box5",
"Box6" => "Box6",
"Box7" => "Box7",
"Box8" => "Box8",
"Box9" => "Box9",
"Box10" => "Box10",
"Box11" => "Box11",
"Box12" => "Box12",
"Box15" => "Box15",
"_941" => "_941",
"Military" => "Military",
"_943" => "_943",
"CT1" => "CT1",
"Hshld" => "Hshld",
"MedicareGovtEmp" => "MedicareGovtEmp"];
}?>

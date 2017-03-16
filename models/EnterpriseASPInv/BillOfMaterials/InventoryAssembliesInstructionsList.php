<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryassembliesinstructions";
public $dashboardTitle ="Assemblies Instructions";
public $breadCrumbTitle ="Assemblies Instructions";
public $idField ="AssemblyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID"];
public $gridFields = [

"AssemblyID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AssemblySchematicURL" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AssemblyPictureURL" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AssemblyDiagramURL" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AssemblyOtherURL" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"AssemblyLastUpdated" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"AssemblyLastUpdatedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"AssemblyID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyBuildInstructions" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblySchematicURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyPictureURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyDiagramURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyOtherURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyTimeToBuild" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyTimeToBuildUnit" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyLastUpdated" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AssemblyLastUpdatedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"AssemblyID" => "Assembly ID",
"AssemblySchematicURL" => "Schematic URL",
"AssemblyPictureURL" => "Picture URL",
"AssemblyDiagramURL" => "Diagram URL",
"AssemblyOtherURL" => "Other URL",
"AssemblyLastUpdated" => "Last Updated",
"AssemblyLastUpdatedBy" => "Last Updated By",
"AssemblyBuildInstructions" => "AssemblyBuildInstructions",
"AssemblyTimeToBuild" => "AssemblyTimeToBuild",
"AssemblyTimeToBuildUnit" => "AssemblyTimeToBuildUnit"];
}?>

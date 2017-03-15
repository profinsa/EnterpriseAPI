<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "inventoryassembliesinstructions";
protected $gridFields =["AssemblyID","AssemblySchematicURL","AssemblyPictureURL","AssemblyDiagramURL","AssemblyOtherURL","AssemblyLastUpdated","AssemblyLastUpdatedBy"];
public $dashboardTitle ="Assemblies Instructions";
public $breadCrumbTitle ="Assemblies Instructions";
public $idField ="AssemblyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID"];
public $editCategories = [
"Main" => [

"AssemblyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyBuildInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblySchematicURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyPictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyDiagramURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyOtherURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyTimeToBuild" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyTimeToBuildUnit" => [
"inputType" => "text",
"defaultValue" => ""
],
"AssemblyLastUpdated" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"AssemblyLastUpdatedBy" => [
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

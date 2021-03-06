<?php

/*
Name of Page: InventoryAssembliesInstructionsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesInstructionsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/InventoryAssembliesInstructionsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesInstructionsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPInv\BillofMaterials\InventoryAssembliesInstructionsList.php
 
Calls:
MySql Database
 
Last Modified: 04/09/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class InventoryAssembliesInstructionsList extends gridDataSource{
public $tableName = "inventoryassembliesinstructions";
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
"AssemblyBuildInstructions" => "Assembly Build Instructions",
"AssemblyTimeToBuild" => "Assembly Time To Build",
"AssemblyTimeToBuildUnit" => "Assembly Time To Build Unit"];
}?>

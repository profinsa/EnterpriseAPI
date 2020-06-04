<?php
/*
  Name of Page: Inventory Assemblies Instructions Detail model

  Method: Model for gridView. It provides data from database and default values, column names and categories

  Date created: 04/07/2019 Nikita Zaharov

  Use: this model used by gridViews for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by Grid controlle
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 04/07/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class InventoryAssembliesInstructionsDetail extends gridDataSource{
    public $tableName = "inventoryassembliesinstructions";
    public $dashboardTitle ="Inventory Assemblies";
    public $breadCrumbTitle ="Inventory Assemblies";
    public $idField ="AssemblyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssemblyID"];
    public $gridFields = [
        "AssemblyID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssemblyID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true"
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
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "AssemblyBuildInstructions" => [
                "dbType" => "varchar(999)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "AssemblyID" => "Assembly ID",
        "AssemblyBuildInstructions" => "Build Instructions",
        "AssemblySchematicURL" => "Schematic URL",
        "AssemblyPictureURL" => "Picture URL",
        "AssemblyDiagramURL" => "Diagram URL",
        "AssemblyOtherURL" => "Other URL",
        "AssemblyLastUpdated" => "Last Updated",
        "AssemblyLastUpdatedBy" => "Last Updated By",
        "AssemblyTimeToBuild" => "AssemblyTimeToBuild",
        "AssemblyTimeToBuildUnit" => "AssemblyTimeToBuildUnit"
    ];
}
?>

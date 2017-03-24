<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "fixedassetstatus";
    public $dashboardTitle ="Fixed Asset Status";
    public $breadCrumbTitle ="Fixed Asset Status";
    public $idField ="AssetStatusID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetStatusID"];
    public $gridFields = [
        "AssetStatusID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetStatusDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetStatusID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "AssetStatusDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "AssetStatusID" => "Asset Status ID",
        "AssetStatusDescription" => "Asset Status Description"
    ];
}
?>

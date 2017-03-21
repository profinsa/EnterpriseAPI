<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "fixedassettype";
    public $dashboardTitle ="Fixed Asset Type";
    public $breadCrumbTitle ="Fixed Asset Type";
    public $idField ="AssetTypeID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetTypeID"];
    public $gridFields = [
        "AssetTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetTypeDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disableEdit" => true
            ],
            "AssetTypeDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "AssetTypeID" => "Asset Type ID",
        "AssetTypeDescription" => "Asset Type Description"
    ];
}
?>

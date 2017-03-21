<?php
namespace App\Models;
require __DIR__ . "/../../../Models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgeraccounttypes";
    public $dashboardTitle ="Ledger Account Types";
    public $breadCrumbTitle ="Ledger Account Types";
    public $idField ="GLAccountType";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountType"];
    public $gridFields = [
        "GLAccountType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "GLAccountType" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]];
    public $columnNames = [
        "GLAccountType" => "GL Account Type"
    ];
}
?>

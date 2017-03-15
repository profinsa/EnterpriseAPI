<?php
/*
Name of Page: ledgerAccountGroup model

Method: Model for GeneralLedger/ledgerAccountGroup. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 16.02.2016

Use: this model used by views/GeneralLedger/ledgerAccountGroup.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/ledgerAccountGroup.php
used as model by views/GeneralLedger/ledgerAccountGroup.php

Calls:
sql

Last Modified: 15.03.2016
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "ledgeraccountgroup";

    //fields to render in grid
    public $gridFields = [
        "GLAccountGroupID",
        "GLAccountGroupName",
        "GLAccountGroupBalance",
        "GLAccountUse",
        "GLReportingAccount",
        "GLReportLevel"
    ];

    public $dashboardTitle = "Ledger Account Group";
    public $breadCrumbTitle = "Ledger Account Group";
    public $idField = "GLAccountGroupID";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "GLAccountGroupID"];    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "GLAccountGroupID" => [
                "disabledEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountGroupName" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountGroupBalance"	=> [
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLAccountUse" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLReportingAccount" => [
                "inputType" => "text",
                "defaultValue" => "False"
            ],
            "GLReportLevel" => [
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
            "GLAccountGroupID" => "Group Account ID",
            "GLAccountGroupName" => "Group Account Name",
            "GLAccountGroupBalance"	=> "Group Balance",
            "GLAccountUse" => "Group Account Use",
            "GLReportingAccount" => "Group Reporting Accounting",
            "GLReportLevel" => "Group Reporting Level"
    ];
}
?>
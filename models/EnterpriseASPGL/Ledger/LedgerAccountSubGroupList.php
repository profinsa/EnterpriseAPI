<?php
/*
  Name of Page: ledgerAccountSubGroup model

  Method: Model for GeneralLedger/ledgerAccountSubGroup. It provides data from database and default values, column names and categories

  Date created: Nikita Zaharov, 07.21.2016

  Use: this model used by views/GeneralLedger/ledgerAccountSubGroup.php for:
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

  Last Modified: 08.16.2016
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class LedgerAccountSubGroupList extends gridDataSource{
    public $tableName = "ledgersubaccountgroup";

    public $dashboardTitle = "Ledger Account Sub Group";
    public $breadCrumbTitle = "Ledger Account Sub Group";
    public $idField = "GLAccountCode";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "GLAccountCode", "GLSubAccountCode"];
    
    //fields to render in grid
    public $gridFields = [
        "GLSubAccountCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountSubGroupName" => [
            "dbType" => "varchar(128)",
            "inputType" => "text"
        ],
        "GLAccountCode" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLAccountGroupBalance" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "GLAccountUse" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "GLReportingAccount" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "GLReportLevel" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ]
    ];
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "GLSubAccountCode" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text"
            ],
            "GLAccountSubGroupName" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountCode" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLAccountGroupBalance"	=> [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => "0.00"
            ],
            "GLAccountUse" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLReportingAccount" => [
                "dbType" => "tinyint(1)",
                "dbType" => "varchar(36)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "GLReportLevel" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "GLAccountCode" => "Group Account ID",
        "GLSubAccountCode" => "Sub Group Account ID",
        "GLAccountSubGroupName" => "Group Account Name",
        "GLAccountGroupBalance"	=> "Group Balance",
        "GLAccountUse" => "Group Account Use",
        "GLReportingAccount" => "Group Reporting Accounting",
        "GLReportLevel" => "Group Reporting Level"
    ];
}
?>
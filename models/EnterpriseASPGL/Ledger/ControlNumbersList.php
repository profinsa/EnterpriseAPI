<?php
/*
Name of Page: Control Numbers model

Method: Model for GeneralLedger/ControlNumbers. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 09.01.2017

Use: this model used by views/GeneralLedger/Control Numbers.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/Control Numbers.php
used as model by views/GeneralLedger/Control Numbers.php

Calls:
sql

Last Modified: 09.01.2017
Last Modified by: Nikita Zaharov
*/

require __DIR__ . "/../../../models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "glcontrolnumbers";

    //fields to render in grid
    public $gridFields = [
        "GLControlNumber" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "GLControlNumberName" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "GLControlNumberDesc" => [
            "dbType" => "varchar(128)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
   ];

    public $dashboardTitle = "Ledger Control Numbers";
    public $breadCrumbTitle = "Ledger Control Numbers";
    public $idField = "GLControlNumber";
    public $idFields = ["CompanyID", "DivisionID", "DepartmentID", "GLControlNumber"];
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "GLControlNumber" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => "true",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLControlNumberName" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLControlNumberDesc" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MemoOne" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MemoTwo" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MemoThree" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "GLControlNumber" => "Control Number",
        "GLControlNumberName" => "Control Number Name",
        "GLControlNumberDesc" => "GL Control Number Desc",
        "MemoOne" => "Memo One",
        "MemoTwo" => "Memo Two",
        "MemoThree" => "Memo Three",
    ];
}
?>
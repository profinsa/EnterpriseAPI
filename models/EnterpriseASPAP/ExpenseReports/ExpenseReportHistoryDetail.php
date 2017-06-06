<?php
/*
  Name of Page: ExpenseReportHistoryDetail model

  Method: Model for gridView

  Date created: 05/30/2017 Nikita Zaharov

  Use: this model used by gridView for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods have their own parameters

  Output parameters:
  - dictionaries as public properties
  - methods have their own output

  Called from:
  created and used for ajax requests by grid controller
  used as model by gridView

  Calls:
  MySql Database

  Last Modified: 05/30/2017
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
protected $tableName = "expensereportdetailhistory";
public $dashboardTitle ="Expense Report History Detail";
public $breadCrumbTitle ="Expense Report History Detail";
public $idField ="ExpenseReportID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportID"];
    public $gridFields = [
        "ExpenseReportID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ExpenseReporDetailID" => [
            "dbType" => "int(11)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ExpenseReportID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "disabledNew" => "true",
            ],
            "ExpenseReporDetailID" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true",
            ],
            "ExpenseReportItemID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
            ],
            "ExpenseReportDetailDescription" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailAmount" => [
                "dbType" => "char(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailUnits" => [
                "dbType" => "char(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailTotal" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportReceiptProvided" => [
                "dbType" => "tityint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ExpenseReportReceiptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Memos" => [
            "ExpenseReportDetailMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDetailMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "ExpenseReportID" => "Report ID",
        "ExpenseReporDetailID" => "Detail ID",
        "ExpenseReportDetailMemo1" => "Memo 1",
        "ExpenseReportDetailMemo2" => "Memo 2",
        "ExpenseReportDetailMemo3" => "Memo 3",
        "ExpenseReportDetailMemo4" => "Memo 4",
        "ExpenseReportDetailMemo5" => "Memo 5",
        "ExpenseReportItemID" => "Item ID",
        "ExpenseReportDetailDescription" => "Description",
        "ExpenseReportDetailAmount" => "Amount",
        "ExpenseReportDetailUnits" => "Units",
        "ExpenseReportDetailTotal" => "Total",
        "ExpenseReportReceiptProvided" => "Receipt Provided",
        "ExpenseReportReceiptID" => "Receipt ID"
    ];
}
?>

<?php

/*
Name of Page: ExpenseReportHeaderList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/ExpenseReportHeaderList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\ExpenseReports\ExpenseReportHeaderList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "expensereportheader";
    public $dashboardTitle ="ExpenseReportHeader";
    public $breadCrumbTitle ="ExpenseReportHeader";
    public $idField ="ExpenseReportID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ExpenseReportID"];
    public $gridFields = [
        "ExpenseReportID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ExpenseReportType" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ExpenseReportDate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ],
        "ExpenseReportForEmployee" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ExpenseReportReason" => [
            "dbType" => "varchar(36)",
            "inputType" => "dropdown"
        ],
        "ExpenseReportTotal" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "ExpenseReportDueEmployee" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ],
        "ExpenseReportPaid" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "ExpenseReportPaymentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ExpenseReportApproved" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "ExpenseReportID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
            ],
            "ExpenseReportType" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getExpenseReportTypes",
                "defaultValue" => ""
            ],
            "ExpenseReportDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ExpenseReportForEmployee" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "ExpenseReportReason" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getExpenseReportReasons",
                "defaultValue" => ""
            ],
            "ExpenseReportDescription" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportTotal" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportAdvances" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportDueEmployee" => [
                "dbType" => "decimal(19,4)",
                "format" => "{0:n}",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportPaid" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ExpenseReportPaidDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "ExpenseReportPaymentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportApproved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ExpenseReportApprovedBy" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getPayrollEmployees",
                "defaultValue" => ""
            ],
            "ExpenseReportApprovedDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ]
        ],
        "Memos" => [
            "ExpenseReportMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ExpenseReportMemo10" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Signature" => [
            "Signature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SignaturePassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "SupervisorPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerSignature" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ManagerPassword" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Expense Report Detail" => [
            "ExpenseReportID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
            ]
        ]
    ];
    
    public $columnNames = [
        "ExpenseReportID" => "Report ID",
        "ExpenseReportType" => "Type",
        "ExpenseReportDate" => "Date",
        "ExpenseReportForEmployee" => "For Employee",
        "ExpenseReportReason" => "Reason",
        "ExpenseReportTotal" => "Total",
        "ExpenseReportDueEmployee" => "Due Employee",
        "ExpenseReportPaymentID" => "Payment ID",
        "ExpenseReportDescription" => "Expense Report Description",
        "ExpenseReportAdvances" => "Expense Report Advances",
        "ExpenseReportPaid" => "Paid",
        "ExpenseReportPaidDate" => "Expense Report Paid Date",
        "ExpenseReportApproved" => "Approved",
        "ExpenseReportApprovedBy" => "Expense Report Approved By",
        "ExpenseReportApprovedDate" => "Expense Report Approved Date",
        "ExpenseReportMemo1" => "Memo 1",
        "ExpenseReportMemo2" => "Memo 2",
        "ExpenseReportMemo3" => "Memo 3",
        "ExpenseReportMemo4" => "Memo 4",
        "ExpenseReportMemo5" => "Memo 5",
        "ExpenseReportMemo6" => "Memo 6",
        "ExpenseReportMemo7" => "Memo 7",
        "ExpenseReportMemo8" => "Memo 8",
        "ExpenseReportMemo9" => "Memo 9",
        "ExpenseReportMemo10" => "Memo 10",
        "Signature" => "Signature",
        "SignaturePassword" => "Signature Password",
        "SupervisorSignature" => "Supervisor Signature",
        "SupervisorPassword" => "Supervisor Password",
        "ManagerSignature" => "Manager Signature",
        "ManagerPassword" => "Manager Password",
        "ExpenseReportItemID" => "Item ID",
        "ExpenseReportDetailDescription" => "Description",
        "ExpenseReportDetailAmount" => "Amount",
        "ExpenseReportDetailUnits" => "Units",
        "ExpenseReportDetailTotal" => "Total",
        "ExpenseReportReceiptProvided" => "Receipt Provided",
        "ExpenseReportReceiptID" => "Receipt ID",
        "ProjectID" => "Project ID"
    ];

    public $detailPages = [
        "Expense Report Detail" => [
            "hideFields" => "true",
            "viewPath" => "Payroll/EmployeeExpenses/ExpenseReportsDetail",
            "newKeyField" => "ExpenseReportID",
            "keyFields" => ["ExpenseReportID", "ExpenseReporDetailID"],
            "detailIdFields" => ["CompanyID","DivisionID","DepartmentID","ExpenseReportID", "ExpenseReporDetailID"],
            "gridFields" => [
                "ExpenseReportItemID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
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
                ],
                "ProjectID" => [
                    "dbType" => "varchar(36)",
                    "inputType" => "text",
                    "defaultValue" => ""
                ]
            ]
        ]
    ];
    //getting rows for grid
    public function getExpenseReportDetail($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages["Expense Report Detail"]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages["Expense Report Detail"]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";
                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND ExpenseReportID='" . $id . "'";

        
        $result = DB::select("SELECT " . implode(",", $fields) . " from expensereportdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function deleteExpenseReportDetail(){
        $user = Session::get("user");
        $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentsID", "ExpenseReportID", "ExpenseReporDetailID"];
        $keyValues = explode("__", $_GET["item"]);
        $keyFields = "";
        $fcount = 0;
        foreach($idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from expensereportdetail " .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>

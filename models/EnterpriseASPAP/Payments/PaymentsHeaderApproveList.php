<?php

/*
Name of Page: PaymentsHeaderApproveList model
 
Method: Model for www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderApproveList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/PaymentsHeaderApproveList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderApproveList.php
used as model by views/www.integralaccountingx.com\NewTechPhp\app\Http\Models\EnterpriseASPAP\Payments\PaymentsHeaderApproveList.php
 
Calls:
MySql Database
 
Last Modified: 08/15/2017
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "paymentsheader";
    protected $gridConditions = "(IFNULL(ApprovedForPayment,0)=0 AND Posted=1 AND IFNULL(Void,0)=0 AND PaymentID <> 'DEFAULT')";
    public $dashboardTitle ="Approve Payments";
    public $breadCrumbTitle ="Approve Payments";
    public $idField ="PaymentID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","PaymentID"];
    public $modes = ["grid", "print"]; // list of enabled modes
    public $features = ["selecting"]; //list enabled features
    public $gridFields = [

    "PaymentID" => [
        "dbType" => "varchar(36)",
        "inputType" => "text"
    ],
    "InvoiceNumber" => [
        "dbType" => "varchar(36)",
        "inputType" => "text"
    ],
    "VendorID" => [
        "dbType" => "varchar(50)",
        "inputType" => "text"
    ],
    "PaymentTypeID" => [
        "dbType" => "varchar(36)",
        "inputType" => "text"
    ],
    "CheckNumber" => [
        "dbType" => "varchar(20)",
        "inputType" => "text"
    ],
    "PaymentDate" => [
        "dbType" => "datetime",
        "format" => "{0:d}",
        "inputType" => "datetime"
    ],
    "CurrencyID" => [
        "dbType" => "varchar(3)",
        "inputType" => "text"
    ],
    "Amount" => [
        "dbType" => "decimal(19,4)",
        "format" => "{0:n}",
        "inputType" => "text"
    ],
    "Cleared" => [
        "dbType" => "tinyint(1)",
        "inputType" => "text"
    ],
    "Posted" => [
        "dbType" => "tinyint(1)",
        "inputType" => "text"
    ],
    "Reconciled" => [
        "dbType" => "tinyint(1)",
        "inputType" => "text"
    ]
    ];

    public $editCategories = [
    "Main" => [

    "PaymentID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "PaymentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "CheckNumber" => [
    "dbType" => "varchar(20)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "CheckPrinted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "CheckDate" => [
    "dbType" => "timestamp",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "Paid" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "PaymentDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "Memorize" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "PaymentClassID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "SystemDate" => [
    "dbType" => "timestamp",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "DueToDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "PurchaseDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "Amount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "UnAppliedAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "GLBankAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "PaymentStatus" => [
    "dbType" => "varchar(10)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "Void" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "Notes" => [
    "dbType" => "varchar(255)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "CurrencyExchangeRate" => [
    "dbType" => "float",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "CreditAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "SelectedForPayment" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "SelectedForPaymentDate" => [
    "dbType" => "timestamp",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "ApprovedForPayment" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "ApprovedForPaymentDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime",
    "defaultValue" => "now"
    ],
    "Cleared" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "InvoiceNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "Posted" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "Reconciled" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "Credit" => [
    "dbType" => "tinyint(1)",
    "inputType" => "checkbox",
    "defaultValue" => "0"
    ],
    "ApprovedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "BatchControlNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
    "BatchControlTotal" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text",
    "defaultValue" => ""
    ],
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
    ],
    "VendorInvoiceNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text",
    "defaultValue" => ""
    ]
    ]];
    public $columnNames = [

    "PaymentID" => "Payment ID",
    "InvoiceNumber" => "Purchase Number",
    "VendorID" => "Vendor ID",
    "PaymentTypeID" => "Payment Type",
    "CheckNumber" => "Check Number",
    "PaymentDate" => "Payment Date",
    "CurrencyID" => "Currency ID",
    "Amount" => "Amount",
    "Cleared" => "Cleared",
    "Posted" => "Posted",
    "Reconciled" => "Reconciled",
    "CheckPrinted" => "Check Printed",
    "CheckDate" => "Check Date",
    "Paid" => "Paid",
    "Memorize" => "Memorize",
    "PaymentClassID" => "Payment Class ID",
    "SystemDate" => "System Date",
    "DueToDate" => "Due To Date",
    "PurchaseDate" => "Purchase Date",
    "UnAppliedAmount" => "UnApplied Amount",
    "GLBankAccount" => "GL Bank Account",
    "PaymentStatus" => "Payment Status",
    "Void" => "Void",
    "Notes" => "Notes",
    "CurrencyExchangeRate" => "Currency Exchange Rate",
    "CreditAmount" => "Credit Amount",
    "SelectedForPayment" => "Selected For Payment",
    "SelectedForPaymentDate" => "Selected For Payment Date",
    "ApprovedForPayment" => "Approved For Payment",
    "ApprovedForPaymentDate" => "Approved For Payment Date",
    "Credit" => "Credit",
    "ApprovedBy" => "Approved By",
    "EnteredBy" => "Entered By",
    "BatchControlNumber" => "Batch Control Number",
    "BatchControlTotal" => "Batch Control Total",
    "Signature" => "Signature",
    "SignaturePassword" => "Signature Password",
    "SupervisorSignature" => "Supervisor Signature",
    "SupervisorPassword" => "Supervisor Password",
    "ManagerSignature" => "Manager Signature",
    "ManagerPassword" => "Manager Password",
    "VendorInvoiceNumber" => "Vendor Invoice Number"];

    public function Approve(){
        $user = Session::get("user");

        $PaymentIds = explode(",", $_POST["PaymentIds"]);
        $success = true;
        foreach($PaymentIds as $PaymentId){
            DB::statement("CALL Payment_Approve('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $PaymentId . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

            $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
            if($result[0]->SWP_RET_VALUE == -1)
                $success = false;
        }

        if($success)
            header('Content-Type: application/json');
        else
            return response("failed", 400)->header('Content-Type', 'text/plain');
    }
    
    public function ApproveAll(){
        $user = Session::get("user");

        DB::statement("CALL Payment_ApproveAll('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $user["EmployeeID"] . "',@SWP_RET_VALUE)");

        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo $result[0]->SWP_RET_VALUE;
        else
            return response($result[0]->SWP_RET_VALUE, 400)->header('Content-Type', 'text/plain');
    }
}?>

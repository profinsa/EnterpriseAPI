<?php
/*
Name of Page: bankTransactions model

Method: Model for GeneralLedger/banckAccounts. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 17.02.2016

Use: this model used by views/GeneralLedger/bankTransactions.php for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by controllers/GeneralLedger/banckAccounts.php
used as model by views/GeneralLedger/backAccounts.php

Calls:
sql

Last Modified: 06.03.2016
Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    protected $tableName = "banktransactions";
    //fields to render in grid
    protected $gridFields = [ 	 	
        "BankTransactionID",
        "BankDocumentNumber",
        "TransactionType",
        "TransactionDate",
        "TransactionAmount",
        "Posted",
        "Cleared"
    ];

    public $dashboardTitle = "Bank Transactions";
    public $breadCrumbTitle = "Bank Transactions";
    public $idField = "BankTransactionID";
    
    //categories which contains table columns, used by view for render tabs and them content
    public $editCategories = [
        "Main" => [
            "BankTransactionID" => [
                "disabledEdit" => true,
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BankDocumentNumber" =>	[
                "inputType" => "text",
                "defaultValue" => ""
            ], 
            "GLBankAccount1" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "GLBankAccount2" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "TransactionType" => [
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getTransactionTypes"
            ],
            "TransactionDate" => [
                "inputType" => "datepicker",
                "defaultValue" => ""
            ],
            "CurrencyID" =>	[
                "inputType" => "dropdown",
                "defaultValue" => "USD",
                "dataProvider" => "getCurrencyTypes"
            ],
            "CurrencyExchangeRate" => [
                "inputType" => "text",
                "defaultValue" => "1"
            ],
            "TransactionAmount" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "BeginningBalance" =>  [
                "inputType" => "checkbox",
                "defaultValue" => "false"
            ],	
            "Reference" =>  [
                "inputType" => "text",
                "defaultValue" => ""
            ],	 
            "Posted" =>  [
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],	
            "Cleared" =>  [
                "disabledEdit" => true,
                "disabledNew" => true,
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],	
            "Notes" =>  [
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];

    //table column to translation/ObjID
    public $columnNames = [
        "BankTransactionID" => "Transaction ID",
        "BankDocumentNumber" => "Bank Document Number", 	 
        "GLBankAccount1" => "Bank Account",
        "GLBankAccount2" => "Offset Account", 
        "TransactionType" => "Transaction Type", 
        "TransactionDate" => "Transaction Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate", 
        "TransactionAmount" => "Transaction Amount", 
        "BeginningBalance" => "Beginning Balance", 	
        "Reference" => "Reference", 	 
        "Posted" => "Posted", 	
        "Cleared" => "Cleared", 	
        "Notes" => "Notes" 
    ];

    //getting list of available transaction types 
    public function getTransactionTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT BankTransactionTypeID,BankTransactionTypeDesc from banktransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->BankTransactionTypeID] = [
                "title" => $value->BankTransactionTypeID,
                "value" => $value->BankTransactionTypeID
            ];
        
        return $res;
    }
}
?>
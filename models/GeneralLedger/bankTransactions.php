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

Last Modified: 17.02.2016
Last Modified by: Nikita Zaharov
*/

require "./models/GeneralLedger/gridDataSource.php";

class bankTransactions extends gridDataSource{
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
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBankAccount2" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionType" => [
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionDate" => [
                "inputType" => "text",
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
                "inputType" => "text",
                "defaultValue" => ""
            ],	
            "Reference" =>  [
                "inputType" => "text",
                "defaultValue" => ""
            ],	 
            "Posted" =>  [
                "inputType" => "text",
                "defaultValue" => ""
            ],	
            "Cleared" =>  [
                "inputType" => "text",
                "defaultValue" => ""
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
}
?>
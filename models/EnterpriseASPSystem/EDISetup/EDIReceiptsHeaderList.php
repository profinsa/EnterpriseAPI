<?php
/*
  Name of Page: EDI Receipts model
   
  Method: It provides data from database and default values, column names and categories
   
  Date created: 20/02/2019 Nikita Zaharov
   
  Use: this model used by views for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers
  used as model by views
   
  Calls:
  MySql Database
   
  Last Modified: 26/02/2019
  Last Modified by: Zaharov Nikita
*/

require "./models/gridDataSource.php";
require "./models/excelImport.php";

class gridData extends gridDataSource{
    public $tableName = "edireceiptsheader";
    public $dashboardTitle ="EDI Receipts";
    public $breadCrumbTitle ="EDI Receipts";
    public $idField ="ReceiptID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID"];
    public $features = ["selecting"];
    public $gridFields = [
        "ReceiptID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ReceiptTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "ReceiptClassID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIDirectionTypeID" => [
            "dbType" => "varchar(1)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIDocumentTypeID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "EDIOpen" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "CheckNumber" => [
            "dbType" => "varchar(20)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "TransactionDate" => [
            "dbType" => "timestamp",
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
            "inputType" => "text",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat"
        ],
        "Status" => [
            "dbType" => "varchar(10)",
            "inputType" => "text"
        ],
        "Deposited" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Cleared" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Reconciled" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ],
        "Posted" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "EDIDirectionTypeID" => [
                "dbType" => "varchar(1)",
                "inputType" => "dropdown",
                "dataProvider" => "getEDIDirectionTypeIDs",
                "defaultValue" => ""
            ],
            "EDIDocumentTypeID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getEDIDocumentTypeIDs",
                "defaultValue" => ""
            ],
            "EDIOpen" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getAccounts"
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NSF" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "Customer" => [
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "defaultValue" => ""
            ]
        ],
		"Memos" => [
            "HeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ],
        "...fields" => [
            "ReceiptID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => "",
                "disabledEdit" => "true",
                "disabledNew" => "true",
                "defaultValue" => "(new)",
                "dirtyAutoincrement" => "true"
            ],
            "ReceiptTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getReceiptTypes",
                "defaultValue" => ""
            ],
            "ReceiptClassID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledNew" => "true",
                "disabledEdit" => "true",
                "defaultValue" => "",
                "defaultOverride" => true,
				"defaultValue" => "Customer"
            ],
            "CheckNumber" => [
                "dbType" => "varchar(20)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CustomerID" => [
                "dbType" => "varchar(50)",
                "defaultValue" => "",
                "defaultOverride" => "true",
                "required" => "true",
                "inputType" => "dialogChooser",
                "dataProvider" => "getCustomers",
                "defaultValue" => ""
            ],
            "TransactionDate" => [
                "dbType" => "timestamp",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "Amount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "UnAppliedAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "GLBankAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "Status" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "NSF" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "Notes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CreditAmount" => [
                "dbType" => "decimal(19,4)",
                "inputType" => "text",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "defaultValue" => ""
            ],
            "Cleared" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
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
            "Deposited" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "HeaderMemo1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo3" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo4" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo5" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo6" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo7" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo8" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "HeaderMemo9" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
        ]
    ];

    public $headTableOne = [
        "Receipt ID" => "ReceiptID",
        "Receipt Type" => "ReceiptTypeID",
        "Receipt Class ID" => "ReceiptClassID",
    ];

    public $headTableTwo = [
        "Check Number" => "CheckNumber",
        "Customer ID" => "CustomerID"
    ];

    public $detailTable = [
        "viewPath" => "SystemSetup/EDISetup/EDIReceiptsDetail",
        "newKeyField" => "ReceiptID",
        "keyFields" => ["ReceiptID", "ReceiptDetailID"]
    ];

    public $footerTable = [
        "flagsHeader" => [
            "Posted" => "Posted",
        ],
        "flags" => [
            ["Cleared", "Cleared"],
            ["Reconciled", "Reconciled"],
            ["Deposited", "Deposited"]
        ],
        "totalFields" => [
            "UnApplied Amount" => "UnAppliedAmount",
            "Credit Amount" => "CreditAmount",
            "Amount" => "Amount"
        ]
    ];
    public $customerFields = [
        "CustomerID" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "AccountStatus" => [
            "dbType" => "varchar(36)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress1" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress2" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerAddress3" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCity" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerState" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerZip" => [
            "dbType" => "varchar(10)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerCountry" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerPhone" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerFax" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "CustomerEmail" => [
            "dbType" => "varchar(60)",
            "inputType" => "text",
            "defaultValue" => ""
        ],
        "Attention" => [
            "dbType" => "varchar(50)",
            "inputType" => "text",
            "defaultValue" => ""
        ]
    ];

    public $customerIdFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
    //getting data for Customer Page
    public function getCustomerInfo($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->customerFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->customerIdFields as $key){
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

        if($id)
            $keyFields .= " AND CustomerID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from customerinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($id ? (count($result) ? $result[0] : null) : $result), true);
        
        return $result;
    }


    public $detailIdFields = ["CompanyID","DivisionID","DepartmentID","ReceiptID", "ReceiptDetailID"];
	public $embeddedgridFields = [
		"DocumentNumber" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"PaymentID" => [
			"dbType" => "varchar(36)",
			"inputType" => "text"
		],
		"CurrencyID" => [
			"dbType" => "varchar(3)",
			"inputType" => "text"
		],
        "AppliedAmount" => [
            "dbType" => "decimal(19,4)",
            "format" => "{0:n}",
            "inputType" => "text"
        ]
	];
    
    //getting rows for grid
    public function getDetail($id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->embeddedgridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailIdFields as $key){
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
        $keyFields .= " AND ReceiptID='" . $id . "'";
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from edireceiptsdetail " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    public function uploadExcel(){
        $excelImport = new excelImport();
        $user = Session::get("user");
        $correctNamesToEDI = [
            "Transaction Date" => "TransactionDate",
            "TransactionNumber" => "ReceiptID",
            "Vendor ID" => "CustomerID",
            "Vendor Name" => "VendorName",
            "Item ID" => "ItemID",
            "Item Name" => "Description",
            "Quantity" => "OrderQty" ,
            "Unit Price" => "ItemUnitPrice",
            "Total Amount" => "Amount",
            "Currency" => "CurrencyID",
            "Exchange Rate" => "CurrencyExchangeRate"
        ];
        if(isset($_FILES['file'])){
            $rowsWithNames = $excelImport->getDataFromUploadedFile($correctNamesToEDI);

            //            echo json_encode($rowsWithNames, JSON_PRETTY_PRINT);
            //print_r($rowsWithNames);
            foreach($rowsWithNames as $row){
                if(!count(DB::select("select * from edireceiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $row["ReceiptID"]]))){
                    DB::insert("insert into edireceiptsheader (CompanyID, DivisionID, DepartmentID, ReceiptID, TransactionDate, ReceiptTypeID, CustomerID, EDIDirectionTypeID, CurrencyID, CurrencyExchangeRate, Amount) values('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '{$row["ReceiptID"]}', '{$row["TransactionDate"]}', 'CASH', '{$row["CustomerID"]}', 'I', '{$row["CurrencyID"]}', '{$row["CurrencyExchangeRate"]}', '{$row["Amount"]}')", array());
                    DB::insert("insert into edireceiptsdetail (CompanyID, DivisionID, DepartmentID, ReceiptID, DocumentNumber, DetailMemo1, CurrencyID, CurrencyExchangeRate, DetailMemo2, DetailMemo3, AppliedAmount) values('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '{$row["ReceiptID"]}', '{$row["ItemID"]}', '{$row["Description"]}', '{$row["CurrencyID"]}', '{$row["CurrencyExchangeRate"]}', '{$row["OrderQty"]}', '{$row["ItemUnitPrice"]}', '{$row["Amount"]}')", array());
                }
            }

            if(empty($errors) == true) 
                echo "ok";
            else{
                http_response_code(400);
                echo implode("&&", $errors);
            }
        }else{
            http_response_code(400);
            echo "failed";
        }
    }
    
    public $postHeaderFields = [
        "CompanyID",
        "DivisionID",
        "DepartmentID",
        "ReceiptID",
        "ReceiptTypeID",
        "TransactionDate",
        "CustomerID",
        "Amount",
        "CurrencyID",
        "CurrencyExchangeRate"
    ];
    
    public $postDetailFields = [
        "CompanyID",
        "DivisionID",
        "DepartmentID",
        "ReceiptID",
        "AppliedAmount",
        "CurrencyID",
        "CurrencyExchangeRate"
    ];
    
    public function PostSelected(){
        $user = Session::get("user");

        $numbers = explode(",", $_POST["ReceiptIDs"]);
        //FIXME checking on existing records in receiptsheader
        $success = true;
        $receipts = [];

        foreach($numbers as $number){
            $receiptHeader = (array)DB::select("select * from edireceiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $number])[0];
            $receiptDetail = (array)DB::select("select * from edireceiptsdetail WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $number])[0];
            
            $receipts[] = [
                "header" => $receiptHeader,
                "detail" => $receiptDetail
            ];

            //           if($result[0]->SWP_RET_VALUE == -1)
            //  $success = false;
        }

        foreach($receipts as $receipt){
            if(!count(DB::select("select * from receiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $receipt["header"]["ReceiptID"]]))){
                $insertHeaderValues = [];
                foreach($this->postHeaderFields as $key){
                    if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertHeaderValues[] = "'{$receipt["header"][$key]}'";
                }
                $insertDetailValues = [];
                foreach($this->postDetailFields as $key){
                    if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertDetailValues[] = "'{$receipt["detail"][$key]}'";
                }

                
                DB::insert("insert into receiptsheader (" . implode(',', $this->postHeaderFields) . ") values (" . implode(',', $insertHeaderValues) . ")", []);
                DB::insert("insert into receiptsdetail (" . implode(',', $this->postDetailFields) . ") values (" . implode(',', $insertDetailValues) . ")", []);
            }
        }

        echo "ok";
        //        echo json_encode($invoices);
            
        /*        if($success)
                  echo "ok";
                  else {
                  http_response_code(400);
                  echo $result[0]->SWP_RET_VALUE;
                  }*/
    }
    
    public function PostAll(){
        $user = Session::get("user");

        $numbers = DB::select("select ReceiptID from edireceiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]]);
        //FIXME checking on existing records in receiptheader
        $success = true;
        $receipts = [];

        foreach($numbers as $number){
            $receiptHeader = (array)DB::select("select * from edireceiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $number->ReceiptID])[0];
            $receiptDetail = (array)DB::select("select * from edireceiptsdetail WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $number->ReceiptID])[0];
            
            $receipts[] = [
                "header" => $receiptHeader,
                "detail" => $receiptDetail
            ];
        }

       
        foreach($receipts as $receipt){
            if(!count(DB::select("select * from receiptsheader WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND ReceiptID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $receipt["header"]["ReceiptID"]]))){
                $insertHeaderValues = [];
                foreach($this->postHeaderFields as $key){
                    if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertHeaderValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertHeaderValues[] = "'{$receipt["header"][$key]}'";
                }
                $insertDetailValues = [];
                foreach($this->postDetailFields as $key){
                    if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["CompanyID"]}'";
                    else if($key == "DivisionID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else if($key == "CompanyID")
                        $insertDetailValues[] = "'{$user["DivisionID"]}'";
                    else
                        $insertDetailValues[] = "'{$receipt["detail"][$key]}'";
                }

                DB::insert("insert into receiptsheader (" . implode(',', $this->postHeaderFields) . ") values (" . implode(',', $insertHeaderValues) . ")", []);
                usleep(50);
                DB::insert("insert into receiptsdetail (" . implode(',', $this->postDetailFields) . ") values (" . implode(',', $insertDetailValues) . ")", []);
            }
        }
        
        echo json_encode($numbers, JSON_PRETTY_PRINT);
        /*        $result = DB::select('select @SWP_RET_VALUE as SWP_RET_VALUE', array());
                  if($result[0]->SWP_RET_VALUE > -1)
                  echo $result[0]->SWP_RET_VALUE;
                  else {
                  http_response_code(400);
                  echo $result[0]->SWP_RET_VALUE;
                  }*/
    }
    public $columnNames = [
        "ReceiptID" => "Receipt ID",
        "ReceiptTypeID" => "Receipt Type ID",
        "ReceiptClassID" => "Receipt Class ID",
        "EDIDirectionTypeID" => "Direction Type ID",
        "EDIDocumentTypeID" => "Document Type ID",
        "EDIOpen" => "EDIOpen",
        "CheckNumber" => "Check Number",
        "CustomerID" => "Customer ID",
        "TransactionDate" => "Transaction Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "Amount" => "Amount",
        "UnAppliedAmount" => "Un Applied Amount",
        "GLBankAccount" => "GL Bank Account",
        "Status" => "Status",
        "NSF" => "NSF",
        "Notes" => "Notes",
        "CreditAmount" => "Credit Amount",
        "Cleared" => "Cleared",
        "Posted" => "Posted",
        "Reconciled" => "Reconciled",
        "Deposited" => "Deposited",
        "HeaderMemo1" => "Header Memo 1",
        "HeaderMemo2" => "Header Memo 2",
        "HeaderMemo3" => "Header Memo 3",
        "HeaderMemo4" => "Header Memo 4",
        "HeaderMemo5" => "Header Memo 5",
        "HeaderMemo6" => "Header Memo 6",
        "HeaderMemo7" => "Header Memo 7",
        "HeaderMemo8" => "Header Memo 8",
        "HeaderMemo9" => "Header Memo 9",
 		"DocumentNumber" => "Doc Number",
		"PaymentID" => "Doc Date",
        "AppliedAmount" => "Amount",
		"ProjectID" => "ProjectID"
    ];
}?>

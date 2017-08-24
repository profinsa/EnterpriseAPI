<?php
/*
  Name of Page: gridDataSource class

  Method: ancestor for GeneralLedger/* models. It provides data from database

  Date created: Nikita Zaharov, 17.02.2016

  Use: this model used for
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods has own parameters

  Output parameters:
  - methods has own output

  Called from:
  inherited by models/GeneralLedger/*

  Calls:
  sql

  Last Modified: 08.15.2016
  Last Modified by: Nikita Zaharov
*/

class gridDataSource{
    protected $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";

    //Vendors Dialog Chooser
    public function getVendors(){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];

        $customerIdFields = ["CompanyID","DivisionID","DepartmentID","VendorID"];
        foreach($customerIdFields as $key){
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
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT VendorID,VendorTypeID,AccountStatus,VendorName,VendorPhone,VendorLogin,VendorPassword from vendorinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return [
            "title" => "Vendor selecting dialog",
            "choosedColumn" => "VendorID",
            "desc" => [
                "VendorID" => [
                    "title" => "Vendor ID",
                    "inputType" => "text"
                ],
                "VendorTypeID" => [
                    "title" => "Vendor Type",
                    "inputType" => "text"
                ],
                "AccountStatus" => [
                    "title" => "Account Status",
                    "inputType" => "text"
                ],
                "VendorName" => [
                    "title" => "Vendor Name",
                    "inputType" => "text"
                ],
                "VendorPhone" => [
                    "title" => "Vendor Phone",
                    "inputType" => "text"
                ],
                "VendorLogin" => [
                    "title" => "Vendor Login",
                    "inputType" => "text"
                ],
                "VendorPassword" => [
                    "title" => "Vendor Password",
                    "inputType" => "text"
                ],
            ],
            "values" => json_decode(json_encode($result))
        ];
    }
    
    public function getCustomers(){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];

        $customerIdFields = ["CompanyID","DivisionID","DepartmentID","CustomerID"];
        foreach($customerIdFields as $key){
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
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT CustomerID,CustomerTypeID,AccountStatus,CustomerName,CustomerPhone,CustomerLogin,CustomerPassword from customerinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return [
            "title" => "Customer selecting dialog",
            "choosedColumn" => "CustomerID",
            "desc" => [
                "CustomerID" => [
                    "title" => "Customer ID",
                    "inputType" => "text"
                ],
                "CustomerTypeID" => [
                    "title" => "Customer Type",
                    "inputType" => "text"
                ],
                "AccountStatus" => [
                    "title" => "Account Status",
                    "inputType" => "text"
                ],
                "CustomerName" => [
                    "title" => "Customer Name",
                    "inputType" => "text"
                ],
                "CustomerPhone" => [
                    "title" => "Customer Phone",
                    "inputType" => "text"
                ],
                "CustomerLogin" => [
                    "title" => "Customer Login",
                    "inputType" => "text"
                ],
                "CustomerPassword" => [
                    "title" => "Customer Password",
                    "inputType" => "text"
                ],
            ],
            "values" => json_decode(json_encode($result))
        ];
    }

    //Items Dialog Chooser
    public function getItems(){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        $inventoryitemsIdFields = ["CompanyID","DivisionID","DepartmentID","ItemID"];

        foreach($inventoryitemsIdFields as $key){
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
        }
        
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT ItemID,IsActive,ItemTypeID,ItemName,ItemDescription,ItemUPCCode,Price from inventoryitems " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return [
            "title" => "Item selecting dialog",
            "choosedColumn" => "ItemID",
            "desc" => [
                "ItemID" => [
                    "title" => "ID",
                    "inputType" => "text"
                ],
                "IsActive" => [
                    "title" => "Is Active",
                    "inputType" => "checkbox"
                ],
                "ItemTypeID" => [
                    "title" => "Type ID",
                    "inputType" => "text"
                ],
                "ItemName" => [
                    "title" => "Name",
                    "inputType" => "text"
                ],
                "ItemDescription" => [
                    "title" => "Description",
                    "inputType" => "text",
                ],
                "ItemUPCCode" => [
                    "title" => "UPC Code",
                    "inputType" => "text",
                ],
                "Price" => [
                    "title" => "Price",
                    "inputType" => "text",
                    "format" => "{0:n}"
                ]
            ],
            "values" => json_decode(json_encode($result))
        ];
    }


    //getting list of companies work flow types
    public function getCompaniesWorkFlowTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WorkFlowTypeID from companiesworkflowtypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WorkFlowTypeID] = [
                "title" => $value->WorkFlowTypeID,
                "value" => $value->WorkFlowTypeID
            ];
        
        return $res;
    }
    
    //getting list of inventory categories
    public function getInventoryCategories(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ItemCategoryID from InventoryCategories WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ItemCategoryID] = [
                "title" => $value->ItemCategoryID,
                "value" => $value->ItemCategoryID
            ];
        
        return $res;
    }
    
    //getting list of inventory families
    public function getInventoryFamilies(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ItemFamilyID from inventoryfamilies WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ItemFamilyID] = [
                "title" => $value->ItemFamilyID,
                "value" => $value->ItemFamilyID
            ];
        
        return $res;
    }
    
    //getting list of adjustment types
    public function getAdjustmentTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT AdjustmentTypeID from inventoryadjustmenttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->AdjustmentTypeID] = [
                "title" => $value->AdjustmentTypeID,
                "value" => $value->AdjustmentTypeID
            ];
        
        return $res;
    }
    
    //getting list of available receipt classes
    public function getReceiptClasses(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ReceiptClassID from receiptclass WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ReceiptClassID] = [
                "title" => $value->ReceiptClassID,
                "value" => $value->ReceiptClassID
            ];
        
        return $res;
    }

    //getting list of available receipt types
    public function getReceiptTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ReceiptTypeID from receipttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ReceiptTypeID] = [
                "title" => $value->ReceiptTypeID,
                "value" => $value->ReceiptTypeID
            ];
        
        return $res;
    }
    
    //getting list of available expense report types
    public function getExpenseReportTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ExpenseReportType from expensereporttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ExpenseReportType] = [
                "title" => $value->ExpenseReportType,
                "value" => $value->ExpenseReportType
            ];
        
        return $res;
    }
    
    //getting list of available expense report reasons
    public function getExpenseReportReasons(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ExpenseReportReason from expensereportreasons WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ExpenseReportReason] = [
                "title" => $value->ExpenseReportReason,
                "value" => $value->ExpenseReportReason
            ];
        
        return $res;
    }
    
    //getting list of available work order types
    public function getWorkOrderTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WorkOrderTypes from workordertypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WorkOrderTypes] = [
                "title" => $value->WorkOrderTypes,
                "value" => $value->WorkOrderTypes
            ];
        
        return $res;
    }

    //getting list of available work order progress
    public function getWorkOrderProgress(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WorkOrderInProgress from workorderinprogress WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WorkOrderInProgress] = [
                "title" => $value->WorkOrderInProgress,
                "value" => $value->WorkOrderInProgress
            ];
        
        return $res;
    }
    
    //getting list of available work order priority
    public function getWorkOrderPriority(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WorkOrderPriority from workorderpriority WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WorkOrderPriority] = [
                "title" => $value->WorkOrderPriority,
                "value" => $value->WorkOrderPriority
            ];
        
        return $res;
    }
    
    //getting list of available work order status
    public function getWorkOrderStatus(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WorkOrderStatus from workorderstatus WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WorkOrderStatus] = [
                "title" => $value->WorkOrderStatus,
                "value" => $value->WorkOrderStatus
            ];
        
        return $res;
    }

    //getting list of available companies
    public function getCompanies(){
        $result = DB::select('SELECT CompanyID,DivisionID,DepartmentID from companies', array());
        $res = [];
        foreach($result as $key=>$value)
            $res[$value->CompanyID] = [
                "title" => $value->CompanyID,
                "value" => $value->CompanyID
            ];
        
        return $res;
    }    

    //getting list of available divisions of company
    public function getDivisions(){
        $result = DB::select('SELECT CompanyID,DivisionID,DepartmentID from companies', array());
        $res = [];
        foreach($result as $key=>$value)
            $res[$value->DivisionID] = [
                "title" => $value->DivisionID,
                "value" => $value->DivisionID
            ];
        
        return $res;
    }    

    //getting list of available departments of company
    public function getDepartments(){
        $result = DB::select('SELECT CompanyID,DivisionID,DepartmentID from companies', array());
        $res = [];
        foreach($result as $key=>$value)
            $res[$value->DepartmentID] = [
                "title" => $value->DepartmentID,
                "value" => $value->DepartmentID
            ];
        
        return $res;
    }    

    //getting list of available tax groups
    public function getTaxGroups(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT TaxGroupID from taxgroups WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TaxGroupID] = [
                "title" => $value->TaxGroupID,
                "value" => $value->TaxGroupID
            ];
        
        return $res;
    }
    
    //getting list of available credit card types
    public function getCreditCardTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT CreditCardTypeID from creditcardtypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CreditCardTypeID] = [
                "title" => $value->CreditCardTypeID,
                "value" => $value->CreditCardTypeID
            ];
        
        return $res;
    }

    //getting list of available payment methods
    public function getPaymentMethods(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT PaymentMethodID from paymentmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->PaymentMethodID] = [
                "title" => $value->PaymentMethodID,
                "value" => $value->PaymentMethodID
            ];
        
        return $res;
    }
    
    //getting list of available payment types
    public function getPaymentTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT PaymentTypeID from paymenttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->PaymentTypeID] = [
                "title" => $value->PaymentTypeID,
                "value" => $value->PaymentTypeID
            ];
        
        return $res;
    }

    //getting list of available shipment methods
    public function getShipToIDS($args){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ShipToID from customershiptolocations WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CustomerID='" . $args["CustomerID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipToID] = [
                "title" => $value->ShipToID,
                "value" => $value->ShipToID
            ];
        
        return $res;
    }

    //getting list of available shipment methods
    public function getShipForIDS($args){
        $user = Session::get("user");
        $res = [];

        $result = DB::select("SELECT ShipForID from customershipforlocations WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CustomerID='" . $args["CustomerID"] . "' AND ShipToID='" . $args["ShipToID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipForID] = [
                "title" => $value->ShipForID,
                "value" => $value->ShipForID
            ];
        
        return $res;
    }
    
    //getting list of available shipment methods
    public function getShipMethods(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ShipMethodID from shipmentmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipMethodID] = [
                "title" => $value->ShipMethodID,
                "value" => $value->ShipMethodID
            ];
        
        return $res;
    }

    //getting list of available terms
    public function getTerms(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT TermsID from terms WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TermsID] = [
                "title" => $value->TermsID,
                "value" => $value->TermsID
            ];
        
        return $res;
    }

    //getting list of available employees
    public function getPayrollEmployees(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT EmployeeID from payrollemployees WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->EmployeeID] = [
                "title" => $value->EmployeeID,
                "value" => $value->EmployeeID
            ];
        
        return $res;
    }

    //getting list of available warehouses
    public function getWarehouses(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WarehouseID from warehouses WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WarehouseID] = [
                "title" => $value->WarehouseID,
                "value" => $value->WarehouseID
            ];
        
        return $res;
    }

    //getting list of available warehouse bin types
    public function getWarehouseBinTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WarehouseBinTypeID from warehousebintypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WarehouseBinTypeID] = [
                "title" => $value->WarehouseBinTypeID,
                "value" => $value->WarehouseBinTypeID
            ];
        
        return $res;
    }

    //getting list of available warehouse bin zones
    public function getWarehouseBinZones(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WarehouseBinZoneID from warehousebinzones WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WarehouseBinZoneID] = [
                "title" => $value->WarehouseBinZoneID,
                "value" => $value->WarehouseBinZoneID
            ];
        
        return $res;
    }

    //getting list of available warehouse bins
    public function getWarehouseBins(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT WarehouseID,WarehouseBinID from warehousebins WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WarehouseBinID] = [
                "WarehouseID" => $value->WarehouseID,
                "title" => $value->WarehouseBinID,
                "value" => $value->WarehouseBinID
            ];
        
        return $res;
    }

    //getting list of available Accounts Receivable transaction types
    public function getARTransactionTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT TransactionTypeID from artransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TransactionTypeID] = [
                "title" => $value->TransactionTypeID,
                "value" => $value->TransactionTypeID
            ];
        
        return $res;
    }
    
    //getting list of available order types
    public function getOrderTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT OrderTypeID from ordertypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->OrderTypeID] = [
                "title" => $value->OrderTypeID,
                "value" => $value->OrderTypeID
            ];
        
        return $res;
    }
    
    //getting list of available ledger balance types
    public function getLedgerBalanceTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLBalanceType] = [
                "title" => $value->GLBalanceType,
                "value" => $value->GLBalanceType
            ];
        
        return $res;
    }

    //getting list of available ledger budget ids
    public function getLedgerBudgetId(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLBudgetID from ledgerchartofaccountsbudgets WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLBudgetID] = [
                "title" => $value->GLBudgetID,
                "value" => $value->GLBudgetID
            ];
        
        return $res;
    }
    
    //getting list of available ledger account types
    public function getLedgerAccountTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountType] = [
                "title" => $value->GLAccountType,
                "value" => $value->GLAccountType
            ];
        
        return $res;
    }

    //getting list of available transaction accounts
    public function getTransactionAccounts(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountNumber from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber,
                "value" => $value->GLAccountNumber
            ];
        
        return $res;
    }

    //getting list of available project types
    public function getProjectTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ProjectTypeID from projecttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ProjectTypeID] = [
                "title" => $value->ProjectTypeID,
                "value" => $value->ProjectTypeID
            ];
        
        return $res;
    }

    
    //getting list of available projects
    public function getProjects(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ProjectID from projects WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ProjectID] = [
                "title" => $value->ProjectID,
                "value" => $value->ProjectID
            ];
        
        return $res;
    }
    
    //getting list of available contact regions 
    public function getContactRegions(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ContactRegionID,ContactRegionDescription from contactregions WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactRegionID] = [
                "title" => $value->ContactRegionID,
                "value" => $value->ContactRegionID
            ];
        
        return $res;
    }
    
    //getting list of available contact types 
    public function getContactTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ContactType,ContactTypeDescription from contacttype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactType] = [
                "title" => $value->ContactType,
                "value" => $value->ContactType
            ];
        
        return $res;
    }
    
    //getting list of available ledger transaction types 
    public function getLedgerTransactionTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT TransactionTypeID,TransactionTypeDescription from ledgertransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TransactionTypeID] = [
                "title" => $value->TransactionTypeID,
                "value" => $value->TransactionTypeID
            ];
        
        return $res;
    }

    //getting list of available transaction types 
    public function getBankTransactionTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT BankTransactionTypeID,BankTransactionTypeDesc from banktransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->BankTransactionTypeID] = [
                "title" => $value->BankTransactionTypeID,
                "value" => $value->BankTransactionTypeID
            ];
        
        return $res;
    }
    
    //getting list of available account types 
    public function getAccounts(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLAccountNumber,GLAccountName from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber . ", " . $value->GLAccountName,
                "value" => $value->GLAccountNumber
            ];
        return $res;
    }


    //getting list of available exchage rates
    public function getCurrencyExchangeRates(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT CurrencyID,CurrencyType,CurrencyExchangeRate from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CurrencyID] = [
                "title" => $value->CurrencyExchangeRate,
                "CurrencyID" => $value->CurrencyID,
                "value" => $value->CurrencyExchangeRate
            ];
        
        return $res;
    }
    
    //getting list of available currency types
    public function getCurrencyTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT CurrencyID,CurrencyType,CurrencyExchangeRate from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CurrencyID] = [
                "title" => $value->CurrencyID . ", " . $value->CurrencyType,
                "value" => $value->CurrencyID,
                "CurrencyID" => $value->CurrencyID,
                "ExchangeRate" => $value->CurrencyExchangeRate
            ];
        
        return $res;
    }

    //getting rows for grid
    public function getPage($number){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->gridFields as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->idFields as $key){
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

        if(property_exists($this, "gridConditions")){
            if($keyFields != "")
                $keyFields .= " AND " . $this->gridConditions;
            else
                $keyFields = $this->gridConditions;
        }
        
        $result = DB::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = Session::get("user");
        $columns = [];
        $fakeColumns = [];
        foreach($this->editCategories[$type] as $key=>$value){
            if(!key_exists("fake", $value))
               $columns[] = $key;
            else
                $fakeColumns[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $columns[] = $addfield;
            }
        }
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];
        
        $describe = DB::select("describe " . $this->tableName);

        foreach($this->editCategories[$type] as $key=>$value) {
            foreach($describe as $struct) {
                if ($struct->Field == $key) {
                    $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;

                    switch ($struct->Null) {
                        case "NO":
                            $this->editCategories[$type][$key]["required"] = true;
                            break;
                        case "YES":
                            $this->editCategories[$type][$key]["required"] = false;
                            break;
                        default:
                            $this->editCategories[$type][$key]["required"] = false;
                    }
                    break;
                }
            }
        }

        $fresult = [];
        foreach($fakeColumns as $value){
            $fresult[$value] = "";
        }

        $result = $result + $fresult;

        return $result;
    }

    public function dirtyAutoincrementColumn($tableName, $columnName){
        $forDirtyAutoincrement = [
            "orderheader" => [
                //"columns" => "OrderNumber",
                "tables" => ["orderheader", "orderheaderhistory"]
            ],
            "workorderheader" => [
                //"columns" => "OrderNumber",
                "tables" => ["workorderheader", "workorderheaderhistory"]
            ],
            "orderheaderhistory" => [
                //"columns" => "OrderNumber",
                "tables" => ["orderheader", "orderheaderhistory"]
            ],
            "invoiceheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["invoiceheader", "invoiceheaderhistory"]
            ],
            "invoiceheaderhistory" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["invoiceheader", "invoiceheaderhistory"]
            ],
            "receiptsheader" => [
                //"columns" => "ReceipID",
                "tables" => ["receiptsheader", "receiptsheaderhistory"]
            ],
            "purchaseheader" => [
                "tables" => ["purchaseheader", "purchaseheaderhistory"]
            ],
            "purchasecontractheader" => [
                "tables" => ["purchasecontractheader", "purchasecontractheaderhistory"]
            ],
            "paymentsheader" => [
                "tables" => ["paymentsheader", "paymentsheaderhistory"]
            ],
            "ledgertransactions" => [
                "tables" => ["ledgertransactions", "ledgertransactionshistory"]
            ],
            "banktransactions" => [
                "tables" => ["banktransactions"]
            ]
        ];
        $columnMax = 0;
        if(key_exists($this->tableName, $forDirtyAutoincrement)){
            foreach($forDirtyAutoincrement[$this->tableName]["tables"] as $tableName){
                //$columnName = $forDirtyAutoincrement[$this->tableName]["column"];
                $res = DB::select("select $columnName from $tableName");
                foreach($res as $row)
                    if(is_numeric($row->$columnName) && $row->$columnName > $columnMax)
                        $columnMax = $row->$columnName;
            }
        }
        return ++$columnMax;
    }
    
    //getting data for new record
    public function getNewItem($id, $type){            
        $values = [];

        foreach($this->idFields as $value)
            $idDefaults[] = "$value='DEFAULT'";

        $defaultRecord = DB::select("select * from {$this->tableName} WHERE " . implode(" AND ", $idDefaults));
        if(count($defaultRecord))
            $defaultRecord = $defaultRecord[0];
        else
            $defaultRecord = false;
        
        $result = DB::select("describe " . $this->tableName);

        foreach($this->editCategories[$type] as $key=>$value) {
            foreach($result as $struct) {
                if ($struct->Field == $key) {
                    if(!key_exists("defaultOverride", $this->editCategories[$type][$key]) &&
                       !key_exists("dirtyAutoincrement", $this->editCategories[$type][$key])){
                        $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;
                        if($defaultRecord && property_exists($defaultRecord, $key) && $defaultRecord->$key != "")
                            $this->editCategories[$type][$key]["defaultValue"] = $defaultRecord->$key;
                    }
                    switch ($struct->Null) {
                        case "NO":
                            $this->editCategories[$type][$key]["required"] = true;
                            break;
                        case "YES":
                            $this->editCategories[$type][$key]["required"] = false;
                            break;
                        default:
                            $this->editCategories[$type][$key]["required"] = false;
                    }
                    break;
                }
            }
        }

        foreach($this->editCategories[$type] as $key=>$value)
            $values[$key] = key_exists($key, $_GET) ? $_GET[$key] : (key_exists("defaultValue", $value) ? $value["defaultValue"] : "");
        
        return $values;
    } 

    //getting data for grid view form
    public function getItem($id){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return json_decode(json_encode($result), true)[0];
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $update_fields = "";
        $alreadyUsed = [];
        if($category){
            foreach($this->editCategories as $category=>$cvalue){
                foreach($this->editCategories[$category] as $name=>$value){
                    if(key_exists($name, $values) &&  $values[$name] != "" && !key_exists($name, $alreadyUsed)){
                        $alreadyUsed[$name] = true;
                        if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                            $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                        else if(key_exists("formatFunction", $value)){
                            $formatFunction = $value["formatFunction"];
                            $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                        }
                        if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                            $values[$name] = str_replace(",", "", $values[$name]);

                        if($update_fields == "")
                            $update_fields = $name . "='" . $values[$name] . "'";
                        else
                            $update_fields .= "," . $name . "='" . $values[$name] . "'";
                    }
                }
            }
        }else{
            foreach($this->gridFields as $name=>$value){
                if(key_exists($name, $values)){
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "gridFields", $name, $values[$name], true);
                    }
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                        $values[$name] = str_replace(",", "", $values[$name]);

                    if($update_fields == "")
                        $update_fields = $name . "='" . $values[$name] . "'";
                    else
                        $update_fields .= "," . $name . "='" . $values[$name] . "'";
                }
            }
        }

        DB::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    //add row to table
    public function insertItem($values){
        $user = Session::get("user");
        
        $insert_fields = "";
        $insert_values = "";
        $alreadyUsed = [];
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values) && !key_exists($name, $alreadyUsed) && $values[$name] != "" && !key_exists("autogenerated", $value)){
                    if(key_exists("dirtyAutoincrement", $value))
                        $values[$name] = $this->dirtyAutoincrementColumn($this->tableName, $name);
                    $alreadyUsed[$name] = true;
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                    }
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                        $values[$name] = str_replace(",", "", $values[$name]);

                    if($insert_fields == ""){
                        $insert_fields = $name;
                        $insert_values = "'" . $values[$name] . "'";
                    }else{
                        $insert_fields .= "," . $name;
                        $insert_values .= ",'" . $values[$name] . "'";
                    }
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        DB::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }

    //delete row from table
    public function deleteItem($id){
        $user = Session::get("user");
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        DB::delete("DELETE from " . $this->tableName .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    protected $currencyPrecisions = [];
    
    //formatting and getting raw values for currency fields
    public function currencyFormat($values, $fieldContainer, $fieldName, $value, $in){
        $user = Session::get("user");
        if($in)
            return str_replace(",", "", $value);
        else {
            if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts)){
                $desc = false;
                if($fieldContainer == "gridFields"){
                    foreach($this->gridFields as $key=>$_desc)
                        if($key == $fieldName)
                            $desc = $_desc;
                }else if($fieldContainer == "editCategories"){
                    foreach($this->editCategories as $category){
                        foreach($category as $key=>$_desc)
                            if($key == $fieldName)
                                $desc = $_desc;
                    }
                }
                if($desc && !key_exists("currencyField", $desc))
                    $desc["currencyField"] = "CurrencyID";
                if(!$desc || !key_exists($desc["currencyField"], $values)){
                    $result = [(object) []];
                    $result[0]->CurrencyPrecision = 2;
                }else if(key_exists($values[$desc["currencyField"]], $this->currencyPrecisions))
                    $result = $this->currencyPrecisions[$values[$desc["currencyField"]]];
                else 
                    $this->currencyPrecisions[$values[$desc["currencyField"]]] = $result = DB::select("SELECT CurrencyPrecision from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CurrencyID='" . $values[$desc["currencyField"]] . "'" , array());
                //return json_encode($result);
                if($result)
                    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, $result[0]->CurrencyPrecision < 5 ? $result[0]->CurrencyPrecision : 2);
                else
                    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, 2);
            }
        }
        return $value;
    }
}
?>
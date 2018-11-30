<?php
/*
  Name of Page: gridDataSource class

  Method: ancestor for GeneralLedger/* models. It provides data from database

  Date created: Nikita Zaharov, 02.17.2017

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

  Last Modified: 19/11/2018
  Last Modified by: Nikita Zaharov
*/

class gridDataSource{
    public $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";

    //cheking if table in list of shared tables and sharing for this table is enabled
    public function checkTableSharing($tableName){
        $user = Session::get("user");
        $sharedCategories = [
            "ShareEmployees" => [
                "accesspermissions",
                "payrollemployeepayfrequency",
                "payrollemployeepaytype",
                "payrollemployees",
                "payrollemployeesaccrual",
                "payrollemployeesaccrualfrequency",
                "payrollemployeesaccrualtypes",
                "payrollemployeescalendar",
                "payrollemployeescurrentlyon",
                "payrollemployeesdetail",
                "payrollemployeesdetailhistory",
                "payrollemployeesevents",
                "payrollemployeeseventtypes",
                "payrollemployeeshistory",
                "payrollemployeestaskdetail",
                "payrollemployeestaskdetailhistory",
                "payrollemployeestaskheader",
                "payrollemployeestaskheaderhistory",
                "payrollemployeestaskpriority",
                "payrollemployeestasktype",
                "payrollemployeestatus",
                "payrollemployeestatustype",
                "pyrollemployeestimesheetdetail",
                "payrollemployeestimesheetheader",
                "payrollemployeetype"
            ],
            "ShareCustomers" => [
                "customeraccountstatuses",
                "customercomments",
                "customercontactlog",
                "customercontacts",
                "customercreditreferences",
                "customerfinancials",
                "customerhistorytransactions",
                "customerinformation",
                "customeritemcrossreference",
                "customerpricecrossreference",
                "customerreferences",
                "customersatisfaction",
                "customershipforlocations",
                "customershiptolocations",
                "customertransactions",
                "customertypes"
            ],
            "ShareVendors" => [
                "vendoraccountstatuses",
                "vendorcomments",
                "vendorcontacts",
                "vendorfinancials",
                "vendorhistorytransactions",
                "vendorinformation",
                "vendoritemcrossreference",
                "vendorpricecrossreference",
                "vendortransactions",
                "vendortypes"
            ],
            "ShareItems" => [
                "inventoryitems",
                "inventoryitemsdisplaylang",
                "inventoryitemtypes",
                "itemhistorytransactions",
                "itemtransactions"
            ],
            "ShareWarehouses" => [
                "warehousebins",
                "warehousebintypes",
                "warehousebinzones",
                "warehouses",
                "warehousescontacts",
                "warehousetransitdetail",
                "warehousetransitdetailhistory",
                "warehousetransitheader",
                "warehousetransitheaderhistory"
            ]
        ];

        $company = DB::select("SELECT * FROM companies WHERE CompanyID=?", array($user["CompanyID"]))[0];
        
        foreach($sharedCategories as $category=>$tables)
          foreach($tables as $table)
              if($table == strtolower($tableName) && $company->$category)
                  return true;

        return false;
    }
    
    //Vendors Dialog Chooser
    public function getVendors(){
        $user = Session::get("user");
        if($this->checkTableSharing("vendorinformation")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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

        $query = <<<EOF
     Select
      VendorID,
			TermsID,
			CurrencyID ,
			0 As DiscountPers,
			TaxGroupID,
			TaxIDNo As TaxExemptID,
			WarehouseID,
			ShipMethodID As ShipMethodID,
			GLPurchaseAccount As GLPurchaseAccount,
			VendorName as ShippingName,
			VendorAddress1 As ShippingAddress1,
			VendorAddress2 As ShippingAddress2,
			VendorAddress3 As ShippingAddress3,
			VendorCity As ShippingCity,
			VendorState As ShippingState,
			VendorZip As ShippingZip,
			VendorCountry As ShippingCountry
            from VendorInformation
   Where CompanyID = '{$user["CompanyID"]}'
   AND DivisionID = '{$user["DivisionID"]}'
   AND DepartmentID = '{$user["DepartmentID"]}'
EOF;
        //			IFNULL(T.NetDays,0) as NetDays

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
            "values" => json_decode(json_encode($result)),
            "allValues" => json_decode(json_encode( DB::select($query, array())))
        ];
    }
    
    public function getCustomers(){
        $user = Session::get("user");
        if($this->checkTableSharing("customerinformation")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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

        $query = <<<EOF
   Select  CustomerID,
	CustomerInformation.TermsID,
	CustomerShipToID as ShipToID,
	CustomerShipForID as ShipForID,
    CurrencyID,
	TaxGroupID,
	TaxIDNo,
	WarehouseID,
	ShipMethodID,
	EmployeeID ,
	GLSalesAccount,
	CustomerName as ShippingName,
	CustomerAddress1 As ShippingAddress1,
	CustomerAddress2 As ShippingAddress2,
	CustomerAddress3 As ShippingAddress3,
	CustomerCity As ShippingCity,
	CustomerState As ShippingState,
	CustomerZip As ShippingZip,
	CustomerCountry As ShippingCountry,
    AccountStatus,
    CustomerPhone,
    CustomerFax,
    CustomerEmail,
    Attention
   FROM customerinformation
   Where CustomerInformation.CompanyID = '{$user["CompanyID"]}'
   AND CustomerInformation.DivisionID = '{$user["DivisionID"]}'
   AND CustomerInformation.DepartmentID = '{$user["DepartmentID"]}'
EOF;
        /*
	IFNULL(Terms.NetDays,0) As NetDays,
   From CustomerInformation LEFT OUTER JOIN Terms ON (CustomerInformation.CompanyID = Terms.CompanyID
   AND CustomerInformation.DivisionID = Terms.DivisionID
   AND CustomerInformation.DepartmentID = Terms.DepartmentID
   AND CustomerInformation.TermsID = Terms.TermsID)
   then where
   AND CustomerInformation.CustomerID = v_CustomerID
         */

        $allValues = json_decode(json_encode(DB::select($query, array())));
        $company = DB::select("select * from companies WHERE $keyFields")[0];
        foreach($allValues as $rowKey=>$row){
            foreach($row as $columnName=>$value)
                if($columnName == "CurrencyID" && $value == "")
                    $row->$columnName = $company->CurrencyID;
        }
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
            "values" => json_decode(json_encode( DB::select("SELECT CustomerID,CustomerTypeID,AccountStatus,CustomerName,CustomerPhone,CustomerLogin,CustomerPassword from customerinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array()))),
            "allValues" => $allValues
        ];
    }

    public function getLeads(){
        $user = Session::get("user");
        if($this->checkTableSharing("leadinformation")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $keyFields = "";
        $fields = [];

        $leadIdFields = ["CompanyID","DivisionID","DepartmentID","LeadID"];
        foreach($leadIdFields as $key){
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

        return [
            "title" => "Lead selecting dialog",
            "choosedColumn" => "LeadID",
            "desc" => [
                "LeadID" => [
                    "title" => "Lead ID",
                    "inputType" => "text"
                ],
                "LeadTypeID" => [
                    "title" => "Lead Type ID",
                    "inputType" => "text"
                ],
                "LeadLastName" => [
                    "title" => "Last Name",
                    "inputType" => "text"
                ],
                "LeadFirstName" => [
                    "title" => "First Name",
                    "inputType" => "text"
                ],
                "LeadSalutation" => [
                    "title" => "Salutation",
                    "inputType" => "text"
                ],
                "LeadEmail" => [
                    "title" => "Email",
                    "inputType" => "text"
                ],
                "ConvertedToCustomer" => [
                    "title" => "Converted to Customer",
                    "inputType" => "checkbox"
                ],
            ],
            "values" => json_decode(json_encode( DB::select("SELECT LeadID,LeadTypeID,LeadLastName, LeadFirstName, LeadSalutation, LeadEmail, ConvertedToCustomer from leadinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array()))),
            "allValues" => json_decode(json_encode( DB::select("SELECT * from leadinformation " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array())))
        ];
    }

    //Items Dialog Chooser
    public function getItems(){
        $user = Session::get("user");
        if($this->checkTableSharing("inventoryitems")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
            "values" => json_decode(json_encode($result)),
            "allValues" => json_decode(json_encode(DB::select("SELECT * from inventoryitems " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array())))
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
        if($this->checkTableSharing("customershiptolocations")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("customershipforlocations")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("payrollemployees")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("warehouses")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("warehousebintypes")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("warehousebinzones")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
        if($this->checkTableSharing("warehousebins")){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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
    public function getGLControlNumbers(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT GLControlNumber,GLControlNumberName from GLControlNumbers WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLControlNumber] = [
                "title" => $value->GLControlNumber . " - " . $value->GLControlNumberName,
                "value" => $value->GLControlNumber
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
                "title" => $value->GLAccountNumber . " - " . $value->GLAccountName,
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

    //getting list of available countact source ids
    public function getContactSourceIds(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ContactSourceID from ContactSource WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactSourceID] = [
                "title" => $value->ContactSourceID,
                "value" => $value->ContactSourceID
            ];
        
        return $res;
    }

    //getting list of available countact industry ids
    public function getContactIndustryIds(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT ContactIndustryID from ContactIndustry WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactIndustryID] = [
                "title" => $value->ContactIndustryID,
                "value" => $value->ContactIndustryID
            ];
        
        return $res;
    }

    //getting list of available lead ids
    public function getLeadIds(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT LeadID from LeadInformation WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->LeadID] = [
                "title" => $value->LeadID,
                "value" => $value->LeadID
            ];
        
        return $res;
    }
    
    //getting list of available lead types
    public function getLeadTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT LeadTypeID from LeadType WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->LeadTypeID] = [
                "title" => $value->LeadTypeID,
                "value" => $value->LeadTypeID
            ];
        
        return $res;
    }

    //getting list of available comment types
    public function getCommentTypes(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT CommentType from CommentTypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CommentType] = [
                "title" => $value->CommentType,
                "value" => $value->CommentType
            ];
        
        return $res;
    }


    //getting rows for grid
    public function getPage($number){
        $user = Session::get("user");
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
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

    public function lock($id){
        if($this->tableName == "lock")
            return false;
        
        $user = Session::get("user");
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $ts = date("Y-m-d H:i:s");
        $result = DB::update("update {$this->tableName} set LockedBy='{$user["EmployeeID"]}', LockTS='$ts' WHERE $keyFields", array());
    }

    public function unlock($id){
        if($this->tableName == "lock")
            return false;
        
        $user = Session::get("user");
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        try{
            $result = DB::update("update {$this->tableName} set LockedBy=NULL, LockTS=NULL WHERE $keyFields", array());        
        }catch(\Exception $e){
            //    echo $e->getMessage() . "\n";
        }
    }

    public function lockedBy($id){
        if($this->tableName == "lock")
            return false;
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT LockedBy, LockTS from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
        if($result[0]->LockedBy != "")
            return $result[0];
        
        return false;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        if(!$this->lockedBy($id))
            $this->lock($id);
        
        $user = Session::get("user");
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $id = urldecode($id);
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $columns = [];
        $fakeColumns = [];
        if(key_exists("loadFrom", $this->editCategories[$type])){
            $key = $this->editCategories[$type]["loadFrom"]["key"];
            $keyValue = DB::select("SELECT {$this->editCategories[$type]["loadFrom"]["key"]} from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array())[0]->$key;
            $method = $this->editCategories[$type]["loadFrom"]["method"];
            return $this->$method($keyValue);
        }else {
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
        
            $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

            $result = json_decode(json_encode($result), true)[0];
        
            $describe = DB::select("describe " . $this->tableName);

            foreach($this->editCategories[$type] as $key=>$value) {
                foreach($describe as $struct) {
                    if ($struct->Field == $key) {
                        $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;

                        if(!key_exists("required", $this->editCategories[$type][$key])){
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
                        }
                        break;
                    }
                }
            }

            $fresult = [];
            foreach($fakeColumns as $value){
                $fresult[$value] = "";
            }

            $result = array_merge($result,$fresult);

            return $result;
        }
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

        $defaultRecord = DB::select("select * from {$this->tableName} WHERE " . implode(" AND ", $idDefaults), array());
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
                    if(!key_exists("required", $this->editCategories[$type][$key])){
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
                    }
                    break;
                }
            }
        }

        foreach($this->editCategories[$type] as $key=>$value)
            if($key != "loadFrom"){
                $values[$key] = key_exists($key, $_GET) ? $_GET[$key] : (key_exists("defaultValue", $value) ? $value["defaultValue"] : "");
            }
        
        return $values;
    } 

    //getting data for grid view form
    public function getItem($id){
        $user = Session::get("user");
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $id = urldecode($id);
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
        $this->unlock($id);
        
        $user = Session::get("user");
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $id = urldecode($id);
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        if($this->tableName == "companies")
            $keyFields = "CompanyID='{$user["CompanyID"]}'";
        else {
            foreach($this->idFields as $key)
                $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
            if($keyFields != "")
                $keyFields = substr($keyFields, 0, -5);
        }
        
        $update_fields = "";
        $alreadyUsed = [];
        if($category){
            foreach($this->editCategories as $category=>$cvalue){
                if(!key_exists("loadFrom", $this->editCategories[$category])){
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
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        
        $insert_fields = "";
        $insert_values = "";
        $alreadyUsed = [];
        $ret = [];
        foreach($this->editCategories as $category=>$arr){
            if(!key_exists("loadFrom", $this->editCategories[$category])){
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
                        $ret[$name] = $values[$name];
                    }
                }
            }
        }

        $keyFields = [];
        $keyValues = [];
        foreach($this->idFields as $key){
            if(!key_exists($key, $values) && ($key == 'CompanyID' || $key == 'DivisionID' || $key == 'DepartmentID')){
                $keyFields[] = $key;
                $keyValues[] = "'{$user[$key]}'";
                $ret[$key] = $user[$key];
            }
        }
        
        if(count($keyFields)){
            $insert_fields .= ',' . implode(',', $keyFields);
            $insert_values .= ',' . implode(',', $keyValues);
        }
        
        $result = DB::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");

        echo json_encode($ret);
        exit;
    }

    //delete row from table
    public function deleteItem($id){
        $user = Session::get("user");
        $detailTables = [
            "orderheader" => [
                "orderdetail"
            ],
            "invoiceheader" => [
                "invoicedetail"
            ],
            "purchaseheader" => [
                "purchasedetail"
            ],
            "paymentsheader" => [
                "paymentsdetail",
                "paymentchecks"
            ],
            "ledgertransactions" => [
                "ledgertransactionsdetail"
            ],
            "customerinformation" => [
                "customerfinancials"
            ],
            "vendorinformation" => [
                "vendorfinancials"
            ]
        ];
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $id = urldecode($id);
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        DB::delete("DELETE from " . $this->tableName .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
        
        if(key_exists($this->tableName, $detailTables))
            foreach($detailTables[$this->tableName] as $detail)
                DB::delete("DELETE from $detail" .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
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
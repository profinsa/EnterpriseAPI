<?php
/**
 *  This class is collection of all most used Dictionaries in System.
 *
 *  Each dictionary is just a method to get data. In most cases data is just an array of values. In some cases, dictionary
 *  is complicated data with own format.
 *  Dictionaries can be used in two different ways:
 *  - as dataProvider for UI dropdown element. In this case, you need use full name like 'getVendors'
 *  - as part of Dictionary API in EnterpriseUnversalAPI. In this case you need omit 'get' part and use just an 'Vendors'
 *  Most dictionaries has selfexplanary names.
 *
 */
class Dictionaries{
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
			VendorCountry As ShippingCountry,
			VendorName,
			VendorAddress1,
			VendorAddress2,
			VendorAddress3,
			VendorCity,
			VendorState,
			VendorZip,
			VendorCountry
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

        $result = DB::select("SELECT ItemID,IsActive,ItemTypeID,ItemName,ItemDescription, ItemUPCCode,Price from inventoryitems " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

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
            "allValues" => json_decode(json_encode(DB::select("SELECT ItemID,IsActive,ItemTypeID,ItemName,ItemUPCCode, ItemDescription as Description, Price as ItemUnitPrice from inventoryitems " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""), array())))
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
            $res[] = [
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

    //getting list of available EDI Direction types
    public function getEDIDirectionTypeIDs(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT DirectionTypeID as ID from edidirection WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($user["CompanyID"], $user["DivisionID"],$user["DepartmentID"]));

        foreach($result as $key=>$value)
            $res[$value->ID] = [
                "title" => $value->ID,
                "value" => $value->ID
            ];
        
        return $res;
    }

    //getting list of available EDI Document types
    public function getEDIDocumentTypeIDs(){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT EDIDocumentTypeID as ID from edidocumenttypes WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($user["CompanyID"], $user["DivisionID"],$user["DepartmentID"]));

        foreach($result as $key=>$value)
            $res[$value->ID] = [
                "title" => $value->ID,
                "value" => $value->ID
            ];
        
        return $res;
    }

    //helper function for all new dropdown sources
    public function helperForDropdownToGet($tableName, $titleField, $valueField, $options = []){
        $user = Session::get("user");
        $res = [];
        $result = DB::select("SELECT " . (key_exists("selectExpr", $options) ? $options["selectExpr"] : "$titleField, $valueField") . " from $tableName WHERE CompanyID=? AND DivisionID=? AND DepartmentID=?", array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"]));

        foreach($result as $key=>$value)
            $res[$value->$valueField] = [
                "title" => $value->$titleField,
                "value" => $value->$valueField
            ];
        
        return $res;
    }
    
    //getting list of available inventory adjustment types
    public function getInventoryAdjustmentTypes(){
        return $this->helperForDropdownToGet("inventoryadjustmenttypes", "AdjustmentTypeID", "AdjustmentTypeID");
    }

    public function getInventoryItemTypes(){
        return $this->helperForDropdownToGet("inventoryitemtypes", "ItemTypeID", "ItemTypeID");
    }

    public function getInventoryCategories(){
        return $this->helperForDropdownToGet("inventorycategories", "ItemCategoryID", "ItemCategoryID");
    }

    public function getInventoryPricingMethods(){
        return $this->helperForDropdownToGet("inventorypricingmethods", "PricingMethodID", "PricingMethodID");
    }

    public function getCustomerAccountStatuses(){
        return $this->helperForDropdownToGet("customeraccountstatuses", "AccountStatus", "AccountStatus");
    }

    public function getEmployees(){
        return $this->helperForDropdownToGet("payrollemployees", "EmployeeID", "EmployeeID");
    }

    public function getVendorAccountStatuses(){
        return $this->helperForDropdownToGet("vendoraccountstatuses", "AccountStatus", "AccountStatus");
    }

    public function getCustomerTypes(){
        return $this->helperForDropdownToGet("customertypes", "CustomerTypeID", "CustomerTypeID");
    }
    
    public function getVendorTypes(){
        return $this->helperForDropdownToGet("vendortypes", "VendorTypeID", "VendorTypeID");
    }

    public function getInventoryAssemblies(){
        return $this->helperForDropdownToGet("inventoryassemblies", "AssemblyID", "AssemblyID", ["selectExpr" => "DISTINCT AssemblyID"]);
    }
    
    public function getInventoryPricingCodes(){
        return $this->helperForDropdownToGet("inventorypricingcode", "ItemPricingCode", "ItemPricingCode");
    }
    
    public function getPayrollEmployeesTaskTypes(){
        return $this->helperForDropdownToGet("payrollemployeestasktype", "TaskTypeID", "TaskTypeID");
    }

    public function getHelpDocumentTopics(){
        return $this->helperForDropdownToGet("helpdocumenttopic", "TopicID", "TopicID");
    }
    public function getHelpDocumentModules(){
        return $this->helperForDropdownToGet("helpdocumentmodule", "ModuleID", "ModuleID");
    }

    public function getHelpStatuses(){
        return $this->helperForDropdownToGet("helpstatus", "StatusId", "StatusId");
    }

    public function getCurrentCompany(){
        $user = Session::get("user");
        $result = DB::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'");

        return $result;
    }    

    public function getCurrencySymbol(){
        $user = Session::get("user");

        $result =  $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrenycySymbol from {$this->tableName} I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.{$this->idField}=? and I.CompanyID=? and C.CompanyID=? and I.DivisionID=? and C.DivisionID=? and C.DepartmentID=? and C.DepartmentID=?", array($this->id, $user["CompanyID"], $user["CompanyID"], $user["DivisionID"], $user["DivisionID"], $user["DepartmentID"], $user["DepartmentID"]));

        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrenycySymbol : "$"
        ];
    }
}
?>
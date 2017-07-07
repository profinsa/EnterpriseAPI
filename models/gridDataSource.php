<?php
/*
Name of Page: gridDataSource class

Method: ancestor for GeneralLedger/* models. It provides data from database

Date created: Nikita Zaharov, 17.02.2016

Use: this model used for
- for loading data from tables, updating, inserting and deleting

Input parameters:
$capsule: database instance
methods has own parameters

Output parameters:
- methods has own output

Called from:
inherited by models/GeneralLedger/*

Calls:
sql

Last Modified: 16.03.2016
Last Modified by: Nikita Zaharov
*/

class gridDataSource{
    protected $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";

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
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT TaxGroupID from taxgroups WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TaxGroupID] = [
                "title" => $value->TaxGroupID,
                "value" => $value->TaxGroupID
            ];
        
        return $res;
    }
    
    //getting list of available credit card types
    public function getCreditCardTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT CreditCardTypeID from creditcardtypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CreditCardTypeID] = [
                "title" => $value->CreditCardTypeID,
                "value" => $value->CreditCardTypeID
            ];
        
        return $res;
    }

    //getting list of available payment methods
    public function getPaymentMethods(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT PaymentMethodID from paymentmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->PaymentMethodID] = [
                "title" => $value->PaymentMethodID,
                "value" => $value->PaymentMethodID
            ];
        
        return $res;
    }

    //getting list of available shipment methods
    public function getShipToIDS($args){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT ShipToID from customershiptolocations WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CustomerID='" . $args["CustomerID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipToID] = [
                "title" => $value->ShipToID,
                "value" => $value->ShipToID
            ];
        
        return $res;
    }

    //getting list of available shipment methods
    public function getShipForIDS($args){
        $user = $_SESSION["user"];
        $res = [];

        $result = $GLOBALS["DB"]::select("SELECT ShipForID from customershipforlocations WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CustomerID='" . $args["CustomerID"] . "' AND ShipToID='" . $args["ShipToID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipForID] = [
                "title" => $value->ShipForID,
                "value" => $value->ShipForID
            ];
        
        return $res;
    }
    
    //getting list of available shipment methods
    public function getShipMethods(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT ShipMethodID from shipmentmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ShipMethodID] = [
                "title" => $value->ShipMethodID,
                "value" => $value->ShipMethodID
            ];
        
        return $res;
    }

    //getting list of available terms
    public function getTerms(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT TermsID from terms WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TermsID] = [
                "title" => $value->TermsID,
                "value" => $value->TermsID
            ];
        
        return $res;
    }

    //getting list of available employees
    public function getPayrollEmployees(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT EmployeeID from payrollemployees WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->EmployeeID] = [
                "title" => $value->EmployeeID,
                "value" => $value->EmployeeID
            ];
        
        return $res;
    }

    //getting list of available warehouses
    public function getWarehouses(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT WarehouseID from warehouses WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->WarehouseID] = [
                "title" => $value->WarehouseID,
                "value" => $value->WarehouseID
            ];
        
        return $res;
    }
    
    //getting list of available Accounts Receivable transaction types
    public function getARTransactionTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT TransactionTypeID from artransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TransactionTypeID] = [
                "title" => $value->TransactionTypeID,
                "value" => $value->TransactionTypeID
            ];
        
        return $res;
    }

    //getting list of available order types
    public function getNewOrderNumber(){
        $user = $_SESSION["user"];
        $result = $GLOBALS["DB"]::select("SELECT MAX(OrderNumber) from orderheader WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        return $result + 1;
    }

    //getting list of available order types
    public function getOrderTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["DB"]::select("SELECT OrderTypeID from ordertypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->OrderTypeID] = [
                "title" => $value->OrderTypeID,
                "value" => $value->OrderTypeID
            ];
        
        return $res;
    }
    
    //getting list of available ledger balance types
    public function getLedgerBalanceTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLBalanceType from ledgerbalancetype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLBalanceType] = [
                "title" => $value->GLBalanceType,
                "value" => $value->GLBalanceType
            ];
        
        return $res;
    }

    //getting list of available ledger budget ids
    public function getLedgerBudgetId(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLBudgetID from ledgerchartofaccountsbudgets WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLBudgetID] = [
                "title" => $value->GLBudgetID,
                "value" => $value->GLBudgetID
            ];
        
        return $res;
    }
    
    //getting list of available ledger account types
    public function getLedgerAccountTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountType from ledgeraccounttypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountType] = [
                "title" => $value->GLAccountType,
                "value" => $value->GLAccountType
            ];
        
        return $res;
    }

    //getting list of available transaction accounts
    public function getTransactionAccounts(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountNumber from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber,
                "value" => $value->GLAccountNumber
            ];
        
        return $res;
    }

    //getting list of available projects
    public function getProjects(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT ProjectID from projects WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ProjectID] = [
                "title" => $value->ProjectID,
                "value" => $value->ProjectID
            ];
        
        return $res;
    }

    //getting list of available contact regions 
    public function getContactRegions(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT ContactRegionID,ContactRegionDescription from contactregions WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactRegionID] = [
                "title" => $value->ContactRegionID,
                "value" => $value->ContactRegionID
            ];
        
        return $res;
    }
    
    //getting list of available contact types 
    public function getContactTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT ContactType,ContactTypeDescription from contacttype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->ContactType] = [
                "title" => $value->ContactType,
                "value" => $value->ContactType
            ];
        
        return $res;
    }
    
    //getting list of available ledger transaction types 
    public function getLedgerTransactionTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT TransactionTypeID,TransactionTypeDescription from ledgertransactiontypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->TransactionTypeID] = [
                "title" => $value->TransactionTypeID,
                "value" => $value->TransactionTypeID
            ];
        
        return $res;
    }

    //getting list of available transaction types 
    public function getBankTransactionTypes(){
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
    
    //getting list of available transaction types 
    public function getAccounts(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT GLAccountNumber,GLAccountName from ledgerchartofaccounts WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->GLAccountNumber] = [
                "title" => $value->GLAccountNumber . ", " . $value->GLAccountName,
                "value" => $value->GLAccountNumber
            ];
        return $res;
    }
    
    //getting list of available values for GLAccountType 
    public function getCurrencyTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = $GLOBALS["capsule"]::select("SELECT CurrencyID,CurrencyType from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->CurrencyID] = [
                "title" => $value->CurrencyID . ", " . $value->CurrencyType,
                "value" => $value->CurrencyID
            ];

        return $res;
    }

    // test function for getting autoincremented value
    public function getNewIdFieldValue() {
        $user = $_SESSION["user"];

        $key = "MAX(" . $this->idField .")";

        $result = $GLOBALS["capsule"]::select("SELECT " . $key . " from " . $this->tableName . " WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'" , array());

        return $result[0]->$key + 1;
    }
    
    //getting rows for grid
    public function getPage($number){
        $user = $_SESSION["user"];
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
        
        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $fields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //getting data for grid edit form 
    public function getEditItem($id, $type){
        $user = $_SESSION["user"];
        $columns = [];
        foreach($this->editCategories[$type] as $key=>$value){
            $columns[] = $key;
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

        $result = $GLOBALS["DB"]::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        $result = json_decode(json_encode($result), true)[0];

        $describe = $GLOBALS["DB"]::select("describe " . $this->tableName);

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

        return $result;
    }

    //getting data for new record
    public function getNewItem($id, $type){
        $values = [];
        $result = $GLOBALS["DB"]::select("describe " . $this->tableName);

        foreach($this->editCategories[$type] as $key=>$value) {
            foreach($result as $struct) {
                if ($struct->Field == $key) {
                    // check this out Nikki!!! is this right??? i think is it right. if default value is absent in model
                    // we fill this from describe.
                    // echo gettype($this->editCategories[$type][$key]);
                    // echo 
                    if (key_exists("defaultValue", $this->editCategories[$type][$key])) {
                        if (!$this->editCategories[$type][$key]["defaultValue"]) {
                            $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;
                        }
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

        foreach($this->editCategories[$type] as $key=>$value) {
            if (key_exists("defaultValue", $this->editCategories[$type][$key])) {
                $values[$key] = $value["defaultValue"];
            }
        }

        return $values;
    } 
    //getting data for grid view form
    public function getItem($id){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);


        $result = $GLOBALS["capsule"]::select("SELECT " . implode(",", $this->gridFields) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

        return json_decode(json_encode($result), true)[0];
    }

    //updating data of grid item
    public function updateItem($id, $category, $values){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $update_fields = "";
        if($category){
            foreach($this->editCategories as $categ=>$cvalue){
                foreach($this->editCategories[$categ] as $name=>$value){
                    if(key_exists($name, $values) && $values[$name] != ""){
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

        $GLOBALS["capsule"]::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
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
                // $columnName = $forDirtyAutoincrement[$this->tableName]["column"];
                $res = $GLOBALS["capsule"]::select("select $columnName from $tableName");
                foreach($res as $row)
                    if(is_numeric($row->$columnName) && $row->$columnName > $columnMax)
                        $columnMax = $row->$columnName;
            }
        }

        return ++$columnMax;
    }

    //add row to table
    public function insertItem($values){
        $user = $_SESSION["user"];
        
        $insert_fields = "";
        $insert_values = "";
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values) && !key_exists("autogenerated", $value)){
                    if(key_exists("dirtyAutoincrement", $value)) {
                        $values[$name] = $this->dirtyAutoincrementColumn($this->tableName, $name);
                    }

                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime')
                        $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                    else if(key_exists("formatFunction", $value)){
                        $formatFunction = $value["formatFunction"];
                        $values[$name] = $this->$formatFunction($values, "editCategories", $name, $values[$name], true);
                    }
                    else
                    if(key_exists("format", $value) && preg_match('/decimal/', $value["dbType"]))
                            $values[$name] = str_replace(",", "", $values[$name]);

                    if (strlen($values[$name]) == 0){
                        if (preg_match('/decimal/', $value["dbType"])) {
                            if (false !== $pos = strrpos($value["dbType"], ',')) {
                                $presicion = (int)substr($value["dbType"], $pos + 1,1);
                                if ($presicion > 0) {
                                    $values[$name] = "0.0";
                                } else {
                                    $values[$name] = "0";
                                }
                            } {
                                $values[$name] = "0.0";
                            }
                        } else if (preg_match('/int/', $value["dbType"])) {
                            $values[$name] = "0";
                        } else if (preg_match('/float/', $value["dbType"])) {
                            $values[$name] = "0.0";
                        }
                    }

                    if($insert_fields == ""){
                        $insert_fields = $name;
                        $insert_values = "'" . $values[$name] . "'";
                    }else{
                        // simple preventing attribute duplicates in sql statment
                        $pos = strpos($insert_fields, $name);

                        if ($pos !== false) {
                        } else {
                            $insert_fields .= "," . $name;
                            $insert_values .= ",'" . $values[$name] . "'";
                        }
                        // $insert_fields .= "," . $name;
                        // $insert_values .= ",'" . $values[$name] . "'";
                    }
                }
            }
        }

        $insert_fields .= ',CompanyID,DivisionID,DepartmentID';
        $insert_values .= ",'" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "'";
        $GLOBALS["capsule"]::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }

    //delete row from table
    public function deleteItem($id){
        $user = $_SESSION["user"];
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);
        
        $GLOBALS["capsule"]::delete("DELETE from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    protected $currencyPrecisions = [];
    
    //formatting and getting raw values for currency fields
    public function currencyFormat($values, $fieldContainer, $fieldName, $value, $in){
        $user = $_SESSION["user"];
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
                if($desc && key_exists("currencyField", $desc)){
                    if(!key_exists($desc["currencyField"], $values)){
                        $result = [new stdClass()];
                        $result[0]->CurrencyPrecision = 2;
                    }else if(key_exists($values[$desc["currencyField"]], $this->currencyPrecisions))
                        $result = $this->currencyPrecisions[$values[$desc["currencyField"]]];
                    else 
                        $this->currencyPrecisions[$values[$desc["currencyField"]]] = $result = $GLOBALS["capsule"]::select("SELECT CurrencyPrecision from currencytypes WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "' AND CurrencyID='" . $values[$desc["currencyField"]] . "'" , array());
                    if($result)
                        return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, $result[0]->CurrencyPrecision < 5 ? $result[0]->CurrencyPrecision : 2);
                    else
                        return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $numberParts[1]) . '.' . substr($numberParts[2], 0, 2);
                }
            }
        }
        return $value;
    }
}
?>
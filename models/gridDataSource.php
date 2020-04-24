<?php
/*
  Name of Page: gridDataSource class

  Method: ancestor for all gridView models. It provides data from database

  Date created: Nikita Zaharov, 17.02.2017

  Use: this model used for
  - for loading data from tables, updating, inserting and deleting

  Input parameters:
  $db: database instance
  methods has own parameters

  Output parameters:
  - methods has own output

  Called from:
  inherited by all gridView models

  Calls:
  sql

  Last Modified: 17/04/2020
  Last Modified by: Nikita Zaharov
*/

require "./models/mailer.php";
require "./models/dictionaries.php";

/**
 *  It's a base class for all Grid, Detail and Forms models. Most works for Forms does this class.
 *
 *  It response for Forms API: getPage, insertItem, updateItem, getEditItem, deleteItem. Also this class expose basic
 *  common method which used by all Forms like dictionaries, table sharing etc
 *
 */
class gridDataSource extends Dictionaries{
    public $tableName = "";
    //fields to render in grid
    protected $gridFields = [];

    public $idField = "";


    /**
     * Cheking table if in list of shared tables and sharing for this table is enabled 
     *
     */
    public function checkTableSharing($tableName){
        //disabled becase of not implemented for mssql now
        return false;
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

    /**
     * Populates data like Price, WarehouseID etc for choosen ItemID
     * 
     * @param $_POST["ItemID"]
     *
     * @param $_POST["TransactionNumber"]
     *
     * @param *_POST["ParentTable"] Table name for TransactionNumber, like OrderHeader, PurchaseHeader etc
     *
     * @param *_POST["Qty"]
     *
     * @return object with Item fields
     */

    public function Inventory_PopulateItemInfo(){
        $user = Session::get("user");

        DB::statement("call Inventory_PopulateItemInfo('{$user["CompanyID"]}', '{$user["DivisionID"]}', '{$user["DepartmentID"]}', '{$_POST["ItemID"]}', '{$_POST["TransactionNumber"]}', '{$_POST["ParentTable"]}', {$_POST["Qty"]}, @Result, @Description, @ItemUOM, @ItemWeight, @DiscountPercent, @WarehouseID, @WarehouseBinID, @GLAccount, @ItemCost, @ItemPrice, @Serialized, @SerialNumber, @Taxable, @TaxGroupID, @PopulateResult, @SWP_RET_VALUE)", array());
        
        $result = DB::select('select @Result as Result, @Description as Description, @ItemUOM as ItemUOM, @ItemWeight as ItemWeight, @DiscountPercent as DiscountPercent, @WarehouseID as WarehouseID, @WarehouseBinID as WarehouseBinID, @GLAccount as GLAccount, @ItemCost as ItemCost, @ItemPrice as ItemPrice, @ItemPrice as ItemUnitPrice, @Serialized as Serialized, @SerialNumber as SerialNumber, @Taxable as Taxable, @TaxGroupID as TaxGroupID, @PopulateResult as PopulateResult, @SWP_RET_VALUE as SWP_RET_VALUE', array());
        echo json_encode($result[0]);
    //        if($success)
    //      header('Content-Type: application/json');
    //  else
    //      return response("failed", 400)->header('Content-Type', 'text/plain');
    }

    /**
     * Getting any dictionaries at once as REST API
     */
    public function getDictionaries(){
        $list = explode(",", $_GET["list"]);
        $result = [];
        $methodName;
        foreach($list as $name){
            $methodName = "get" . $name;
            $result[$name] = $this->$methodName();
        }

        echo json_encode($result, JSON_PRETTY_PRINT);
    }

    /**
     * It's same as getPage, but for using as REST API
     */
    public function getPageRemote(){
        echo json_encode($this->getPage(""), JSON_PRETTY_PRINT);
    }
    
    /**
     * Getting data for Forms Grid(List)
     *
     * It's used in all Grids for getting rows of data
     *
     * @return array
     */
    public function getPage($number){
        $user = Session::get("user");
        if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
        }
        $keyFields = "";
        $fields = [];
        foreach($this->gridFields as $key=>$value){
            if(!key_exists("fake", $value)){
                $fields[] = $key;
                if(key_exists("addFields", $value)){
                    $_fields = explode(",", $value["addFields"]);
                    foreach($_fields as $addfield)
                        $fields[] = $addfield;
                }
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
            if($GLOBALS["config"]["db_type"] == "sqlsrv")
                $this->gridConditions = preg_replace("/IFNULL/i", "ISNULL", $this->gridConditions);
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

    public function unlockRemote(){
        $this->unlock($_POST["id"]);
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
        $user = Session::get("user");
        if($this->tableName == "lock" || property_exists($this, "withoutSql"))
            return false;
        
        $keyValues = explode("__", $id);
        $keyFields = "";
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $result = DB::select("SELECT LockedBy, LockTS from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
    
        if($result[0]->LockedBy != "" && $GLOBALS["config"]["db_type"] == "mysql"){
            $lastSessionUpdateTime = strtotime(DB::select("select LastSessionUpdateTime from payrollemployees WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $result[0]->LockedBy])[0]->LastSessionUpdateTime);
            $lastSessionUpdateTime += intval(config()["timeoutMinutes"] * 60);
            if($lastSessionUpdateTime < time())
                return false;
            else
                return $result[0];
        }
        
        return false;
    }

    public function getEditItemAllRemote(){
        $result = [];
        foreach($this->editCategories as $key=>$value)
            if(!key_exists("loadFrom", $value))
               $result = array_merge($result, $this->getEditItem($_GET["id"], $key));

        echo json_encode($result, JSON_PRETTY_PRINT);
    }

    /** 
     * It's same as getEditItem but for using as REST API
     */
    public function getEditItemRemote(){
        echo json_encode($this->getEditItem($_POST["id"], $_POST["type"]), JSON_PRETTY_PRINT);
    }

    /**
     * Getting data for Detail form in View or Edit modes
     *
     * @param $id string 
     *
     * @return object
     */
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
        $fresult = [];
        if(key_exists("loadFrom", $this->editCategories[$type])){
            $key = $this->editCategories[$type]["loadFrom"]["key"];
            $keyValue = DB::select("SELECT {$this->editCategories[$type]["loadFrom"]["key"]} from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array())[0]->$key;
            $method = $this->editCategories[$type]["loadFrom"]["method"];
            return $this->$method($keyValue);
        }else {
            foreach($this->editCategories[$type] as $key=>$value){
                if(!key_exists("fake", $value))
                    $columns[] = $key;
                else{
                    if(key_exists("defaultValue", $this->editCategories[$type][$key]))
                           $fresult[$key] = $this->editCategories[$type][$key]["defaultValue"];
                    else
                           $fresult[$key] = "";
                }
                if(key_exists("addFields", $value)){
                    $_fields = explode(",", $value["addFields"]);
                    foreach($_fields as $addfield)
                        $columns[] = $addfield;
                }
            }
        
            $result = DB::select("SELECT " . implode(",", $columns) . " from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());

            $result = json_decode(json_encode($result), true)[0];
        
            $describe = DB::describe($this->tableName);

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

            $result = array_merge($result,$fresult);

            return $result;
        }
    }

    
    /**
     * Method used for getting uniq next numbers for Transaction records like Order, Invoice, Purchase etc
     */
    public function dirtyAutoincrementColumn($tableName, $columnName){
        $user = Session::get("user");
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
            ],
            "ediinvoiceheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["ediinvoiceheader"]
            ],
            "ediorderheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["ediorderheader"]
            ],
            "edipurchaseheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edipurchaseheader"]
            ],
            "edireceiptsheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edireceiptsheader"]
            ],
            "edipaymentsheader" => [
                //"columns" => "InvoiceNumber",
                "tables" => ["edipaymentsheader"]
            ],
            "helpsupportrequest" => [
                "tables" => ["helpsupportrequest"]
            ]
        ];

        $tablesForGetNextEntity = [
            "orderheader" => "NextOrderNumber",
            "workorderheader" => "NextWorkOrderNumber",
            "orderheaderhistory" => "NextOrderNumber",
            "invoiceheader" => "NextInvoiceNumber",
            "invoiceheaderhistory" => "NextInvoiceNumber",
            "receiptsheader" => "NextReceiptNumber",
            "purchaseheader" => "NextPurchaseOrderNumber",
            //    "purchasecontractheader" => [ FIXME for now i don't know where take values for commented tables, will using dirtyautoincrement for them
            "paymentsheader" => "NextVoucherNumber",
            "ledgertransactions" => "NextGLTransNumber",
            "banktransactions" => "NextBankTransactionNumber",
            "inventoryadjustments" => "NextAdjustmentNumber",
            //    "ediinvoiceheader" => [
            //"ediorderheader" => [
            //"edipurchaseheader" => [
            //"edireceiptsheader" => [
            //      "edipaymentsheader" => [
        ];

        $columnMax = 0;
        if(key_exists($this->tableName, $tablesForGetNextEntity)){
            if($GLOBALS["config"]["db_type"] == "mysql"){
                DB::statement("CALL GetNextEntityID2(?, ?, ?, ?, @nextNumber, @ret)", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $tablesForGetNextEntity[$this->tableName]]);
                $columnMax = DB::select("select @nextNumber as nextNumber")[0]->nextNumber;
            }else {
                $tmpTableName = "GetNextEntityIDResult";
                DB::statement("DROP TABLE IF EXISTS $tmpTableName");
                DB::statement("CREATE TABLE $tmpTableName ( nextNumber NVARCHAR(36) )");
                DB::statement("DECLARE @nextNumber NVARCHAR(36);EXEC Enterprise.GetNextEntityID ?, ?, ?, ?, @nextNumber OUTPUT; insert into $tmpTableName (nextNumber) values (@nextNumber)", ['DINOS', 'DEFAULT', 'DEFAULT', 'NextOrderNumber']);
                $columnMax = DB::select("select * from $tmpTableName")[0]->nextNumber;
            }
            //$columnMax = DB::select("select @nextNumber as nextNumber, @ret")[0]->nextNumber;
        }else{
            if(key_exists($this->tableName, $forDirtyAutoincrement)){
                foreach($forDirtyAutoincrement[$this->tableName]["tables"] as $tableName){
                    //$columnName = $forDirtyAutoincrement[$this->tableName]["column"];
                    $res = DB::select("select $columnName from $tableName");
                    foreach($res as $row)
                        if(is_numeric($row->$columnName) && $row->$columnName > $columnMax)
                            $columnMax = $row->$columnName;
                }
            }
            ++$columnMax;
        }

        return $columnMax;
    }

    /**
     * It's same as getNewItemRemote but it gets values for all categories.
     */
    public function getNewItemAllRemote(){
        $result = [];
        foreach($this->editCategories as $key=>$value)
            $result = array_merge($result, $this->getNewItem($_POST["id"], $key));
        echo json_encode($result, JSON_PRETTY_PRINT);
    }

    /** 
     * It's same as getNewItem but for using as REST API
     */
    public function getNewItemRemote(){
        echo json_encode($this->getNewItem($_POST["id"], $_POST["type"]), JSON_PRETTY_PRINT);
    }
   
    /**
     * Getting values for new record and choosen category(like Main) in Detail screens or API
     *
     * This method collects all default values for new record.
     */
    public function getNewItem($id, $type){            
        $user = Session::get("user");
        
        $values = [];

        foreach($this->idFields as $value)
            if($value != "OrderLineNumber")
                $idDefaults[] = "$value='DEFAULT'";

        //loading default values from Company record
        $defaultRecord = DB::select("select * from {$this->tableName} WHERE " . implode(" AND ", $idDefaults), array());

        $defaultCompanyRecord = DB::select("select * from companies WHERE CompanyID=?", [$user["CompanyID"]])[0];
        $defaultCompanyRecord->CurrencyExchangeRate = DB::select("select CurrencyExchangeRate from currencytypes WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND CurrencyID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $defaultCompanyRecord->CurrencyID])[0]->CurrencyExchangeRate;
        $defaultCompanyRecord->TermsID = $defaultCompanyRecord->Terms;
        $defaultCompanyRecord->ShipMethodID = $defaultCompanyRecord->ShippingMethod;
        if($this->tableName == "purchasedetail" || $this->tableName == "paymentsdetail")
            $defaultCompanyRecord->TaxGroupID = $defaultCompanyRecord->DefaultPurchaseTaxGroup;
        if($this->tableName == "orderdetail" || $this->tableName == "invoicedetail")
            $defaultCompanyRecord->TaxGroupID = $defaultCompanyRecord->DefaultSalesTaxGroup;
            
        if(count($defaultRecord))
            $defaultRecord = $defaultRecord[0];
        else
            $defaultRecord = false;
        
        $result = DB::describe($this->tableName);

        foreach($this->editCategories[$type] as $key=>$value) {
            foreach($result as $struct) {
                if($struct->Field == $key) {
                    if(!key_exists("defaultOverride", $this->editCategories[$type][$key]) &&
                       !key_exists("dirtyAutoincrement", $this->editCategories[$type][$key])){
                        /*loading default values in order: 
                          -column default value
                          -default value from default record
                          -default value from company record
                         */
                        $this->editCategories[$type][$key]["defaultValue"] = $struct->Default;
                        if($defaultRecord &&
                           property_exists($defaultRecord, $key) &&
                           $defaultRecord->$key != "" &&
                           $this->editCategories[$type][$key]["inputType"] != "datetime")
                            $this->editCategories[$type][$key]["defaultValue"] = $defaultRecord->$key;
                        
                        if(property_exists($defaultCompanyRecord, $key) && $defaultCompanyRecord->$key != "")
                            $this->editCategories[$type][$key]["defaultValue"] = $defaultCompanyRecord->$key;

                        if($this->editCategories[$type][$key]["inputType"] == "datetime" &&
                           ($this->editCategories[$type][$key]["defaultValue"] == "0000-00-00 00:00:00" ||
                            //                            $this->editCategories[$type][$key]["defaultValue"] == "1983-01-01 13:00:00" ||
                            $this->editCategories[$type][$key]["defaultValue"] == "CURRENT_TIMESTAMP"||
                            $this->editCategories[$type][$key]["defaultValue"] == "now"||
                            $this->editCategories[$type][$key]["defaultValue"] == "NOW"||
                            !$this->editCategories[$type][$key]["defaultValue"]))
                            $this->editCategories[$type][$key]["defaultValue"] = date("m/d/y");
                    }
                    
                    if(key_exists("defaultValueExpression", $this->editCategories[$type][$key])){
                        $this->editCategories[$type][$key]["defaultValue"] = eval($this->editCategories[$type][$key]["defaultValueExpression"]);
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
                $values[$key] = key_exists($key, $_GET) ? $_GET[$key] : (key_exists("defaultValue", $value) ? $value["defaultValue"]  : "");
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

    /**
     * It's same as updateItem but for using as REST API
     */
    public function updateItemRemote(){
        echo json_encode($this->updateItem($_POST["id"], $_POST["type"], $_POST), JSON_PRETTY_PRINT);
    }
    
    /**
     * Updating field of record. Used by Detail forms and in API
     */
    public function updateItem($id, $category, $values){
        $this->unlock($id);
        $pdo = DB::connection()->getPdo();
        
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
                                $update_fields = $name . "=" . $pdo->quote($values[$name]);
                            else
                                $update_fields .= "," . $name . "=" . $pdo->quote($values[$name]);
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
                        $update_fields = $name . "=" . $pdo->quote($values[$name]);
                    else
                        $update_fields .= "," . $name . "=" . $pdo->quote($values[$name]);
                }
            }
        }
        //echo "UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : "") . "\n";

        DB::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    /**
     * It's same as insertItem but for inserting multiple items at time
     */
    public function insertItemsRemote(){
        $postData = file_get_contents("php://input");
        
        $data = json_decode($postData, true);
        $result = "[";
        foreach($data as $item){
            $result .= json_encode($this->insertItemLocal($item)) . ",";
        }
        $result = substr($result, 0, -1);
        $result .= "]";
        echo $result;
    }
    
    /**
     * It's same as insertItem but for using as REST API
     */
    public function insertItemRemote(){
        $this->insertItem($_POST, true);
    }

    /**
     * Inserting record. Used in Detail screens and API
     */
    public function insertItemLocal($values){
        $user = Session::get("user");
        $pdo = DB::connection()->getPdo();

        //disabled becase of not implemented for mssql now
        /*if($this->checkTableSharing($this->tableName)){
            $user["DivisionID"] = "DEFAULT";
            $user["DepartmentID"] = "DEFAULT";
            }*/
        
        $insert_fields = "";
        $insert_values = "";
        $alreadyUsed = [];
        $ret = [];

        //loading default values for fields from ...fields category, it need for fields where many fields is missed on forms like Simple form
        $keyString = [];
        foreach($this->idFields as $key)
            if(!key_exists($key, $values) && ($key == 'CompanyID' || $key == 'DivisionID' || $key == 'DepartmentID'))
                $keyString[] = $user[$key];
        $keyString = implode("__", $keyString);
        
        if(key_exists("...fields", $this->editCategories))
            $defaultValues = $this->getNewItem($keyString, "...fields");
        else
            $defaultValues = [];
        foreach($defaultValues as $key=>$value)
            if(!key_exists($key, $values))
                $values[$key] = $value;
                
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
                            $insert_values = "" . $pdo->quote($values[$name]);
                        }else{
                            $insert_fields .= "," . $name;
                            $insert_values .= "," . $pdo->quote($values[$name]);
                        }
                        $ret[$name] = $values[$name];
                    }else if(key_exists("cloneFrom", $value)){
                        if($insert_fields == ""){
                            $insert_fields = $name;
                            $insert_values = "" . $pdo->quote($values[$value["cloneFrom"]]);
                        }else{
                            $insert_fields .= "," . $name;
                            $insert_values .= "," . $pdo->quote($values[$value["cloneFrom"]]);
                        }
                        $ret[$name] = $values[$value["cloneFrom"]];
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

        return $ret;
    }
    
    /*
     * It's same as insertItemLocal, but used as Internal EnterpriseX HTTP API
     */
    public function insertItem($values, $remoteCall = false){
        echo json_encode($this->insertItemLocal($values));
        if(!$remoteCall)
            exit;
    }

    /**
     * Deleting record. Used in List screens and REST API
     */
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
    
    /**
     * Formatting and getting raw values for currency fields
     *
     * @param $values array
     * @param $fieldContainer array
     * @param $fieldName string
     * @param $value string or number
     */
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

    function prepareForTabRequest($tabName, $keyName, $id){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages[$tabName]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages[$tabName]["detailIdFields"] as $key){
            switch($key){
            case "CompanyID" :
                $keyFields .= "CompanyID='" . $user["CompanyID"] . "' AND ";
                break;
            case "DivisionID" :
                $keyFields .= "DivisionID='" . $user["DivisionID"] . "' AND ";                break;
            case "DepartmentID" :
                $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                break;
            }
            if(!in_array($key, $fields))
                $fields[] = $key;                
        }
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $keyFields .= " AND $keyName='" . $id . "'";

        return [
            "fields" => $fields,
            "keyFields" => $keyFields
        ];
    }

    //Detail Grid methods
    //getting rows DetailGrids
    public function getDetailGridFields($id, $pageName){
        $user = Session::get("user");
        $keyFields = "";
        $fields = [];
        foreach($this->detailPages[$pageName]["gridFields"] as $key=>$value){
            $fields[] = $key;
            if(key_exists("addFields", $value)){
                $_fields = explode(",", $value["addFields"]);
                foreach($_fields as $addfield)
                    $fields[] = $addfield;
            }
        }
        foreach($this->detailPages[$pageName]["detailIdFields"] as $key){
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

        $keyFields .= " AND {$this->detailPages[$pageName]["newKeyField"]}='" . $id . "'";
        $result = DB::select("SELECT " . implode(",", $fields) . " from {$this->detailPages[$pageName]["tableName"]}" . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());


        $result = json_decode(json_encode($result), true);
        
        return $result;
    }

    //procedure for sending document to Customer or Vendor
    function sendPDFToCustomerOrVendor(){
        $user = Session::get("user");
        if($_POST["CVField"] == "CustomerID"){
            $CVEmail = "CustomerEmail";
            $CVName = "Customer";
            $tableName = "customerinformation";
        }else{
            $CVEmail = "VendorEmail";
            $CVName = "Vendor";
            $tableName = "vendorinformation";
        }
        $records = DB::select("select {$CVName}Email from $tableName WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND {$CVName}ID=?", [$user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $_POST["CVValue"]]);
        if(!count($records)){
            http_response_code(400);
            echo "There is no $CVName with that {$_POST["CVField"]}";
        }
        else if($records[0]->$CVEmail == ""){
            http_response_code(400);
            echo "$CVName don't have Email";
        }
        else{
            $document = file_get_contents($_POST["pdfUrl"]);
            file_put_contents("document.pdf", $document);
            $mailer = new mailer();
        
            $mailer->send([
                "subject" => "Document from Enterprise X",
                "body" => "This is autogenerated message from Enterprise X system with a document as attachment",
                "email" => $records[0]->$CVEmail,//must be CustomerEmail
                "attachments" => [
                    "document.pdf" => [
                        "name" => "document.pdf"
                    ]
                ]
            ]);
        }
    }
}
?>
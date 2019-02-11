<?php
/*
  Name of Page: DivisionsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/DivisionsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DivisionsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 11/02/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class gridData extends gridDataSource{
    public $tableName = "divisions";
    public $dashboardTitle ="Divisions";
    public $breadCrumbTitle ="Divisions";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $modes = ["view", "edit", "grid"];
    public $gridFields = [
        "DivisionID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "DivisionName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DivisionDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DivisionPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DivisionID" => [
                "dbType" => "varchar(36)",
                "disabledEdit" => "true",
                "inputType" => "text"
            ],
            "DivisionName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionWebAddress" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DivisionNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "DivisionID" => "Division ID",
        "DivisionName" => "Division Name",
        "DivisionDescription" => "Division Description",
        "DivisionPhone" => "Division Phone",
        "DivisionAddress1" => "Division Address 1",
        "DivisionAddress2" => "Division Address 2",
        "DivisionCity" => "Division City",
        "DivisionState" => "Division State",
        "DivisionZip" => "Division Zip",
        "DivisionCountry" => "Division Country",
        "DivisionFax" => "Division Fax",
        "DivisionEmail" => "Division Email",
        "DivisionWebAddress" => "Division Web Address",
        "DivisionNotes" => "Division Notes"
    ];
    
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

        $resfilter = [];
        foreach($result as $value)
            $resfilter[$value->DivisionID] = $value;
        $result = [];
        
        foreach($resfilter as $key=>$value)
            $result[] = $value;

        $result = json_decode(json_encode($result), true);
        
        return $result;
    }
    
    public function CreateDivision(){
        $user = Session::get("user");
        
        $DivisionID = $_POST["DivisionID"];
        $pdo = DB::connection()->getPdo();
        $result = DB::select("select * FROM Divisions WHERE CompanyID='{$user["CompanyID"]}' AND DivisionID='$DivisionID'", array());
        if(count($result)){
            http_response_code(400);
            echo "Division Already Exists";
            return;
        }
                
        $result = DB::select("show tables", array());
        $databaseName = "Tables_in_" . $GLOBALS["config"]["db_base"];
        foreach($result as $key=>$row){
            if($row->$databaseName != "activeemployee" &&
               $row->$databaseName != "audittrail" &&
               $row->$databaseName != "translation" &&
               $row->$databaseName != "translations" &&
               $row->$databaseName != "dtproperties" &&
               $row->$databaseName != "gl detail by date" &&
               $row->$databaseName != "gl details" &&
               $row->$databaseName != "customerhistorytransactions" &&
               $row->$databaseName != "customertransactions" &&
               $row->$databaseName != "itemhistorytransactions" &&
               $row->$databaseName != "itemtransactions" &&
               $row->$databaseName != "jointpaymentsdetail" &&
               $row->$databaseName != "jointpaymentsheader" &&
               $row->$databaseName != "payrollcommision" &&
               $row->$databaseName != "projecthistorytransactions" &&
               $row->$databaseName != "projecttransactions" &&
               $row->$databaseName != "vendorhistorytransactions" &&
               $row->$databaseName != "vendortransactions" &&
               !preg_match("/history$/", $row->$databaseName) &&
               !preg_match("/^audit/", $row->$databaseName) &&
               !preg_match("/^report/", $row->$databaseName) &&
               !preg_match("/report$/", $row->$databaseName))
            $tables[] = $row->$databaseName;
        }

        foreach($tables as $tableName){
            $desc = DB::select("describe $tableName", array());
            $keys = 0;
            foreach($desc as $column)
                if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
                    $keys++;
            if($keys == 3)
                $tablesColumns[$tableName] = $desc;
            // else
            //  return response("Wrong table $tableName in database", 400)->header('Content-Type', 'text/plain');
        }

        $response = "";
        foreach($tablesColumns as $tableName=>$desc){
            $pdo = DB::connection()->getPdo();
            $data = DB::select("select * from $tableName WHERE CompanyID='{$user["CompanyID"]}' AND DivisionID='{$user["DivisionID"]}'", array());
            if(count($data) && property_exists($data[0], "CompanyID") && property_exists($data[0], "DivisionID") && property_exists($data[0], "DepartmentID")){
                $columns = [];
                foreach($data[0] as $key=>$column)
                    $columns[] = $key;
                if($tableName != "ledgerstoredchartofaccounts"){
                    $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                    foreach($data as $row){
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "DivisionID")
                                $value = $DivisionID;

                            if($value == "" &&
                               $key != "CustomerID"&&
                               $key != "CustomerItemID"&&
                               $key != "ContactID"&&
                               $key != "ContactLogID"&&
                               $key != "InvoiceNumber"&&
                               $key != "OrderNumber"&&
                               $key != "EmployeeID"&&
                               $key != "ShipToID"&&
                               $key != "TaxBracket"&&
                               $key != "ReceiptID"&&
                               $key != "PurchaseNumber")
                                $query .= "NULL,";
                            else
                                $query .= ($pdo->quote($value) == "'0000-00-00 00:00:00'" ? "NOW()" : $pdo->quote($value)) . ",";
                        }
                        $query = substr($query, 0, -1);
                        $query .= "),";
                    }
                    $query = substr($query, 0, -1);
                    try {
                        DB::insert($query, array());
                    } catch (\Illuminate\Database\QueryException $ex) {
                        //echo 'Exeception: ',  $ex->getMessage(), "\n";
                    } //              $response .= $query;
                }else{
                    foreach($data as $row){
                        $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "DivisionID")
                                $value = $DivisionID;

                            if($value == "" &&
                               $key != "CustomerID"&&
                               $key != "CustomerItemID"&&
                               $key != "ContactID"&&
                               $key != "ContactLogID"&&
                               $key != "InvoiceNumber"&&
                               $key != "OrderNumber"&&
                               $key != "EmployeeID"&&
                               $key != "ShipToID"&&
                               $key != "Industry"&& 
                               $key != "ChartType"&&
                               $key != "PurchaseNumber")
                                $query .= "NULL,";
                            else
                                $query .= $pdo->quote($value) . ",";
                        }
                        $query = substr($query, 0, -1);
                        $query .= ")";
                        try {
                            DB::insert($query, array());
                        } catch (\Illuminate\Database\QueryException $ex) {
                            //                            echo 'Exeception: ',  $ex->getMessage(), "\n";
                        } //              $response .= $query;
                    }
                }
            }
        }

        echo "New Division Successfully Created!\nNew Divisions are a seperate business entity, please logout and log back into the new company to begin using it";
    }
}
?>

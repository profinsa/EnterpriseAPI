<?php
/*
  Name of Page: DepartmentsList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/DepartmentsList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\DepartmentsList.php
   
  Calls:
  MySql Database
   
  Last Modified: 28/12/2019
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";

class DepartmentsList extends gridDataSource{
    public $tableName = "departments";
    public $dashboardTitle ="Departments";
    public $breadCrumbTitle ="Departments";
    public $idField ="undefined";
    public $idFields = ["CompanyID","DivisionID","DepartmentID"];
    public $modes = ["edit", "grid"];
    public $gridFields = [
        "DepartmentID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "DepartmentName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DepartmentDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "DepartmentPhone" => [
            "dbType" => "varchar(30)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "DepartmentID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disabledEdit" => "true"
            ],
            "DepartmentName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentAddress1" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentAddress2" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentCity" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentState" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentZip" => [
                "dbType" => "varchar(10)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentCountry" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentPhone" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentFax" => [
                "dbType" => "varchar(30)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentEmail" => [
                "dbType" => "varchar(60)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentWebAddress" => [
                "dbType" => "varchar(80)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DepartmentNotes" => [
                "dbType" => "varchar(255)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    
    public $columnNames = [
        "DepartmentID" => "Department ID",
        "DepartmentName" => "Department Name",
        "DepartmentDescription" => "Department Description",
        "DepartmentPhone" => "Department Phone",
        "DepartmentAddress1" => "Department Address 1",
        "DepartmentAddress2" => "Department Address 2",
        "DepartmentCity" => "Department City",
        "DepartmentState" => "Department State",
        "DepartmentZip" => "Department Zip",
        "DepartmentCountry" => "Department Country",
        "DepartmentFax" => "Department Fax",
        "DepartmentEmail" => "Department Email",
        "DepartmentWebAddress" => "Department Web Address",
        "DepartmentNotes" => "Department Notes"
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
                //            case "DepartmentID" :
                // $keyFields .= "DepartmentID='" . $user["DepartmentID"] . "' AND ";
                //break;
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
    
    public function CreateDepartment(){
        $user = Session::get("user");
        
        $DepartmentID = $_POST["DepartmentID"];
        $pdo = DB::connection()->getPdo();
        $result = DB::select("select * FROM Departments WHERE CompanyID='{$user["CompanyID"]}' AND DivisionID='{$user["DivisionID"]}' AND DepartmentID='$DepartmentID'", array());
        if(count($result)){
            http_response_code(400);
            echo "Department Already Exists";
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
            $data = DB::select("select * from $tableName WHERE CompanyID='{$user["CompanyID"]}' AND DivisionID='{$user["DivisionID"]}' AND DepartmentID='{$user["DepartmentID"]}'", array());
            if(count($data) && property_exists($data[0], "CompanyID") && property_exists($data[0], "DivisionID") && property_exists($data[0], "DepartmentID")){
                $columns = [];
                foreach($data[0] as $key=>$column)
                    $columns[] = $key;
                if($tableName != "ledgerstoredchartofaccounts"){
                    $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                    foreach($data as $row){
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "DepartmentID")
                                $value = $DepartmentID;

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
                        //http_response_code(500);
                        //echo 'Exception: ',  $ex->getMessage(), "\n";
                    } //              $response .= $query;
                }else{
                    foreach($data as $row){
                        $query = "INSERT INTO $tableName (" . implode(",", $columns) . ") VALUES";
                        $query .= "(";
                        foreach($row as $key=>$value){
                            if($key == "DepartmentID")
                                $value = $DepartmentID;

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
                            //http_response_code(500);
                            //echo 'Exeception: ',  $ex->getMessage(), "\n";
                        } //              $response .= $query;
                    }
                }
            }
        }

        echo "New Department Successfully Created!\nNew Departments are a seperate business entity, please logout and log back into the new company to begin using it";
    }
}
?>

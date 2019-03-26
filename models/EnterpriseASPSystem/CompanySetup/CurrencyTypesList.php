<?php
/*
  Name of Page: CurrencyTypesList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017 Nikita Zaharov
   
  Use: this model used by views/CurrencyTypesList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\CurrencyTypesList.php
   
  Calls:
  MySql Database
   
  Last Modified: 18/02/2019
  Last Modified by: Nikita Zaharov
*/
require "./models/gridDataSource.php";

class gridData extends gridDataSource{
    public $tableName = "currencytypes";
    public $dashboardTitle ="Currencies";
    public $breadCrumbTitle ="Currencies";
    public $idField ="CurrencyID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","CurrencyID"];
    public $gridFields = [
        "CurrencyID" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "CurrencyType" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "CurrenycySymbol" => [
            "dbType" => "varchar(3)",
            "inputType" => "text"
        ],
        "CurrencyExchangeRate" => [
            "dbType" => "float",
            "inputType" => "text"
        ],
        "CurrencyRateLastUpdate" => [
            "dbType" => "datetime",
            "format" => "{0:d}",
            "inputType" => "datetime"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "disabledEdit" => "true",
                "defaultValue" => ""
            ],
            "CurrencyType" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrenycySymbol" => [
                "dbType" => "varchar(3)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "CurrencyRateLastUpdate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyPrecision" => [
                "dbType" => "int(11)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MajorUnits" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "MinorUnits" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ]
        ]
    ];
    public $columnNames = [
        "CurrencyID" => "Currency ID",
        "CurrencyType" => "Currency Type",
        "CurrenycySymbol" => "Currenycy Symbol",
        "CurrencyExchangeRate" => "Exchange Rate",
        "CurrencyRateLastUpdate" => "Rate Last Updated",
        "CurrencyPrecision" => "Currency Precision",
        "MajorUnits" => "Major Units",
        "MinorUnits" => "Minor Units"
    ];
    public function updateItem($id, $category, $values){
        $user = Session::get("user");
        $id = urldecode($id);
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        $insertKeyFields = [];
        $insertKeyValues = [];
        foreach($this->idFields as $key){
            if(!key_exists($key, $values) && ($key == 'CompanyID' || $key == 'DivisionID' || $key == 'DepartmentID')){
                $insertKeyFields[] = $key;
                $insertKeyValues[] = "'{$user[$key]}'";
            }
        }
        $update_fields = "";
        $alreadyUsed = [];
        $insert_values_history = [];
        $updateTime = date("Y-m-d H:i:s", time());
        if($category){
            foreach($this->editCategories as $category=>$cvalue){
                foreach($this->editCategories[$category] as $name=>$value){
                    if(key_exists($name, $values) &&  $values[$name] != "" && !key_exists($name, $alreadyUsed)){
                        $alreadyUsed[$name] = true;
                        if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime') {
                            if ($name == "CurrencyRateLastUpdate") {
                                $values[$name] = $updateTime;
                            } else {
                                $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                            }
                        }
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

                            if (($name == "CurrencyID") || ($name == "CurrencyExchangeRate")  || ($name == "CurrencyRateLastUpdate")) {
                            $insert_values_history[$name] = $values[$name];
                        }
                    }
                }
            }
        }else{
            foreach($this->gridFields as $name=>$value){
                if(key_exists($name, $values)){
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime') {
                        if ($name == "CurrencyRateLastUpdate") {
                            $values[$name] = $updateTime;
                        } else {
                            $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                        }
                    }
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

                    if (($name == "CurrencyID") || ($name == "CurrencyExchangeRate")  || ($name == "CurrencyRateLastUpdate")) {
                        $insert_values_history[$name] = $values[$name];
                    }
                }
            }
        }

        $oldItem = DB::select("SELECT CurrencyExchangeRate from " . $this->tableName . ( $keyFields != "" ? " WHERE ". $keyFields : ""), array());
        $oldExchangeRate = json_decode(json_encode($oldItem), true)[0]["CurrencyExchangeRate"];

        DB::insert("INSERT INTO currencytypeshistory (CurrencyID,CurrencyExchangeRate,CurrencyIDDateTime," . implode(',', $insertKeyFields) . ") values('" . $insert_values_history["CurrencyID"] . "','" . $oldExchangeRate . "','" . $updateTime . "'," . implode(',', $insertKeyValues) . ")");
        DB::update("UPDATE " . $this->tableName . " set " . $update_fields .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }

    //add row to table
    public function insertItem($values){
        $user = Session::get("user");
        
        $insert_fields = "";
        $insert_values = "";
        $insert_values_history = [];
        $alreadyUsed = [];
        $updateTime = date("Y-m-d H:i:s", time());
        foreach($this->editCategories as $category=>$arr){
            foreach($this->editCategories[$category] as $name=>$value){
                if(key_exists($name, $values) && !key_exists($name, $alreadyUsed) && $values[$name] != "" && !key_exists("autogenerated", $value)){
                    if(key_exists("dirtyAutoincrement", $value))
                        $values[$name] = $this->dirtyAutoincrementColumn($this->tableName, $name);
                    $alreadyUsed[$name] = true;
                    if($value["inputType"] == 'timestamp' || $value["inputType"] == 'datetime') {
                        if ($name == "CurrencyRateLastUpdate") {
                            $values[$name] = $updateTime;
                        } else {
                            $values[$name] = date("Y-m-d H:i:s", strtotime($values[$name]));
                        }
                    }
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
                    
                    if (($name == "CurrencyID") || ($name == "CurrencyExchangeRate")  || ($name == "CurrencyRateLastUpdate")) {
                        $insert_values_history[$name] = $values[$name];
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
            }
        }
        
        if(count($keyFields)){
            $insert_fields .= ',' . implode(',', $keyFields);
            $insert_values .= ',' . implode(',', $keyValues);
        }

        $historyResult = DB::insert("INSERT INTO currencytypeshistory (CurrencyID,CurrencyExchangeRate,CurrencyIDDateTime," . implode(',', $keyFields) . ") values('" . $insert_values_history["CurrencyID"] . "','" . $insert_values_history["CurrencyExchangeRate"] . "','" . $updateTime . "'," . implode(',', $keyValues) . ")");
        $result = DB::insert("INSERT INTO " . $this->tableName . "(" . $insert_fields . ") values(" . $insert_values .")");
    }

    //delete row from table
    public function deleteItem($id){
        $user = Session::get("user");
        $id = urldecode($id);
        $keyValues = explode("__", $id);
        $keyFields = "";
        $fcount = 0;
        foreach($this->idFields as $key)
            $keyFields .= $key . "='" . array_shift($keyValues) . "' AND ";
        if($keyFields != "")
            $keyFields = substr($keyFields, 0, -5);

        DB::delete("DELETE from " . $this->tableName .   ( $keyFields != "" ? " WHERE ". $keyFields : ""));
        DB::delete("DELETE from currencytypeshistory " .  ( $keyFields != "" ? " WHERE ". $keyFields : ""));
    }
}
?>

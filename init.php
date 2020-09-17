<?php
set_include_path(get_include_path() . PATH_SEPARATOR . __DIR__);
    
session_name("EnterpriseX");
session_start([
    "cookie_lifetime" => 30
]);
if(key_exists("configName", $GLOBALS)){
    $configName = $GLOBALS["configName"];
    require $configName . '.php';
    $_SESSION["configName"] = $configName;
}else if((key_exists("config", $_GET) && ($configName = $_GET["config"]) != 'default') ||
   (key_exists("configName", $_SESSION) && ($configName = $_SESSION["configName"]) != 'default') && (!key_exists("page", $_GET) || ($_GET["page"] != 'ByPassLogin' && $_GET["page"] != 'login'))){
    require $configName . '.php';
    $_SESSION["configName"] = $configName;
}else{
    $_SESSION["configName"] = 'default';
    require 'common.php';
}

session_write_close();
session_name("EnterpriseX");
session_start([
    "cookie_lifetime" => (intval((config()["timeoutMinutes"])) + intval(config()["warningMinutes"]))* 60
]);

$_SESSION["DBQueries"] = [];
$_SESSION["cachedQueries"] = [];
require '_vendor/autoload.php';

use Illuminate\Database\Capsule\Manager as Capsule;

$GLOBALS["capsule"] = $GLOBALS["DB"] = new Capsule;

$config = $GLOBALS["config"] = config();
//class for emulating global DB class from laravel
class DB{
    public static function describe($tableName){
        if($GLOBALS["config"]["db_type"] == "mysql")
            return  DB::select("describe " . $tableName);
        else{
            $results = $GLOBALS["DB"]::select("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tableName'", array());
            $columns = [];
            foreach($results as $columnDef){
                $column = new stdClass();
                $column->Field = $columnDef->COLUMN_NAME;
                $column->Type = $columnDef->DATA_TYPE;
                $column->Null = $columnDef->IS_NULLABLE;
                $column->Default = $columnDef->COLUMN_DEFAULT;
                $columns[] = $column;
            }
            return $columns;
        }            
    }

    public static function quote($value){
        $pdo = DB::connection()->getPdo();
        return $pdo->quote($value);
    }
    
    public static function statement($query, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
            //$GLOBALS["DB"]::update("update payrollemployees set LastSessionUpdateTime=" . ($GLOBALS["config"]["db_type"] == "mysql" ? "NOW()" : "CURRENT_TIMESTAMP") . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$_SESSION["user"]["CompanyID"], $_SESSION["user"]["DivisionID"], $_SESSION["user"]["DepartmentID"], $_SESSION["user"]["EmployeeID"]]);
        }
        return $GLOBALS["DB"]::statement($query, $args ? $args : array());
    }
    
    public static function select($query, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
			if(!key_exists("lastDBAccess", $_SESSION))
                $_SESSION["lastDBAccess"] = time();
            if(($_SESSION["lastDBAccess"] + 5) < time() && $GLOBALS["config"]["db_type"] == "mysql"){
                $_SESSION["lastDBAccess"] = time();
                $GLOBALS["DB"]::update("update payrollemployees set LastSessionUpdateTime=" . ($GLOBALS["config"]["db_type"] == "mysql" ? "NOW()" : "CURRENT_TIMESTAMP") . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$_SESSION["user"]["CompanyID"], $_SESSION["user"]["DivisionID"], $_SESSION["user"]["DepartmentID"], $_SESSION["user"]["EmployeeID"]]);
            }                
        }
        $args = $args ? $args : array();
        $queryKey = $query . implode("!", $args);
        $result = [];
        if($GLOBALS["config"]["db_type"] == "sqlsrv"){
            $query = preg_replace("/IFNULL/i", "ISNULL", $query);
            $query = preg_replace("/now\(\)/i", "CURRENT_TIMESTAMP", $query);
        }
        if(!key_exists("configName", $GLOBALS)&&
           key_exists($queryKey, $_SESSION["DBQueries"]) &&
           $_SESSION["DBQueries"][$queryKey]["timestamp"] < time() + 3){
            $result = $_SESSION["DBQueries"][$queryKey]["result"];
            $_SESSION["cachedQueries"][$queryKey] = "from cache";
        } else {
            $records = $GLOBALS["DB"]::select($query, $args);
            if($GLOBALS["config"]["db_type"] == "sqlsrv"){
                //parsing values for SQL Server windows PDO driver which returns all values as strings;
                if(preg_match('/^select.*from\s([\w\s]+)$/i', $query, $matches)){
                    $tableName = $matches[1];
                    $types = [
                        "bit" => "int",
                        "int" => "int",
                        "bigint" => "int",
                        "tinyint" => "int",
                        "smallint" => "int",
                        "nvarchar" => "string",
                        "varchar" => "string",
                        "text" => "string",
                        "datetime" => "string",
                        "nchar" => "string",
                        "char" => "string",
                        "money" => "float",
                        "real" => "float",
                        "numeric" => "float",
                        "float" => "float"
                    ];
                    $desc = DB::describe($tableName);
                    $result = [];
                    //echo json_encode($desc, JSON_PRETTY_PRINT);
                    foreach($records as $record){
                        $parsedRecord = new stdClass();
                        
                        foreach($desc as $column){
                            $columnName = $column->Field;
                            if($record->$columnName == null)
                                $parsedRecord->$columnName = null;
                            else{
                                switch($types[$column->Type]){
                                case "int" :
                                    $parsedRecord->$columnName = intval("" . $record->$columnName);
                                    break;
                                case "float" :
                                    $parsedRecord->$columnName = floatval("" . $record->$columnName);
                                    break;
                                case "string" :
                                    $parsedRecord->$columnName = "" . $record->$columnName;
                                    break;
                                }
                            }
                        }
                        $result[] = $parsedRecord;
                    }
                }else
                    $result = $records;
            }else
                $result = $records;

            $_SESSION["DBQueries"][$queryKey] = [
                "timestamp" => time(),
                "args" => $args,
                "result" => $result 
            ];
            $_SESSION["cachedQueries"][$queryKey] = "from db";
        }
        //file_put_contents("sqllog", json_encode($_SESSION["cachedQueries"], JSON_PRETTY_PRINT));
        //        file_put_contents("sqllog", $query . "\n", FILE_APPEND);
        return $result;
    }
    
    public static function update($query, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
            //$GLOBALS["DB"]::update("update payrollemployees set LastSessionUpdateTime=" . ($GLOBALS["config"]["db_type"] == "mysql" ? "NOW()" : "CURRENT_TIMESTAMP") . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$_SESSION["user"]["CompanyID"], $_SESSION["user"]["DivisionID"], $_SESSION["user"]["DepartmentID"], $_SESSION["user"]["EmployeeID"]]);
        }
        return $GLOBALS["DB"]::update($query, $args ? $args : array());
    }
    
    public static function insert($query, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
            //            $GLOBALS["DB"]::update("update payrollemployees set LastSessionUpdateTime=" . ($GLOBALS["config"]["db_type"] == "mysql" ? "NOW()" : "CURRENT_TIMESTAMP") . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$_SESSION["user"]["CompanyID"], $_SESSION["user"]["DivisionID"], $_SESSION["user"]["DepartmentID"], $_SESSION["user"]["EmployeeID"]]);
        }
        return $GLOBALS["DB"]::insert($query, $args ? $args : array());
    }
    
    public static function delete($query, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
            // $GLOBALS["DB"]::update("update payrollemployees set LastSessionUpdateTime=" . ($GLOBALS["config"]["db_type"] == "mysql" ? "NOW()" : "CURRENT_TIMESTAMP") . " WHERE CompanyID=? AND DivisionID=? AND DepartmentID=? AND EmployeeID=?", [$_SESSION["user"]["CompanyID"], $_SESSION["user"]["DivisionID"], $_SESSION["user"]["DepartmentID"], $_SESSION["user"]["EmployeeID"]]);
        }
        return $GLOBALS["DB"]::delete($query, $args ? $args : array());
    }
    
    public static function connection($query = false, $args = false){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"])){
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
        }
        return $GLOBALS["DB"]::connection();
    }
    
    public static function getDatabaseName(){
        if(key_exists("user", $_SESSION) && key_exists("EmployeeID", $_SESSION["user"]))
            if($GLOBALS["config"]["db_type"] == "mysql")
                $GLOBALS["DB"]::statement("set @EmployeeID='{$_SESSION["user"]["EmployeeID"]}'");
        return $GLOBALS["DB"]::getDatabaseName();
    }

    public static function getTables(){
        $ignoreTables = [
            "activeemployee",
            "translation",
            "translations",
            "dtproperties",
            "gl detail by date",
            "gl details",
            "customerhistorytransactions",
            "customertransactions",
            "itemhistorytransactions",
            "itemtransactions",
            "jointpaymentsdetail",
            "jointpaymentsheader",
            "payrollcommision",
            "projecthistorytransactions",
            "projecttransactions",
            "vendorhistorytransactions",
            "vendortransactions"
        ];
            
        if($GLOBALS["config"]["db_type"] == "mysql"){
            $pdo = DB::connection()->getPdo();
            $result = DB::select("show tables", array());
            $databaseName = "Tables_in_" . DB::getDatabaseName();

            foreach($result as $key=>$row){
                if(!in_array($row->$databaseName, $ignoreTables) &&
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
            }
        }else if($GLOBALS["config"]["db_type"] == "sqlsrv"){
            $result = $GLOBALS["DB"]::select("SELECT * FROM INFORMATION_SCHEMA.TABLES");
            foreach($result as $key=>$row){
                if(!in_array($row->TABLE_NAME, $ignoreTables) &&
                   !preg_match("/^report/", $row->TABLE_NAME) &&
                   !preg_match("/report$/", $row->TABLE_NAME))
                    $tables[] = $row->TABLE_NAME;
            }

            foreach($tables as $tableName){
                $desc = DB::describe($tableName);
                $keys = 0;
                foreach($desc as $column)
                    if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
                        $keys++;
                if($keys == 3)
                    $tablesColumns[$tableName] = $desc;
            }
            $result = DB::select("SELECT * FROM INFORMATION_SCHEMA.TABLES");
            foreach($result as $key=>$row){
                if(!in_array($row->TABLE_NAME, $ignoreTables) &&
                   !preg_match("/^report/", $row->TABLE_NAME) &&
                   !preg_match("/report$/", $row->TABLE_NAME))
                    $tables[] = $row->TABLE_NAME;
            }

            foreach($tables as $tableName){
                $desc = DB::describe($tableName);
                $keys = 0;
                foreach($desc as $column)
                    if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
                        $keys++;
                if($keys == 3)
                    $tablesColumns[$tableName] = $desc;
            }
        }
        return $tablesColumns;
    }
    
    public static function getFuncOrProcDefinition($name){
        $names = [$name, $name . "1", $name . "2"];
        $dbName = strtolower(DB::getDatabaseName() == "EnterpriseNew" ? "Enterprise" : DB::getDatabaseName());
        $fname;
        //        echo $dbName;
        foreach($names as $name){
            $routineDef = DB::select("SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME=? AND ROUTINE_SCHEMA=?", [$name, $dbName]);
            if(count($routineDef)){
                $routineDef = $routineDef[0];
                $fname = $name;
                break;
            }                  
        }

        if($routineDef != null){
            $params = DB::select("SELECT * FROM INFORMATION_SCHEMA.PARAMETERS  WHERE SPECIFIC_SCHEMA=? AND SPECIFIC_NAME=?  ORDER BY ORDINAL_POSITION", [$dbName, $fname]);
            return [
                "definition" => $routineDef,
                "params" => $params
            ];
        }else
            return null;
    }

    public static function callProcedureOrFunction($name, $parameters, $returnRecords = false){
        $procDef = DB::getFuncOrProcDefinition($name);
        $dbName = DB::getDatabaseName() == "EnterpriseNew" ? "Enterprise" : DB::getDatabaseName();

        if($procDef == null){
            //echo "Procedure or Function doesn't exists";
            return null;
        }

        $paramsStr = [];
        $paramsArr = [];
        $outArr = [];
        //echo json_encode($procDef, JSON_PRETTY_PRINT);
        if($GLOBALS["config"]["db_type"] == "mysql"){
            //echo json_encode($procDef, JSON_PRETTY_PRINT);
            foreach($procDef["params"] as $param){
                if($param->PARAMETER_NAME != null){
                    $param->PARAMETER_NAME = preg_replace("/^v_/i", "", $param->PARAMETER_NAME);
                    if(key_exists($param->PARAMETER_NAME, $parameters)){
                        $paramsStr[] = "?";
                        $paramsArr[] = $parameters[$param->PARAMETER_NAME];
                    }else{
                        $paramsStr[] = "@" . $param->PARAMETER_NAME ;
                    }
                    if($param->PARAMETER_MODE == "INOUT")
                        $outArr[] = "@" . $param->PARAMETER_NAME;
                }
            }
            $paramsStr = implode(",", $paramsStr);
            $outStr = "";
            if($procDef["definition"]->ROUTINE_TYPE == "FUNCTION")
                $outArr[] = "@SWP_Ret_Value";
            foreach($outArr as $outVar)
                $outStr .= $outVar . " as " . preg_replace("/^@/i", "", $outVar) . ",";
            if($outStr != "")
                $outStr = substr($outStr, 0, -1);
            if($procDef["definition"]->ROUTINE_TYPE == "PROCEDURE")
                $records = DB::select("CALL {$procDef["definition"]->ROUTINE_NAME}($paramsStr)", $paramsArr);
            else
                DB::statement("SET @SWP_Ret_Value = {$procDef["definition"]->ROUTINE_NAME}($paramsStr)", $paramsArr);
            
            if($outStr != "")
                $result = DB::select("select $outStr")[0];
            else
                $result = (object) [];
            if(property_exists($result, "SWP_Ret_Value")){
                $result->ReturnValue = $result->SWP_Ret_Value;
                unset($result->SWP_Ret_Value);
            }
            //print_r($paramsStr);
            //print_r($paramsArr);
            //print_r($outStr);
            //print_r($result);
            if($returnRecords)
                $result->records = $records;
            
            return $result;
        }else if($GLOBALS["config"]["db_type"] == "sqlsrv"){
            $tableColumns = [];
            $declareStmt = "";
            $insertFields = [];
            foreach($procDef["params"] as $param){
                $param->PARAMETER_NAME = preg_replace("/^@/i", "", $param->PARAMETER_NAME);
                if(key_exists($param->PARAMETER_NAME, $parameters)){
                    $paramsStr[] = "?";
                    $paramsArr[] = $parameters[$param->PARAMETER_NAME];
                }else{
                    $paramsStr[] = "@" . $param->PARAMETER_NAME . " OUTPUT" ;
                }
                if($param->PARAMETER_MODE == "INOUT"){
                    $insertFields[] = $param->PARAMETER_NAME;
                    $outArr[] = "@" . $param->PARAMETER_NAME;
                    $declareStmt .= "DECLARE @" . ($tableColumns[] = $param->PARAMETER_NAME . " " . $param->DATA_TYPE . ($param->DATA_TYPE == "nvarchar" ? "({$param->CHARACTER_MAXIMUM_LENGTH})" : "")) . ";";
                }
            }
            $outArr[] = "@ReturnValue";
            $insertFields[] = "ReturnValue";
            $tableColumns[] = "ReturnValue INT";
            $declareStmt .= "DECLARE @ReturnValue INT;";
            $tableColumns = implode(",", $tableColumns);
            $tmpTableName = $procDef["definition"]->ROUTINE_NAME . "Result";
            $tmpTableStmt = "CREATE TABLE $tmpTableName ($tableColumns)";
            $insertFields = implode(",", $insertFields);
            $insertValues = implode(",", $outArr);
            $paramsStr = implode(",", $paramsStr);
            //echo "paramsStr: $paramsStr\n";
            //echo "paramsArr: " . json_encode($paramsArr, JSON_PRETTY_PRINT) . "\n";
            //echo "outArr: " .  json_encode($outArr, JSON_PRETTY_PRINT) . "\n";
            //print_r("tmpTableStmt : $tmpTableStmt \n");
            //print_r("declareStmt: $declareStmt \n");
            //print_r("insertFields: $insertFields \n");
            //print_r("insertValues: $insertValues \n");
            DB::statement("DROP TABLE IF EXISTS $tmpTableName");
            DB::statement($tmpTableStmt);
            //echo "$declareStmt EXEC $dbName.{$procDef["definition"]->ROUTINE_NAME} $paramsStr; insert into $tmpTableName ($insertFields) values ($insertValues);";
            if($procDef["definition"]->ROUTINE_TYPE == "PROCEDURE")
                if($returnRecords)
                    $records = DB::SELECT("EXEC enterprise.{$procDef["definition"]->ROUTINE_NAME} $paramsStr", $paramsArr);
                else
                    DB::statement("$declareStmt EXEC @ReturnValue = $dbName.{$procDef["definition"]->ROUTINE_NAME} $paramsStr; insert into $tmpTableName ($insertFields) values ($insertValues)", $paramsArr);
            else
                $records = DB::statement("$declareStmt SET @ReturnValue = $dbName.{$procDef["definition"]->ROUTINE_NAME}($paramsStr); insert into $tmpTableName ($insertFields) values ($insertValues)", $paramsArr);
           
            $result = DB::select("select * from $tmpTableName");
            if($result != null && count($result))
                $result = $result[0];
            else $result = (object)[];


            $result->records = $records;

            return $result;
        }
    }
}

//class for emulating global Session class from laravel
class Session{
    public static function get($key){
        return $_SESSION[$key];
    }
    public static function set($key, $value){
        return $_SESSION[$key] = $value;
    }
}

$connectionConfig = [
    "driver" => key_exists("db_type", $GLOBALS["config"]) ? $GLOBALS["config"]["db_type"] : "mysql" ,
    "host" => $GLOBALS["config"]["db_host"],
    "database" => $GLOBALS["config"]["db_base"],
    "username" => $GLOBALS["config"]["db_user"],
    "password" => $GLOBALS["config"]["db_password"],
    "charset" => "utf8",
    "collation" => "utf8_unicode_ci",
    "prefix" => ""
];

if(key_exists("db_ssl_cert", $GLOBALS["config"])){
    //    echo __DIR__ . "/" . $GLOBALS["config"]["db_ssl_cert"];
    $connectionConfig["sslmode"] = "require";
    $connectionConfig["options"] = [
        PDO::MYSQL_ATTR_SSL_KEY => __DIR__ . "/" . $GLOBALS["config"]["db_ssl_cert"]
    ];
}

$capsule->addConnection($connectionConfig);
$capsule->setAsGlobal();
?>
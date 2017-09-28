<?php
/*
Name of Page: Unlock model

Method: Model for gridView. It provides data from database and default values, column names and categories

Date created: Nikita Zaharov, 09.14.2017

Use: this model used by gridView for:
- as dictionary for view during building interface(tabs and them names, fields and them names etc, column name and translationid corresponding)
- for loading data from tables, updating, inserting and deleting

Input parameters:
$db: database instance
methods has own parameters

Output parameters:
- dictionaries as public properties
- methods has own output

Called from:
created and used for ajax requests by Grid controller
used as model by gridView

Calls:
sql

Last Modified: 09.28.2017
Last Modified by: Nikita Zaharov
*/

require __DIR__ . "/../../gridDataSource.php";

class gridData extends gridDataSource{
    public $dashboardTitle ="Unlock";
    public $breadCrumbTitle ="Unlock";
    protected $tableName = "lock";
    public $columnNames = [
        "GLTransactionNumber" => "Transaction Number",
        "GLTransactionTypeID" => "Type"
    ];

    public function unlockTables($EmployeeID){
        $user = Session::get("user");

        $result = DB::select("show tables", array());
        foreach($result as $key=>$row){
            if($row->Tables_in_myenterprise != "activeemployee" &&
               $row->Tables_in_myenterprise != "audittrail" &&
               $row->Tables_in_myenterprise != "translation" &&
               $row->Tables_in_myenterprise != "translations" &&
               $row->Tables_in_myenterprise != "dtproperties" &&
               $row->Tables_in_myenterprise != "gl detail by date" &&
               $row->Tables_in_myenterprise != "gl details" &&
               !preg_match("/history$/", $row->Tables_in_myenterprise) &&
               !preg_match("/^audit/", $row->Tables_in_myenterprise) &&
               !preg_match("/^report/", $row->Tables_in_myenterprise) &&
               !preg_match("/report$/", $row->Tables_in_myenterprise))
            $tables[] = $row->Tables_in_myenterprise;
        }

        foreach($tables as $tableName){
            $desc = DB::select("describe $tableName", array());
            $keys = 0;
            foreach($desc as $column)
                if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID" || $column->Field == "LockedBy")
                    $keys++;
            if($keys == 4)
                $tablesColumns[$tableName] = $desc;
        }

        foreach($tablesColumns as $tableName=>$desc){
            try{
                DB::update("update $tableName set LockedBy=NULL, LockTS=NULL WHERE CompanyID=? and DivisionID=? and DepartmentID=?" . ( $EmployeeID != "DEFAULT" ? " and LockedBy=?" : ""), array($user["CompanyID"], $user["DivisionID"], $user["DepartmentID"], $EmployeeID));
            }catch(\Exception $e){
                echo $e->getMessage() . "\n";
            }
        }
    }
    
    public function unlockSelected(){
        $this->unlockTables($_POST["EmployeeID"]);
    }

    public function unlockAll(){
        $this->unlockTables("DEFAULT");
    }
}
?>

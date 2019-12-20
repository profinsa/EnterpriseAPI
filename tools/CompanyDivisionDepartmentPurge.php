<?php
//config name to use
$GLOBALS["configName"] = "common_clean"; 
include './init.php';

///////////////////////////
//script parameters
/*name of config to use. Can be on of:
- common 
  uses enterprise database,
- common_clean 
  uses cleanenterprise
- STFBEnterprise 
  uses stfbenterprise database
*/

//CompanyID for deleting records
$CompanyID = 'AMultiNational';
//DivisionID for deleting records
$DivisionID = 'Florida';
//DepartmentID for deleting records
$DepartmentID = 'Test';


//////////////////////////////
//code for deleting records
$tablesColumns = [];
$companies = [];
foreach($tables as $tableName){
    $desc = DB::select("describe $tableName", array());
    $keys = 0;
    foreach($desc as $column)
        if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
            $keys++;
    if($keys == 3)
        $tablesColumns[$tableName] = $desc;
}

$whereBlock = "CompanyID='$CompanyID' AND DivisionID='$DivisionID' AND DepartmentID='$DepartmentID'";

foreach($tablesColumns as $tableName=>$desc){
    $deleteStr = "delete from $tableName where $whereBlock";
    DB::delete($deleteStr);
    echo $deleteStr . "\t[done]\n";
}
?>
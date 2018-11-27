<?php
include "../init.php";
$pdo = DB::connection()->getPdo();
$result = DB::select("show tables", array());
foreach($result as $key=>$row){
    if($row->Tables_in_myenterprise != "activeemployee" &&
       $row->Tables_in_myenterprise != "translation" &&
       $row->Tables_in_myenterprise != "translations" &&
       $row->Tables_in_myenterprise != "dtproperties" &&
       $row->Tables_in_myenterprise != "gl detail by date" &&
       $row->Tables_in_myenterprise != "gl details" &&
       $row->Tables_in_myenterprise != "customerhistorytransactions" &&
       $row->Tables_in_myenterprise != "customertransactions" &&
       $row->Tables_in_myenterprise != "itemhistorytransactions" &&
       $row->Tables_in_myenterprise != "itemtransactions" &&
       $row->Tables_in_myenterprise != "jointpaymentsdetail" &&
       $row->Tables_in_myenterprise != "jointpaymentsheader" &&
       $row->Tables_in_myenterprise != "payrollcommision" &&
       $row->Tables_in_myenterprise != "projecthistorytransactions" &&
       $row->Tables_in_myenterprise != "projecttransactions" &&
       $row->Tables_in_myenterprise != "vendorhistorytransactions" &&
       $row->Tables_in_myenterprise != "vendortransactions" &&
       !preg_match("/^report/", $row->Tables_in_myenterprise) &&
       !preg_match("/report$/", $row->Tables_in_myenterprise))
        $tables[] = $row->Tables_in_myenterprise;
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
?>
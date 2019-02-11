<?php
include "../init.php";
$pdo = DB::connection()->getPdo();
$result = DB::select("show tables", array());
$databaseName = "Tables_in_" . $config["db_base"];
foreach($result as $key=>$row){
    if($row->$databaseName != "activeemployee" &&
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

echo json_encode($tablesColumns, JSON_PRETTY_PRINT);
?>
<?php
include './init.php';

foreach($tables as $tableName){
    $desc = DB::select("describe $tableName", array());
    $keys = 0;
    foreach($desc as $column)
        if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
            $keys++;
    if($keys == 3)
        $tablesColumns[$tableName] = $desc;
}


foreach($tablesColumns as $tableName=>$desc){
    $deleteStr = "delete from $tableName where CompanyID='DINOS' AND DivisionID != 'DEFAULT' AND DepartmentID != 'PAYROLL'";
    DB::delete($deleteStr);
    echo $deleteStr . "\t[done]\n";
}
?>
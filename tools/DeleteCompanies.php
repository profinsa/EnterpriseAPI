<?php
include './init.php';

$companies = ['Lomor', 'TestCompany2'];
foreach($tables as $tableName){
    $desc = DB::select("describe $tableName", array());
    $keys = 0;
    foreach($desc as $column)
        if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
            $keys++;
    if($keys == 3)
        $tablesColumns[$tableName] = $desc;
}

$whereBlock = "";
$whereParts = [];
echo json_encode($companies);
if(count($companies)){
    foreach($companies as $company)
        $whereParts[] = "CompanyID='$company'";

    $whereBlock = implode(" OR ", $whereParts);

    foreach($tablesColumns as $tableName=>$desc){
        $deleteStr = "delete from $tableName where $whereBlock";
        DB::delete($deleteStr);
        echo $deleteStr . "\t[done]\n";
    }

    DB::delete("delete from audittrail where CompanyID!='DINOS' && CompanyID != 'DEFAULT' && CompanyID != 'DEMO'");
}
?>
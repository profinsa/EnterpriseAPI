<?php
include './init.php';

$companiesStr = "2,3,102";
$companies = explode(",",$companiesStr);
$companies = '';
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
if($companies != ""){
    foreach($companies as $company)
        $whereParts[] = "CompanyID='$company'";
}else{
    $companies = DB::select("select CompanyID from companies");
    foreach($companies as $company)
        if($company->CompanyID != 'DEFAULT' &&
           $company->CompanyID != 'Demo' &&
           $company->CompanyID != 'DINOS')
            $whereParts[] = "CompanyID='{$company->CompanyID}'";
}
$whereBlock = implode(" OR ", $whereParts);

//echo $whereBlock;
foreach($tablesColumns as $tableName=>$desc){
    $deleteStr = "delete from $tableName where $whereBlock";
    //    DB::delete($deleteStr);
    echo $deleteStr . "\t[done]\n";
}
//echo json

//DB::delete("delete from auditlogin where LoginDateTime < NOW() - INTERVAL $howManyDays DAY AND CompanyID='$CompanyID' AND DivisionID='$DivisionID' AND DepartmentID='$DepartmentID'");
?>
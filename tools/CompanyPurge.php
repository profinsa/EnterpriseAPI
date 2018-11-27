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
    $companiesDb = DB::select("select CompanyID from companies");
    $companies = [];
    foreach($companiesDb as $company)
        if($company->CompanyID != 'DEFAULT' &&
           $company->CompanyID != 'DEMO' &&
           $company->CompanyID != 'DINOS' &&
           in_array($company->CompanyID, $companies) != true)
            $companies[] = $company->CompanyID;
    foreach($companies as $company)
        $whereParts[] = "CompanyID='$company'";
}
$whereBlock = implode(" OR ", $whereParts);

foreach($tablesColumns as $tableName=>$desc){
    $deleteStr = "delete from $tableName where $whereBlock";
    DB::delete($deleteStr);
    echo $deleteStr . "\t[done]\n";
}

DB::delete("delete from audittrail where CompanyID!='DINOS' && CompanyID != 'DEFAULT' && CompanyID != 'DEMO'");
?>
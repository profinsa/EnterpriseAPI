<?php
include './init.php';

//$companiesStr = "Test";
//$companiesStr = '';
//$companies = explode(",",$companiesStr);
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

$fields = [];
//echo json_encode($tablesColumns["orderheader"], JSON_PRETTY_PRINT);
foreach($tablesColumns as $name=>$desc)
    foreach($desc as $columnDesc)
        if($columnDesc->Type == "datetime" || $columnDesc->Type == "timestamp"){
            $columnDesc->tableName = $name;
            $fields[$columnDesc->Field] = $columnDesc;
        }
echo count($fields);
//echo json_encode($fields, JSON_PRETTY_PRINT);
/*
$whereBlock = "";
$whereParts = [];
echo json_encode($companies);
if(count($companies)){
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
*/
?>
<?php
include './init.php';

$columnIgnoreList = [
    "LockTS",
    "LoginDateTime",
    "EntryDate",
    "EntryTime",
    "SystemDate",
    "CreditCardExpDate",
    "CustomerBornDate",
    "HireDate",
    "Birthday",
    "LastSessionUpdateTime"
];
$tableIgnoreList = [
    "companies",
    "audittrail",
    "audittraishistory",
    "currencytypes",
    "currencytypeshistory",
    "errorlog",
    "ledgerchartofaccountsprioryears",
    "ledgerstoredchartofaccounts"
];

$tablesColumns = [];
foreach($tables as $tableName){
    $desc = DB::select("describe $tableName", array());
    $keys = 0;
    foreach($desc as $column)
        if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
            $keys++;
    if($keys == 3 && !in_array($tableName, $tableIgnoreList))
        $tablesColumns[$tableName] = $desc;
    else
        echo "Ignoring table $tableName\n";
}

$fields = [];
//echo json_encode($tablesColumns["orderheader"], JSON_PRETTY_PRINT);
foreach($tablesColumns as $name=>$desc){
    foreach($desc as $columnDesc)
        if($columnDesc->Type == "datetime" || $columnDesc->Type == "timestamp"){
            $columnDesc->tableName = $name;
            if(!in_array($columnDesc->Field, $columnIgnoreList))
                $fields[$columnDesc->Field] = $columnDesc;
            //            else
            //  echo "Ignoring column {$columnDesc->Field}\n";
            //$fields[] = $columnDesc;
        }
}
file_put_contents("fields.json", json_encode($fields, JSON_PRETTY_PRINT));

foreach($tablesColumns as $name=>$desc){
    $columns = [];
    foreach($desc as $columnDesc)
        if(($columnDesc->Type == "datetime" || $columnDesc->Type == "timestamp") &&
           !in_array($columnDesc->Field, $columnIgnoreList))
            $columns[] = $columnDesc->Field;
    if(count($columns)){
        $result = DB::select("select " . implode(",", $columns) . " from $name");
        if(count($result))
            echo "processing $name\n";
        else
            echo "table $name is empty\n";
    }
}
//echo count($tablesColumns);
//echo count($fields);
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
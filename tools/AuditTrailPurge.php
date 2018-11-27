<?php
include './init.php';

$howManyDays = 1; //how many days data need to keep, by default 1 day
$whereBlock = "";
$whereParts = [];
if(count($argv) == 1)
    echo "WRONG : missed arguments";
else if(count($argv) == 2){
    if($argv[1] == "ALL"){
        $companies = DB::select("select CompanyID from companies");
        foreach($companies as $company)
            if($company->CompanyID != 'DEFAULT' &&
               $company->CompanyID != 'Demo' &&
               $company->CompanyID != 'DINOS')
                $whereParts[] = "CompanyID='{$company->CompanyID}'";
        $whereBlock = implode(" OR ", $whereParts);
    }
}else if(count($argv) == 4){
    $CompanyID = $argv[1];
    $DivisionID = $argv[2];
    $DepartmentID = $argv[3];
    $whereBlock = "CompanyID='$CompanyID' AND DivisionID='$DivisionID' AND DepartmentID='$DepartmentID'"; 
}

if($whereBlock != ""){
file_put_contents("AuditTrail.json", json_encode(DB::select("SELECT * from audittrail where EntryDate < NOW() - INTERVAL $howManyDays DAY AND $whereBlock", array()), JSON_PRETTY_PRINT), FILE_APPEND);
DB::delete("delete from audittrail where EntryDate < NOW() - INTERVAL $howManyDays DAY AND $whereBlock");
} else {
    echo "there is no companies to delete from audittrail\n";
}
?>
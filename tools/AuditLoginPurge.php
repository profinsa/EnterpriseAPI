<?php
include './init.php';

$howManyDays = 1; //how many days data need to keep, by default 1 day
$whereBlock = "";
$whereParts = [];
if(count($argv) == 1)
    echo "WRONG : missed arguments";
else if(count($argv) == 2){
    if($argv[1] == "ALL"){
        $companiesDb = DB::select("select CompanyID from companies");
        $companies = [];
        foreach($companies as $company)
            if($company->CompanyID != 'DEFAULT' &&
               $company->CompanyID != 'DEMO' &&
               $company->CompanyID != 'DINOS' &&
               in_array($company->CompanyID, $companies) != true)
                $companies[] = $company->CompanyID;
        foreach($companies as $company)
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
    file_put_contents("AuditLogin.json", json_encode(DB::select("SELECT * from auditlogin where LoginDateTime < NOW() - INTERVAL $howManyDays DAY AND $whereBlock", array()), JSON_PRETTY_PRINT), FILE_APPEND);
    DB::delete("delete from auditlogin where LoginDateTime < NOW() - INTERVAL $howManyDays DAY AND $whereBlock");
    echo "work is done!\n";
} else {
    echo "there is no companies to delete from auditlogin\n";
}
?>
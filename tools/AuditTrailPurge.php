<?php
include '../init.php';

$howManyDays = 1; //how many days data need to keep, by default 1 day
$CompanyID = "DINOS";
$DivisionID = "DEFAULT";
$DepartmentID = "DEFAULT";

file_put_contents("AuditTrail.json", json_encode(DB::select("SELECT * from audittrail where EntryDate < NOW() - INTERVAL $howManyDays DAY AND CompanyID='$CompanyID' AND DivisionID='$DivisionID' AND DepartmentID='$DepartmentID'", array()), JSON_PRETTY_PRINT), FILE_APPEND);
DB::delete("delete from audittrail where EntryDate < NOW() - INTERVAL $howManyDays DAY AND CompanyID='$CompanyID' AND DivisionID='$DivisionID' AND DepartmentID='$DepartmentID'");

?>
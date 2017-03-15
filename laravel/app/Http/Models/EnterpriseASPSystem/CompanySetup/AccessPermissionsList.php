<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "accesspermissions";
public $gridFields =["EmployeeID","SecurityLevel"];
public $dashboardTitle ="Access Permissions";
public $breadCrumbTitle ="Access Permissions";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultPageToDisplay" => [
"inputType" => "text",
"defaultValue" => ""
],
"MachineName" => [
"inputType" => "text",
"defaultValue" => ""
],
"RestrictMultipleLogins" => [
"inputType" => "text",
"defaultValue" => ""
],
"IPAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"RestrictSecurityIP" => [
"inputType" => "text",
"defaultValue" => ""
],
"SecurityLevel" => [
"inputType" => "text",
"defaultValue" => ""
],
"OEView" => [
"inputType" => "text",
"defaultValue" => ""
],
"OEAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"OEEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"OEDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"OEReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"OESetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"ARView" => [
"inputType" => "text",
"defaultValue" => ""
],
"ARAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"AREdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ARDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"ARReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"ARSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"POView" => [
"inputType" => "text",
"defaultValue" => ""
],
"POAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"POEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"PODelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"POReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"POSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"APView" => [
"inputType" => "text",
"defaultValue" => ""
],
"APAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"APEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"APDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"APChecks" => [
"inputType" => "text",
"defaultValue" => ""
],
"APReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"APSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLView" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFinancials" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLMonthEnd" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLYearEnd" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMView" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"EMSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRView" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"PREdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRChecks" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"PRSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHPick" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHPack" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHShip" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHPrint" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHReceive" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHTransfer" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHAdjust" => [
"inputType" => "text",
"defaultValue" => ""
],
"WHSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOView" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"WODelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOForecast" => [
"inputType" => "text",
"defaultValue" => ""
],
"WOSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"ADView" => [
"inputType" => "text",
"defaultValue" => ""
],
"ADSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"ADSecurity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeView" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"ChallangeSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditView" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditAdd" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditEdit" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditDelete" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditReports" => [
"inputType" => "text",
"defaultValue" => ""
],
"AuditSetup" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveCustomer" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveVendor" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePurchase" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveTransfer" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveAdjustment" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveReceipt" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovePayroll" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveAPChedks" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveEmployees" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveItems" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveLowMargins" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveOrders" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveContract" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveReturns" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApproveRMA" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTARView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTAPView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTGLView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTInventoryView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTMRPView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTFundView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTCRMView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTPayrollView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTSystemView" => [
"inputType" => "text",
"defaultValue" => ""
],
"MTReportsView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTFinancialView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTARView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTAPView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTGLView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTInventoryView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTCRMView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTPayrollView" => [
"inputType" => "text",
"defaultValue" => ""
],
"RTSystemView" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"SecurityLevel" => "Security Level",
"DefaultPageToDisplay" => "DefaultPageToDisplay",
"MachineName" => "MachineName",
"RestrictMultipleLogins" => "RestrictMultipleLogins",
"IPAddress" => "IPAddress",
"RestrictSecurityIP" => "RestrictSecurityIP",
"OEView" => "OEView",
"OEAdd" => "OEAdd",
"OEEdit" => "OEEdit",
"OEDelete" => "OEDelete",
"OEReports" => "OEReports",
"OESetup" => "OESetup",
"ARView" => "ARView",
"ARAdd" => "ARAdd",
"AREdit" => "AREdit",
"ARDelete" => "ARDelete",
"ARReports" => "ARReports",
"ARSetup" => "ARSetup",
"POView" => "POView",
"POAdd" => "POAdd",
"POEdit" => "POEdit",
"PODelete" => "PODelete",
"POReports" => "POReports",
"POSetup" => "POSetup",
"APView" => "APView",
"APAdd" => "APAdd",
"APEdit" => "APEdit",
"APDelete" => "APDelete",
"APChecks" => "APChecks",
"APReports" => "APReports",
"APSetup" => "APSetup",
"GLView" => "GLView",
"GLAdd" => "GLAdd",
"GLEdit" => "GLEdit",
"GLDelete" => "GLDelete",
"GLReports" => "GLReports",
"GLFinancials" => "GLFinancials",
"GLMonthEnd" => "GLMonthEnd",
"GLYearEnd" => "GLYearEnd",
"GLSetup" => "GLSetup",
"EMView" => "EMView",
"EMAdd" => "EMAdd",
"EMEdit" => "EMEdit",
"EMDelete" => "EMDelete",
"EMReports" => "EMReports",
"EMSetup" => "EMSetup",
"PRView" => "PRView",
"PRAdd" => "PRAdd",
"PREdit" => "PREdit",
"PRDelete" => "PRDelete",
"PRChecks" => "PRChecks",
"PRReports" => "PRReports",
"PRSetup" => "PRSetup",
"WHPick" => "WHPick",
"WHPack" => "WHPack",
"WHShip" => "WHShip",
"WHPrint" => "WHPrint",
"WHReceive" => "WHReceive",
"WHTransfer" => "WHTransfer",
"WHAdjust" => "WHAdjust",
"WHSetup" => "WHSetup",
"WOView" => "WOView",
"WOAdd" => "WOAdd",
"WOEdit" => "WOEdit",
"WODelete" => "WODelete",
"WOReports" => "WOReports",
"WOForecast" => "WOForecast",
"WOSetup" => "WOSetup",
"ADView" => "ADView",
"ADSetup" => "ADSetup",
"ADSecurity" => "ADSecurity",
"ChallangeView" => "ChallangeView",
"ChallangeAdd" => "ChallangeAdd",
"ChallangeEdit" => "ChallangeEdit",
"ChallangeDelete" => "ChallangeDelete",
"ChallangeReports" => "ChallangeReports",
"ChallangeSetup" => "ChallangeSetup",
"AuditView" => "AuditView",
"AuditAdd" => "AuditAdd",
"AuditEdit" => "AuditEdit",
"AuditDelete" => "AuditDelete",
"AuditReports" => "AuditReports",
"AuditSetup" => "AuditSetup",
"ApproveCustomer" => "ApproveCustomer",
"ApproveVendor" => "ApproveVendor",
"ApprovePayment" => "ApprovePayment",
"ApprovePurchase" => "ApprovePurchase",
"ApproveTransfer" => "ApproveTransfer",
"ApproveAdjustment" => "ApproveAdjustment",
"ApproveReceipt" => "ApproveReceipt",
"ApprovePayroll" => "ApprovePayroll",
"ApproveAPChedks" => "ApproveAPChedks",
"ApproveEmployees" => "ApproveEmployees",
"ApproveItems" => "ApproveItems",
"ApproveLowMargins" => "ApproveLowMargins",
"ApproveOrders" => "ApproveOrders",
"ApproveContract" => "ApproveContract",
"ApproveReturns" => "ApproveReturns",
"ApproveRMA" => "ApproveRMA",
"MTARView" => "MTARView",
"MTAPView" => "MTAPView",
"MTGLView" => "MTGLView",
"MTInventoryView" => "MTInventoryView",
"MTMRPView" => "MTMRPView",
"MTFundView" => "MTFundView",
"MTCRMView" => "MTCRMView",
"MTPayrollView" => "MTPayrollView",
"MTSystemView" => "MTSystemView",
"MTReportsView" => "MTReportsView",
"RTFinancialView" => "RTFinancialView",
"RTARView" => "RTARView",
"RTAPView" => "RTAPView",
"RTGLView" => "RTGLView",
"RTInventoryView" => "RTInventoryView",
"RTCRMView" => "RTCRMView",
"RTPayrollView" => "RTPayrollView",
"RTSystemView" => "RTSystemView"];
}?>
